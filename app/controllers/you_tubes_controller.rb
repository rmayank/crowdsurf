require 'net/http'
require 'net/https'
require 'open-uri'
require 'net/http/post/multipart'


class YouTubesController < ApplicationController

  def index
    render :text=>"This is my Home page"
  end
  
  def create
    @video = Video.create(:title=>"description",:description=>"description",:is_complete=>false)
    @upload_info = Video.token_form({"title"=>"werwerwer", "description"=>"werwer"}, save_video_new_video_url(:video_id => @video.id))
    base_url = @upload_info[:url]
    #ss = RestClient.post(base_url, :token=>@upload_info[:token], :file => File.new(Rails.root.to_s + "/public/jumps.mp4"), :content_type => 'video/mp4')
    puts params
    
    url = URI.parse(base_url)
    video = params[:userfile].open
    
    req = Net::HTTP::Post::Multipart.new base_url.gsub("http://uploads.gdata.youtube.com",""),"file" => UploadIO.new(video, params[:userfile].content_type, params[:userfile].original_filename), "token"=>@upload_info[:token]
    res = Net::HTTP.start(url.host, url.port) do |http|
      http.request(req)
    end
    @video.update_attributes(:yt_video_id => params[:id].to_s, :is_complete => true)
    Video.delete_incomplete_videos
    render :text=>res.body
  end
  
end
