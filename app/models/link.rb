class Link < ActiveRecord::Base
  has_many :link_nodes, primary_key: :link_id, foreign_key: :link_id
  has_many :node, through: :link_nodes

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      link = find_by(link_id: row["link_id"]) || new
      names_to_use = attribute_names.select { |name| !name.in? ["id", "created_at", "updated_at"] }
      attributes_to_use = names_to_use.map { |name| [name, row[name]] }.to_h
      puts attributes_to_use
      link.update_attributes(attributes_to_use)
      link.save!
      ln1 = LinkNode.find_or_initialize_by(link_id: link.link_id, node_id: link.src_node_id)
      ln1.save!
      ln2 = LinkNode.find_or_initialize_by(link_id: link.link_id, node_id: link.dst_node_id)
      ln2.save!
    end
  end
end
