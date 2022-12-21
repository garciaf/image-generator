class ImageRequestsController < ApplicationController
  before_action :find_image_request, only: [:show, :destroy]
  include ActionView::RecordIdentifier

  def new
    @image_request = ImageRequest.new
  end

  def show; end

  def create
    @image_request = ImageRequest.new(image_request_params)
    if @image_request.save
      flash[:notice] = 'Image request was successfully created'
      respond_to do |format|
        format.turbo_stream {}
        format.html { redirect_to(root_path) }
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render(turbo_stream: turbo_stream.update(
            dom_id(@image_request),
            partial: 'image_requests/form',
            locals: {
              image_request: @image_request
            }
          ),
                 status: :bad_request)
        end
        format.html { render 'new', status: :bad_request }
      end

    end
  end

  def destroy
    @image_request.destroy!
    respond_to do |format|
      format.html { redirect_to(root_path) }
      format.turbo_stream {}
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
