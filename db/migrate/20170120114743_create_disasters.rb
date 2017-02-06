class CreateDisasters < ActiveRecord::Migration[5.0]
  def change
    create_table :disasters do |t|
      t.string :kind
      t.text :description
      t.float :longitude
      t.float :latitude

      t.timestamps
    end
  end
end
