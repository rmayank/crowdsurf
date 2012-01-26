class EventsController < ApplicationController

  def index
    events = Event.select("id , displayname as title")
    respond_to do |format|
      format.html { 
        render :json => events.as_json
      }
      format.json {
        render :json =>  events.as_json
      }
    end
  end

end
