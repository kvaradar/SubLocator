class Name < ActiveRecord::Base
  has_one :need_a_sub #, :want_to_sub

end
