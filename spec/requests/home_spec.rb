describe "Homes", type: :request do
  describe "GET /index" do
    let!(:image_request) { create :image_request, :with_image }

    it "return the previous request" do
      get root_path

      expect(response_text).to include(image_request.prompt)
      expect(response.body).to include('<img')
    end
  end
end
