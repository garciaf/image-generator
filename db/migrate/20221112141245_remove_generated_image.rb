class RemoveGeneratedImage < ActiveRecord::Migration[7.0]
  def change
    drop_table :generated_images
  end
end
