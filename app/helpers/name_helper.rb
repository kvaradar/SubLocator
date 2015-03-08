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
        slot = WantToSub.where("slot >?",set_current_date())
        name_list = []
        slotty_hash = Hash.new{|hsh,key|hsh[key]=[]}

        slot.each do |find|
          unless name_list.include? find.name_id
            name_list << find.name_id
          end
          slotty_hash[find.name_id].push find.slot
        end

        puts "name list is #{name_list}"
        puts "slotty hash is #{slotty_hash}"

        complete_list = []

        name_list.each do |name_id|
          n = Name.find_by_id(name_id)
          complete_list << n
          complete_list << "slot"
          complete_list << slotty_hash[name_id]
        end
        puts "complete list is #{complete_list}"
        complete_list.to_json
      end


      def need_a_sub
        slot = NeedASub.where("slot >?",set_current_date())
        name_list = []
        slotty_hash = Hash.new{|hsh,key|hsh[key]=[]}

        slot.each do |find|
          unless name_list.include? find.name_id
            name_list << find.name_id
          end
          slotty_hash[find.name_id].push find.slot
        end

        puts "name list is #{name_list}"
        puts "slotty hash is #{slotty_hash}"

        complete_list = []

        name_list.each do |name_id|
          n = Name.find_by_id(name_id)
          complete_list << n
          complete_list << "slot"
          complete_list << slotty_hash[name_id]
        end
        puts "complete list is #{complete_list}"
        complete_list.to_json
      end

    end

    helpers NameHelper

  end

  end



