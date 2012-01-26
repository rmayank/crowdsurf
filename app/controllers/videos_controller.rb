require 'net/http'
require 'net/https'
require 'open-uri'
require 'net/http/post/multipart'


class VideosController < InheritedResources::Base

  def show
    @event = Event.find(params[:id])
  end

  protected
    def collection
      @events = Event.all
    end

end
