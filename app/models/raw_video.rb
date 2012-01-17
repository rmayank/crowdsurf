class RawVideo < ActiveRecord::Base
  TIME_DIFFERENCE = 30 # in minutes
  RADIUS_DISTANCE = 1 # in miles
  RADIUS_ORIGIN = 0 # in miles
  include AASM
  aasm_column :state
  aasm_initial_state :raw
  aasm_state :raw
  aasm_state :in_process
  aasm_state :flagged
  aasm_state :processed
  
  aasm_event :processing do
    transitions :to => :in_process, :from => :raw
  end
  
  aasm_event :flag do
    transitions :to => :flagged, :from => :raw
  end
  
  aasm_event :processed do
    transitions :to => :processed, :from => :in_process
  end
  
  scope :between_time, lambda { |start_time, end_time|
    where("start_time > ? and end_time < ?", start_time, end_time)
  }


  def self.get_first_raw_video
    RawVideo.where(:state=>:raw).order('created_at asc').first
  end

  def is_related_video?(longitude2, latitude2, radius_distance = RADIUS_DISTANCE )
    distance = Distance.new(self.longitude, self.latitude, longitude2, latitude2)
    ((RADIUS_ORIGIN..radius_distance).include?(distance.difference_between_locations) )
  end
  
  def processed_state(event)
    processed!
    event.process_videos.create(self.attributes)
  end
  
  def self.flagged_state(event, videos)
    videos.each do |video| 
      video.flag!
      event.process_videos.create(video.attributes)
    end
  end
  
  def belongs_to_event?
    events = Cluster.find_event_by_time(self.start_time, self.end_time)
    events.each do |event|
      event.process_videos.each do |processed_video|
        if self.is_related_video?(processed_video.longitude, processed_video.latitude)
          self.processing!
          self.processed_state(event)
          return true
        end
      end
    end
    return false
  end

end
