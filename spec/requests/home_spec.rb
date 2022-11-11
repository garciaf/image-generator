describe "Homes", type: :request do
  describe "GET /index" do
    let(:image_request) { create :image_request }
    let!(:generated_image) { create :generated_image, :synced, image_request: image_request}

    it "return the previous request" do
      get root_path

      expect(response_text).to include(image_request.prompt)
      expect(response.body).to include(generated_image.url)
    end
  end
end
