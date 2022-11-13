class ImageRequest < ApplicationRecord
  has_many_attached :images

  validates :prompt, :size, presence: true
  attribute :size, :string, default: '1024x1024'

  def retrieve_image!
    store_image retrieve_image_url_from_api
  end

  private

  def store_image(generated_image_url)
    uri = URI.parse(generated_image_url)
    tempfile = Down.download(generated_image_url)
    images.attach(io: tempfile, filename: tempfile.original_filename, content_type: tempfile.content_type)
  end

  def retrieve_image_url_from_api
    ApiClient::Openai.generate_image(prompt: prompt, size: size)
  end
end
