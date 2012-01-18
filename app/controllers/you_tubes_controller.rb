class YouTubesController < ApplicationController

  def index
    render :text=>"This is my Home page"
  end
  
  def create
    CrowdSurfLog.new(:my_loger=>params.to_s).save
    render :text=>params
  end
  
end
