require 'net/http'
require 'net/https'
require 'open-uri'
require 'net/http/post/multipart'


class VideosController < InheritedResources::Base

  protected
    def collection
      @events = Event.all
    end

end
