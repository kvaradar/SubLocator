
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




  post '/email' do
    params[:name]
    flag = verify_email(params[:name])
    if flag == true
      status 201
    else
      status 400
    end
   # params.to_json
    #request.body.to_json
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
      return "Nobody wants to sub for you"
    else
      want_to_sub
    end
  end

 post '/generate_needy_request' do
   # request has to entail date,email
   req = JSON.parse(request.body.read,:symbolize_names=>true)
   n = Name.find_by_email_id(req[:email_id])
   n.need_a_sub = NeedASub.new(:slot => req[:slot])
   puts "needs a sub is #{n.need_a_sub}"
    n.need_a_sub.to_json

 end

  post '/want_to_sub'do

  end


def get_all_names
  query = "select first_name,last_name from names"
  query_all_names(query)
end







end
