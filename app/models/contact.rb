# == Schema Information
#
# Table name: contacts
#
#  id              :integer          not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  vid             :integer          not null
#  lifecycle       :string
#  trial_join_date :date
#  trial_type      :string
#  customer_stage  :string
#  purchase_date   :date
#  account_type    :string
#

class Contact < ActiveRecord::Base

	

	def self.populate_from_update_list
		self.populate_contact_list("https://api.hubapi.com/contacts/v1/lists/3690/contacts/all?hapikey=0c780907-df7a-4296-8128-701f8b15422b&count=100")
	end

	
	def self.populate_contact_list(url)
		contact_list = []
		has_more = true
		offset = ""
		while has_more do
		  response = JSON.parse(open(url+offset).read)
		  has_more = response["has-more"]
		  if has_more
		  	offset = "&vidOffset="+response["vid-offset"].to_s
		  end
		  response["contacts"].each do |hs_contact|
		  	contact = Contact.new
		  	contact.vid = hs_contact["canonical-vid"]
		  	contact_list << contact
		  end
		end
		update_entries(contact_list)
		retur contact_list
	end

	def self.update_entries(contact_list)
		num = 1
		contact_list.each do |hs_contact|
			contact = Contact.where(:vid => hs_contact.vid).first_or_create
			logger.debug("processing "+num.to_s)
			num +=1
			response = JSON.parse(open("https://api.hubapi.com/contacts/v1/contact/vid/"+contact.vid.to_s+"/profile?hapikey=0c780907-df7a-4296-8128-701f8b15422b").read)
			form_submissions = response["form-submissions"]
			hs_properties = response["properties"]
			form_submissions.each do |submission|
				if submission["form-id"] == "cde0f9ee-ad96-4b67-987f-c2f22b9cc68d" || submission["form-id"] == "ecb642e3-11f3-44e7-bbc7-31632cf30ee0"
					form_signup_date = (submission["timestamp"].to_f/1000).to_s
					contact.trial_join_date = Date.strptime(form_signup_date, '%s')
					break
				end
			end
			contact.lifecycle = hs_properties["lifecyclestage"]["value"]
			if hs_properties["wevideo_trial"]
				contact.trial_type = hs_properties["wevideo_trial"]["value"]
			end
			if hs_properties["customer_stage"]
				contact.customer_stage = hs_properties["customer_stage"]["value"]
			end
			if hs_properties["orderdate"]
				contact.purchase_date = hs_properties["orderdate"]["value"]
			end
			if hs_properties["main_product_code"]
				contact.account_type = hs_properties["main_product_code"]["value"]
			end
			contact.save
		end
	end
	


end
