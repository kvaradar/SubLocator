
SubLocator::App.controllers :name do
  
  # get :index, :map => '/foo/bar' do
  #   session[:foo] = 'bar'
  #   render 'index'
  # end

  # get :sample, :map => '/sample/url', :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   'Maps to url '/foo/#{params[:id]}''
  # end

  # get '/example' do
  #   'Hello world!'
  # end
  
get '/teacher_list/:name' do
  
  @teacher = Name.find_by_first_name(params[:name])
  render 'name/teacher' #record.to_json

end

#
# get '/teacher_list/'do
#   record = Name.all
#   hashed=record.to_json
#   parsed = JSON.parse(hashed)
#   parsed.each do |name|
#     puts "names are #{name["first_name"]}"
#     name["first_name"]
#   end
# end




  get '/email' do
    params[:email_id]
    flag = verify_email(params[:email_id])
    if flag == true
      status 200
      return (Name.find_by_email_id(params[:email_id])).to_json
    else

      status 400
      return "BOOHOO. Not reg'd as a MADSTER, sucker!"
    end
   # params.to_json
    #request.body.to_json
  end


  get '/sub_details'do

    n = Name.find_by_email_id(params[:email_id])
    return n.to_json
  end


  post '/generate_sub_profile' do

    req = JSON.parse(request.body.read,:symbolize_names=>true)
    n = Name.find_by_email_id(req[:email_id])
    n.need_a_sub = NeedASub.find_by_name_id(n.id)
    puts "needs a sub is #{n.need_a_sub}"

    if n.need_a_sub.nil?

      n.need_a_sub = NeedASub.new
    #  puts "sub details are #{n.to_json}"
      n.to_json
    else

       all_subs = NeedASub.all
       # change this to want to sub
       puts "all_subs is #{all_subs}"
       sub_array = []
       all_subs.each do |name|
         puts "People who want to sub are"
         puts (Name.find_by_id(name.name_id)).to_json
         sub_array<< (Name.find_by_id(name.name_id)).to_json
       end

      sub_array

    end

  end

  post '/generate_wannabe_profile'  do
    req = JSON.parse(request.body.read,:symbolize_names=>true)
    w = Name.find_by_email_id(req[:email_id])
    w.want_to_sub = WantToSub.find_by_name_id(w.id)
    if w.want_to_sub.nil?
      w.want_to_sub = WantToSub.new
     # puts "want to sub are #{w.to_json}"
      w.to_json
    else
      want_subs = WantToSub.all
      want_array = []
      want_subs.each do |want|
        puts "people who want to sub are "
        puts (Name.find_by_id(want.name_id)).to_json
        want_array<<(Name.find_by_id(want.name_id)).to_json

      end

      want_array
    end

  end

  post '/need_a_sub' do
     date = set_current_date()
     puts "date is #{date}"
    if WantToSub.where("slot >?",date).blank?
   #   return "Nobody wants to sub for you"
      return False
    else
      want_to_sub
    end
  end

 post '/generate_needy_request' do
   # request has to entail date,email
   req = JSON.parse(request.body.read,:symbolize_names=>true)
   n = Name.find_by_email_id(req[:email_id])
   # validate that same slot does not exist again
   find_slot = NeedASub.where(["slot >:slot and name_id = :name_id",{:slot=>"#{set_current_date()}",:name_id=>"#{n.id}"}])
   puts "find slot is #{find_slot}"
   find_slot.each do |slot|
     puts "slot request is #{Date.parse(slot.slot.to_s)}"
     puts "req is #{req[:slot]}"
     if Date.parse(slot.slot.to_s)== Date.parse(req[:slot].to_s)
   #   return "You've already requested a sub for slot #{Date.parse(slot.slot.to_s)}. Stop being so needy"
       return False
     end
   end
   n.need_a_sub += [NeedASub.new(:slot => req[:slot])]
   puts "needs a sub is #{n.need_a_sub}"
    n.need_a_sub.to_json

 end

  post '/want_to_sub' do
    # Gets a list of all the people who need subs
     needy_people = NeedASub.all
     date = needy_people.where("slot >?",set_current_date())
    if date.nil?
    #  return "It's a Christmas Miracle! Nobody needs a sub!"
      return False
    end
    need_a_sub
  end

  post '/generate_wanty_request'do
    # request body has email id and slot details
    req = JSON.parse(request.body.read,:symbolize_names=>true)
    n = Name.find_by_email_id(req[:email_id])
    find_slot = WantToSub.where(["slot >:slot and name_id = :name_id",{:slot=>"#{set_current_date()}",:name_id=>"#{n.id}"}])
    puts "find slot is #{find_slot}"
    find_slot.each do |slot|
      puts "slot request is #{Date.parse(slot.slot.to_s)}"
      puts "req is #{req[:slot]}"
      if Date.parse(slot.slot.to_s)== Date.parse(req[:slot].to_s)
     #   return "You're already subbing for slot #{Date.parse(slot.slot.to_s)}. Stop being over-helpful"
      return False
      end
    end
    n.want_to_sub += [WantToSub.new(:slot => req[:slot])]
    puts "want to sub is #{n.want_to_sub}"
    n.want_to_sub.to_json
  end


def get_all_names
  query = "select first_name,last_name from names"
  query_all_names(query)
end







end
