class ContactsController < ApplicationController

	

	def reset
		Contact.delete_all
		@contact_list = Contact.populate_contact_list("https://api.hubapi.com/contacts/v1/lists/3684/contacts/all?hapikey=0c780907-df7a-4296-8128-701f8b15422b&count=100")
	end

	def modify
		@contact_list = Contact.populate_contact_list("https://api.hubapi.com/contacts/v1/lists/3690/contacts/all?hapikey=0c780907-df7a-4296-8128-701f8b15422b&count=100")
	end


	
end
