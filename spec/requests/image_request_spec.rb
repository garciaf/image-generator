require 'rails_helper'

RSpec.describe "/image_requests", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get new_image_request_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    let(:prompt) { Faker::Movie.quote }
    let(:size) { "#{Faker::Number.number(digits: 10)}x#{Faker::Number.number(digits: 10)}"}

    it "returns http success" do
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
