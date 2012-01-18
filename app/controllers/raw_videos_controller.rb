class RawVideosController < ApplicationController
  # GET /raw_videos
  # GET /raw_videos.xml
  def index
    @raw_videos = RawVideo.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @raw_videos }
    end
  end
  
  def call_cluster
    Cron.cluster
    render :text=>"true"
  end

  # GET /raw_videos/1
  # GET /raw_videos/1.xml
  def show
    @raw_video = RawVideo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @raw_video }
    end
  end

  # GET /raw_videos/new
  # GET /raw_videos/new.xml
  def new
    @raw_video = RawVideo.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @raw_video }
    end
  end

  # GET /raw_videos/1/edit
  def edit
    @raw_video = RawVideo.find(params[:id])
  end

  # POST /raw_videos
  # POST /raw_videos.xml
  def create
    @raw_video = RawVideo.new(params[:raw_video])

    respond_to do |format|
      if @raw_video.save
        format.html { redirect_to(@raw_video, :notice => 'Raw video was successfully created.') }
        format.xml  { render :xml => @raw_video, :status => :created, :location => @raw_video }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @raw_video.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /raw_videos/1
  # PUT /raw_videos/1.xml
  def update
    @raw_video = RawVideo.find(params[:id])

    respond_to do |format|
      if @raw_video.update_attributes(params[:raw_video])
        format.html { redirect_to(@raw_video, :notice => 'Raw video was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @raw_video.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /raw_videos/1
  # DELETE /raw_videos/1.xml
  def destroy
    @raw_video = RawVideo.find(params[:id])
    @raw_video.destroy

    respond_to do |format|
      format.html { redirect_to(raw_videos_url) }
      format.xml  { head :ok }
    end
  end
end
