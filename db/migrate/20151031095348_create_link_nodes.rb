class CreateLinkNodes < ActiveRecord::Migration
  def change
    create_table :link_nodes do |t|
      t.string :link_id, index: true, foreign_key: true
      t.string :node_id, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
