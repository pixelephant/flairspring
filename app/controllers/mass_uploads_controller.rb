class MassUploadsController < ApplicationController

  # GET /mass_uploads
  # GET /mass_uploads.json
  def index
    @mass_uploads = MassUpload.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @mass_uploads }
    end
  end

  # GET /mass_uploads/1
  # GET /mass_uploads/1.json
  def show
    @mass_upload = MassUpload.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @mass_upload }
    end
  end

  # GET /mass_uploads/new
  # GET /mass_uploads/new.json
  def new
    @mass_upload = MassUpload.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @mass_upload }
    end
  end

  # GET /mass_uploads/1/edit
  def edit
    @mass_upload = MassUpload.find(params[:id])
  end

  # POST /mass_uploads
  # POST /mass_uploads.json
  def create
    @mass_upload = MassUpload.new(params[:mass_upload])

    respond_to do |format|
      if @mass_upload.save
        format.html { redirect_to @mass_upload, :notice => 'Mass upload was successfully created.' }
        format.json { render :json => @mass_upload, :status => :created, :location => @mass_upload }
      else
        format.html { render :action => "new" }
        format.json { render :json => @mass_upload.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /mass_uploads/1
  # PUT /mass_uploads/1.json
  def update
    @mass_upload = MassUpload.find(params[:id])

    respond_to do |format|
      if @mass_upload.update_attributes(params[:mass_upload])
        format.html { redirect_to @mass_upload, :notice => 'Mass upload was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @mass_upload.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /mass_uploads/1
  # DELETE /mass_uploads/1.json
  def destroy
    @mass_upload = MassUpload.find(params[:id])
    @mass_upload.destroy

    respond_to do |format|
      format.html { redirect_to mass_uploads_url }
      format.json { head :ok }
    end
  end
end
