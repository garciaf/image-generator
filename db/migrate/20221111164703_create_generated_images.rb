class CreateGeneratedImages < ActiveRecord::Migration[7.0]
  def change
    create_table :generated_images do |t|
      t.text :url
      t.references :image_request, null: false, foreign_key: true

      t.timestamps
    end
  end
end
