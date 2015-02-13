class ContactsController < ApplicationController

	require 'open-uri'

	def index
		@contact_list = []
		has_more = true
		offset = ""
		while has_more do
		  response = JSON.parse(open("https://api.hubapi.com/contacts/v1/lists/3684/contacts/all?hapikey=0c780907-df7a-4296-8128-701f8b15422b&count=100"+offset).read)
		  has_more = response["has-more"]
		  if has_more
		  	offset = "&vidOffset="+response["vid-offset"].to_s
		  end
		  response["contacts"].each do |hs_contact|
		  	contact = Contact.new
		  	contact.vid = hs_contact["canonical-vid"]
		  	@contact_list << contact
		  end
		end
		 	# @contact_list = []
		 	# contact = Contact.new
		  # 	contact.vid = 2483
		  #  	@contact_list << contact

		@contact_list.each do |contact|
			response = JSON.parse(open("https://api.hubapi.com/contacts/v1/contact/vid/"+contact.vid.to_s+"/profile?hapikey=0c780907-df7a-4296-8128-701f8b15422b").read)
			form_submissions = response["form-submissions"]
			hs_contact = response["properties"]
			form_submissions.each do |submission|
				if submission["form-id"] == "cde0f9ee-ad96-4b67-987f-c2f22b9cc68d" || submission["form-id"] == "ecb642e3-11f3-44e7-bbc7-31632cf30ee0"
					contact.trial_join_date = submission["timestamp"]
					break
				end
			end
			contact.lifecycle = hs_contact["lifecyclestage"]["value"]
			if hs_contact["wevideo_trial"]
				contact.trial_type = hs_contact["wevideo_trial"]["value"]
			end
			if hs_contact["customer_stage"]
				contact.customer_stage = hs_contact["customer_stage"]["value"]
			end
			if hs_contact["orderdate"]
				contact.purchase_date = hs_contact["orderdate"]["value"]
			end
			if hs_contact["main_product_code"]
				contact.account_type = hs_contact["main_product_code"]["value"]
			end
		end

	end
end
