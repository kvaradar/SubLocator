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


      def set_current_date(number_of_days = 0)
        (DateTime.now + number_of_days).strftime("%Y-%m-%dT%H:%M:%S%Z")
      end

      def want_to_sub
        w = WantToSub.all
        puts w.where("slot >?",set_current_date()).to_json
        parsed = JSON.parse(w.where("slot >?",set_current_date()).to_json,:symbolize_names=>true)
        name_list = []
        parsed.each do |name|
          puts "name is #{name}"
          name_list << name[:name_id]
        end

        puts "name list is #{name_list}"
        want_to_sub = []
        name_list.each do |id|
          want_to_sub << Name.find_by_id(id)
        end
        puts "want to sub are #{want_to_sub}"
         want_to_sub.to_json
      end


    end

    helpers NameHelper

  end

  end



