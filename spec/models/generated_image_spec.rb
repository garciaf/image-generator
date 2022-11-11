describe GeneratedImage do
  let(:image_request) { create :image_request }
  let(:generated_image) { create :generated_image, image_request: image_request }
  let(:generated_image_url) { Faker::Internet.url }
  describe '#sync!' do
    it "call the api to retrieve a url picture" do
      generated_image_url = Faker::Internet.url
      stub_post = stub_request(:post, "https://api.openai.com/v1/images/generations")
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
      expect do
        generated_image.sync!
        expect(stub_post).to have_been_requested
      end.to change{ generated_image.reload.url }.from(nil).to(generated_image_url)
    end

    context "when url already been generated" do
      let(:generated_image) { create :generated_image, image_request: image_request, url: generated_image_url }

      it "does not recall the API" do
        stub_post = stub_request(:post, "https://api.openai.com/v1/images/generations")
        expect do
        generated_image.sync!
        expect(stub_post).to_not have_been_requested
      end.not_to change{ generated_image.reload.url }
      end
    end
  end
end
