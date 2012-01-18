require 'net/http'
require 'net/https'
require 'open-uri'
require 'net/http/post/multipart'


class VideosController < InheritedResources::Base

  def test
    @video = Video.create(:title=>"description",:description=>"description",:is_complete=>false)
    @upload_info = Video.token_form({"title"=>"werwerwer", "description"=>"werwer"}, save_video_new_video_url(:video_id => @video.id))
    base_url = @upload_info[:url]
    #ss = RestClient.post(base_url, :token=>@upload_info[:token], :file => File.new(Rails.root.to_s + "/public/jumps.mp4"), :content_type => 'video/mp4')
    
    
    url = URI.parse(base_url)
    jpg = File.open(Rails.root.to_s + "/public/Movie.mp4")
    
    req = Net::HTTP::Post::Multipart.new base_url.gsub("http://uploads.gdata.youtube.com",""),"file" => UploadIO.new(jpg, "video/mp4", "Movie.mp4"), "token"=>@upload_info[:token]
    res = Net::HTTP.start(url.host, url.port) do |http|
      http.request(req)
    end

    
    render :text=>res.body


  end
  
  def test_new
    @video = Video.new
  end

  def upload
    @video = Video.create(params[:video])
    if @video
      @upload_info = Video.token_form(params[:video], save_video_new_video_url(:video_id => @video.id))
    else
      respond_to do |format|
        format.html { render "/videos/new" }
      end
    end
  end

  def update
    @video     = Video.find(params[:id])
    @result    = Video.update_video(@video, params[:video])
    respond_to do |format|
      format.html do
        if @result
          redirect_to @video, :notice => "video successfully updated"
        else
          respond_to do |format|
            format.html { render "/videos/_edit" }
          end
        end
      end
    end
  end

  def save_video
    @video = Video.find(params[:video_id])
    if params[:status].to_i == 200
      @video.update_attributes(:yt_video_id => params[:id].to_s, :is_complete => true)
      Video.delete_incomplete_videos
    else
      Video.delete_video(@video)
    end
    redirect_to videos_path, :notice => "video successfully uploaded"
  end

  def destroy
    @video = Video.find(params[:id])
    if Video.delete_video(@video)
      flash[:notice] = "video successfully deleted"
    else
      flash[:error] = "video unsuccessfully deleted"
    end
    redirect_to videos_path
  end

  def add_comment
    @video = Video.find(params[:id])
    if @video.create_comment(params[:video][:comment])
      flash[:notice] = "Comment has been sucessfully added."
    else
      flash[:error] = "Sorry the comment has not been added."
    end
    redirect_to @video    
  end

  protected
    def collection
      @videos ||= end_of_association_chain.completes
    end

end