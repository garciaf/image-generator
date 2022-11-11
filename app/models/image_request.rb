class ImageRequest < ApplicationRecord
  has_many :generated_images
  has_many :synced_generated_images, -> { merge(GeneratedImage.synced) }, class_name: "GeneratedImage"
end
