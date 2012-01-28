require 'net/http'
require 'net/https'
require 'open-uri'
require 'net/http/post/multipart'


class YouTubesController < ApplicationController

  def index
    render :text=>"This is my Home page"
  end
  
  def create
    begin
      client = YouTubeIt::Client.new(:username => YouTubeITConfig.username, :password =>  YouTubeITConfig.password, :dev_key => YouTubeITConfig.dev_key)
      response = client.video_upload(params[:userfile].open, :title => "test",:description => "some description", :category => "People",:keywords => %w[cool blah test], :comment => "denied")
      if event = ( Event.find(params[:eventId]) rescue nil)
        # need to check that input lat/long is near around events lat/long
        begin 
          time_zone= ( params[:timeZone]  || "UTC")
        rescue
          time_zone = "UTC"
        end
        Time.zone = time_zone
        starttime = Time.zone.parse(params[:starttimeValue].gsub("-",""))
        starttimeValue = starttime.utc
        endtime = Time.zone.parse(params[:endtimeValue].gsub("-",""))
        endtimeValue = endtime.utc
        event.process_videos.create(:start_time=>starttimeValue, :end_time=>endtimeValue, :latitude=>params[:latitudeValue].to_f, :longitude=>params[:longitudeValue].to_f,:video_link=>response.player_url, :time_zone=>time_zone)
        Time.zone = "UTC"
        render :text=>"Video Upload Sucessfully"
     else
       CrowdSurfLog.create(:my_loger=>params.to_s)
       render :text=>"Bad Input"
     end
   rescue
     Time.zone = "UTC"
     CrowdSurfLog.create(:my_loger=>params.to_s)
     render :text=>"Bad Input"
   end    
 end
  
end
