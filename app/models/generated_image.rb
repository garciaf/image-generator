class GeneratedImage < ApplicationRecord
  belongs_to :image_request

  delegate :prompt, to: :image_request
  delegate :size, to: :image_request

  scope :synced, -> { where.not(url: nil) }

  def sync!
    return false if url.present?
    generated_image_url = ApiClient::Openai.generate_image(prompt: prompt, size: size)
    update(url: generated_image_url)
  end
end
