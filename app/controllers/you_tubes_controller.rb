require 'net/http'
require 'net/https'
require 'open-uri'
require 'net/http/post/multipart'


class YouTubesController < ApplicationController

  def index
    render :text=>"This is my Home page"
  end
  
  def create
    client = YouTubeIt::Client.new(:username => YouTubeITConfig.username, :password =>  YouTubeITConfig.password, :dev_key => YouTubeITConfig.dev_key)
    response = client.video_upload(params[:userfile].open, :title => "test",:description => "some description", :category => "People",:keywords => %w[cool blah test], :comment => "denied")
    
    raw_video = RawVideo.new(:start_time=>params[:starttimeValue].gsub("-","").to_time, :end_time=>params[:endtimeValue].gsub("-","").to_time, :latitude=>params[:latitudeValue].to_f, :longitude=>params[:longitudeValue].to_f,:video_link=>response.player_url)
    save_video = raw_video.save
    render :text=>save_video
  end
  
end
