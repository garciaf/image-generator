class ImageRequestsController < ApplicationController
  def new
    @image_request = ImageRequest.new
  end

  def create
    @image_request = ImageRequest.new(image_request_params)
    if @image_request.save
      flash[:notice] = "Image request was successfully created"
      redirect_to(root_path)
    else
      render 'new'
    end
  end

  private

  def image_request_params
   params.require(:image_request).permit(:prompt, :size)
  end
end
