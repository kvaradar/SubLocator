# Helper methods defined here can be accessed in any controller or view in the application

module SubLocator
  class App
    module NameHelper
     def verify_email(email)
       record = Name.all
       hashed=record.to_json
       parsed = JSON.parse(hashed)
       parsed.each do |name|
         puts "names are #{name["first_name"]}"
         if email.downcase == name["first_name"].downcase
           return true
         else
           return false

         end

       end
     end




    end

    helpers NameHelper
  end
end



