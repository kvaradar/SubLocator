
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


  post '/need_a_sub/:email_id' do
    n = Name.find(email_id)
    if n.need_a_sub.nil == true
      n.need_a_sub = NeedASub.new
      puts "sub details are #{n}"
    else
       all_subs = NeedASub.all # change this to want to sub
       all_subs.each do |name|
         puts "People who want to sub are"
         puts (Name.find_by_id(name.name_id)).to_json
       end

    end

  end






def get_all_names
  query = "select first_name,last_name from names"
  query_all_names(query)
end







end
