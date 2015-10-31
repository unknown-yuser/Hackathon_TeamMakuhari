class CreateNodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
      t.string :node_id
      t.string :latitude
      t.string :longitude
      t.string :link_1
      t.string :link_2
      t.string :link_3
      t.string :link_4
      t.string :link_5

      t.timestamps null: false
    end
  end
end
