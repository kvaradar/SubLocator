# Helper methods defined here can be accessed in any controller or view in the application

module SubLocator
  class App
    module NameHelper
     def verify_email(email)
       flag = false
       record = Name.all
       hashed=record.to_json
       parsed = JSON.parse(hashed,:symbolize_names=>true)
       puts "parsed is #{parsed}"
       parsed.each do |name|
         puts "name is #{name}"
         puts "names are #{name[:name]}"
         if email.downcase == name[:name].downcase
           flag = true
       end
       end

       if flag == true
         return true
       else
         return false
       end




     end
    end

    helpers NameHelper

  end

  end



