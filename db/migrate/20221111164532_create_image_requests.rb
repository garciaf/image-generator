class CreateImageRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :image_requests do |t|
      t.text :prompt
      t.string :size

      t.timestamps
    end
  end
end
