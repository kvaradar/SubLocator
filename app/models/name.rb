class Name < ActiveRecord::Base

  has_many :need_a_sub
  has_many :want_to_sub
  has_many :devices

end
