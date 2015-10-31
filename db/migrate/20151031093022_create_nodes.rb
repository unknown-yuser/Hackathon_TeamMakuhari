class CreateNodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
      t.string :node_id
      t.string :latitude
      t.string :longitude

      t.timestamps null: false
    end
  end
end
