class ImagesController < ApplicationController
  def create
    image_request = ImageRequest.find(params[:image_request_id])
    image_request.retrieve_image!
    respond_to do |format|
      format.turbo_stream { head :ok }
      format.html { redirect_to(root_path) }
    end
  end
end
