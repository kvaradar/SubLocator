class NeedASub < ActiveRecord::Base
  include NotificationHelper

  belongs_to :name

  after_save :send_notification
end
