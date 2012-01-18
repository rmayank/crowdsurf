require 'uri'

module VideosHelper

  def get_watch_id(url)
    uri = URI(url)
    uri.query
    return ( uri.query.split("&")[0].split("=")[1] rescue "")
  end

end
