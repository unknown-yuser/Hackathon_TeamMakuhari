class LinkNode < ActiveRecord::Base
  belongs_to :link, primary_key: :link_id, foreign_key: :link_id, dependent: :destroy
  belongs_to :node, primary_key: :node_id, foreign_key: :node_id, dependent: :destroy
end
