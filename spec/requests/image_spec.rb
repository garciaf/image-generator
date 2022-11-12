RSpec.describe "/images", type: :request do
  let(:image_request) { create :image_request }
  let(:generated_image_url) { Faker::Internet.url }
  describe "POST /:create" do
    before do
      stub_request(:post, "https://api.openai.com/v1/images/generations")
        .with(
          body: {
            prompt: image_request.prompt,
            n: 1,
            size: image_request.size
          }.to_json
        )
        .to_return( body: {
            created: Faker::Number.number(digits: 10),
            data: [
              {
                url: generated_image_url
              }
            ]
          }.to_json)
      body_file = File.open(File.expand_path('./spec/fixtures/test.png'))
      stub_request(:get, generated_image_url)
        .to_return(body: body_file, status: 200)

    end
    it "generate a image for a request" do
      expect do
        post image_request_images_path(image_request)
        expect(response).to redirect_to(root_path)
      end.to change{ image_request.images.count }.by(1)
    end
  end

end
