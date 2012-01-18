class YouTubesController < ApplicationController

  def index
    
    params = {"starttimeValue"=>"20120118-132032", "endtimeValue"=>"20120118-132032", "longitudeValue"=>"-122° 24' 23.1012\"", "latitudeValue"=>"37° 47' 9.0024\"", "userfile"=>#<ActionDispatch::Http::UploadedFile:0x00000003208bb0 @original_filename="videocrowdsurf.mp4", @content_type="video/mp4", @headers="Content-Disposition: form-data; name=\"userfile\"; filename=\"videocrowdsurf.mp4\"\r\nContent-Type: video/mp4\r\nContent-Transfer-Encoding: binary\r\n", @tempfile=#<File:/app/tmp/RackMultipart20120117-1-1p59y8w>>}
    render :text=>"This is my Home page"
  end
  
  def create
    @video = Video.create(:title=>"description",:description=>"description",:is_complete=>false)
    @upload_info = Video.token_form({"title"=>"werwerwer", "description"=>"werwer"}, save_video_new_video_url(:video_id => @video.id))
    base_url = @upload_info[:url]
    #ss = RestClient.post(base_url, :token=>@upload_info[:token], :file => File.new(Rails.root.to_s + "/public/jumps.mp4"), :content_type => 'video/mp4')
    
    url = URI.parse(base_url)
    req = Net::HTTP::Post::Multipart.new base_url.gsub("http://uploads.gdata.youtube.com",""),"file" => params[:userfile], "token"=>@upload_info[:token]
    res = Net::HTTP.start(url.host, url.port) do |http|
      http.request(req)
    end
    render :text=>res.body
  end
  
end
