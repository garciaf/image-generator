class ImageRequestsController < ApplicationController
  before_action :find_image_request, only: [:show, :destroy]
  def new
    @image_request = ImageRequest.new
  end

  def show; end

  def create
    @image_request = ImageRequest.new(image_request_params)
    if @image_request.save
      flash[:notice] = 'Image request was successfully created'
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.prepend('image_requests', @image_request) }
        format.html { redirect_to(root_path) }
      end
    else
      render 'new'
    end
  end

  def destroy
    @image_request.destroy!
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@image_request) }
      format.html { redirect_to(root_path) }
    end
  end

  private

  def find_image_request
    @image_request = ImageRequest.find(params[:id])
  end

  def image_request_params
    params.require(:image_request).permit(:prompt, :size)
  end
end
