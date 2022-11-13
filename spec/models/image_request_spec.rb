describe ImageRequest do
  let(:image_request) { create :image_request }
  let(:generated_image_url) { Faker::Internet.url }

  describe '.size' do
    it 'has a default value' do
      actual_result = described_class.new.size
      expect(actual_result).to eq('1024x1024')
    end
  end
  describe '.retrieve_image!' do
    it 'retrieve from api and store it locally' do
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
      body_file = File.open(File.expand_path('./spec/fixtures/test.png'))
      stub_get = stub_request(:get, generated_image_url)
                  .to_return(body: body_file, status: 200)

      expect do
        image_request.retrieve_image!
        expect(stub_post).to have_been_requested
        expect(stub_get).to have_been_requested
      end.to change{ image_request.images.count }.by(1)
    end
  end
end
