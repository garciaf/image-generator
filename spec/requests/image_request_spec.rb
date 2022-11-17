require 'rails_helper'

RSpec.describe '/image_requests', type: :request do
  let(:image_request) { create :image_request }
  describe 'GET /new' do
    it 'returns http success' do
      get new_image_request_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'return the image request details' do
      get(image_request_path(image_request))
      expect(response).to have_http_status(:success)
      expect(response_text).to include(image_request.prompt)
    end
  end

  describe 'DELETE /destroy' do
    before do
      image_request
    end
    it 'allow to destroy image request' do
      expect do
        delete image_request_path(image_request)
      end.to change(ImageRequest, :count).by(-1)
    end
    context 'when image request have images' do
      let(:image_request) { create :image_request, :with_image }
      it 'allow to destroy image request' do
        expect do
          delete image_request_path(image_request)
        end.to change(ImageRequest, :count).by(-1)
      end
    end
  end

  describe 'POST /create' do
    let(:prompt) { Faker::Movie.quote }
    let(:size) { "#{Faker::Number.number(digits: 10)}x#{Faker::Number.number(digits: 10)}" }

    it 'returns http success' do
      expect do
        post image_requests_path, params: { image_request: {
          prompt: prompt,
          size: size
        } }
      end.to change(ImageRequest, :count).by(1)

      expect(response).to redirect_to(root_path)
    end
  end
end
