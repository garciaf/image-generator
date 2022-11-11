describe ApiClient::Openai do
  describe '.generate_image' do
    let(:token) { 'SECRET_TOKEN' }
    let(:prompt) { Faker::Movie.quote }
    let(:size) { "#{Faker::Number.number(digits: 10)}x#{Faker::Number.number(digits: 10)}"}

    it 'call the api to generate picture' do
      generated_image_url = Faker::Internet.url
      stub_post = stub_request(:post, "https://api.openai.com/v1/images/generations")
                    .with(
                      headers: {
                        "Authorization" => "Bearer #{token}",
                        "Content-Type" => "application/json"
                      },
                      body: {
                        prompt: prompt,
                        n: 1,
                        size: size
                      }.to_json
                    )
                    .to_return( body: {
                        created: Faker::Number.number(digits: 10),
                        data: [
                          {
                            url: generated_image_url
                          }
                        ]
                      }.to_json
                      )

        actual_result = described_class.generate_image(prompt: prompt, size: size)

        expect(stub_post).to have_been_requested
        expect(actual_result).to eq(generated_image_url)
    end
  end
end
