module ApiClient
  class Openai
    include HTTParty
    base_uri "https://api.openai.com"
    headers  "Authorization" => "Bearer #{Rails.application.credentials.openai.token}",
             "Content-Type" => "application/json"
    raise_on [400, 401, 403, 404, 409, 415, 422, 500]
    format :json
    def self.generate_image(prompt: , size:)
      post("/v1/images/generations", body: { prompt: prompt, n: 1, size: size }.to_json)
        .parsed_response.dig("data", 0, "url")
    end
  end
end
