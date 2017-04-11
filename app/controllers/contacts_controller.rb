class ContactsController < ApplicationController
    #GET request to /contact-us
    #show new contact form
    def new
        @contact = Contact.new
    end


    #Post request to /contacts
    def create
        #mass assignments to form fields of Contact object
        @contact = Contact.new(contact_params)
        #Save the Contact object to the database
        if @contact.save
            #store form fields via paramaters into variables
            name = params[:contact][:name]
            email = params[:contact][:email]
            body = params[:contact][:comments]
            #Plug variables into Contact Mailer
            #email method and send e-mail
            ContactMailer.contact_email(name, email, body).deliver
            #store success message in flash hash
            #and redirect to new action
            flash[:success] = "Message sent"
            redirect_to new_contact_path
        else
            #if Contact object doesn't save
            #store errors in flash hash and redirect to new action
            flash[:danger] = @contact.errors.full_messages.join(", ")
             redirect_to new_contact_path
        end
    end
    
    private
        #to collect data from form we need to use strong parameters
        #and whitelist the form fields
        def contact_params
            params.require(:contact).permit(:name, :email, :comments)
        end
        
end


