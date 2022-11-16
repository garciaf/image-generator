class ImageRequestsController < ApplicationController
  def new
    @image_request = ImageRequest.new
  end

  def create
    @image_request = ImageRequest.new(image_request_params)
    if @image_request.save
      flash[:notice] = "Image request was successfully created"
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.prepend("image_requests", @image_request)}
        format.html { redirect_to(root_path) }
      end
    else
      render 'new'
    end
  end

  def destroy
    @image_request = ImageRequest.find(params[:id])
    @image_request.destroy!
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@image_request) }
      format.html { redirect_to(root_path) }
    end
  end

  private

  def image_request_params
   params.require(:image_request).permit(:prompt, :size)
  end
end
