class Cron

  def self.cluster
    cluster = Cluster.new
    video = RawVideo.get_first_raw_video
    return if video.blank?
    
    return if video.belongs_to_event?
    
    videos = Cluster.cluster(video)

    Cluster.set_in_processed_state(videos)
    min_start_time, max_end_time = Cluster.min_start_time(videos), Cluster.max_end_time(videos)
    
    event = Event.new(:start_time=>min_start_time, :end_time=>max_end_time)
    return unless event.save
    
    videos.each{ |video| video.processed_state(event) }
    
#    videos.each do |video|
#      videos = Cluster.cluster(video, min_start_time, max_end_time)
#      videos.blank? ? video.processed_state(event) : RawVideo.flagged_state(event, videos)
#    end
    
    
  end
  
end
