class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :photo
      t.string :title
      t.string :caption
      t.string :used_camera
      t.string :color
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
