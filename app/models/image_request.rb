class ImageRequest < ApplicationRecord
  has_many_attached :images

  validates :prompt, :size, presence: true
  attribute :size, :string, default: '1024x1024'

  after_create_commit -> { broadcast_prepend_to 'image_requests' }
  after_destroy_commit -> { broadcast_remove_to 'image_requests' }
  after_update_commit -> { broadcast_replace_to 'image_requests' }

  def retrieve_image!
    store_image retrieve_image_url_from_api
    broadcast_replace_to self
  end

  private

  def store_image(generated_image_url)
    tempfile = Down.download(generated_image_url)
    images.attach(io: tempfile, filename: tempfile.original_filename, content_type: tempfile.content_type)
  end

  def retrieve_image_url_from_api
    ApiClient::Openai.generate_image(prompt: prompt, size: size)
  end
end
