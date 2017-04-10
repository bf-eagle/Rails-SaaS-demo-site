class ContactMailer < ActionMailer::Base
    default to: 'scott@scottgriffis.com'
    
    def contact_email(name, email, body)
        @name = name
        @email = email
        @body = body
        
        mail(from: email, subject: 'Contact form Message')
    end
    
end

    
    