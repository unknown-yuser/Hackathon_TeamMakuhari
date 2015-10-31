class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :link_id
      t.string :src_node_id
      t.string :dst_node_id
      t.integer :link_type
      t.integer :width
      t.float :hill
      t.integer :gap
      t.string :gap_latitude
      t.string :gap_longitude
      t.integer :steps
      t.integer :bus_stop
      t.string :bus_stop_latitude
      t.string :bus_stop_longitude
      t.integer :blind_guide
      t.integer :signals
      t.string :street_name
      t.float :length

      t.timestamps null: false
    end
  end
end
