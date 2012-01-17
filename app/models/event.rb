class Event < ActiveRecord::Base
  
  has_many :process_videos, :dependent=>:destroy
  
  scope :between_time, lambda { |start_time, end_time|
    where("start_time > ? and end_time < ?", start_time, end_time)
  }

end
