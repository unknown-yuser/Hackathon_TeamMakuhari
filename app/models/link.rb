class Link < ActiveRecord::Base
  has_many :link_nodes, primary_key: :link_id, foreign_key: :link_id
  has_many :node, through: :link_nodes

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      link = find_by(link_id: row["link_id"]) || new
      names_to_use = attribute_names.select { |name| !name.in? ["id", "created_at", "updated_at"] }
      attributes_to_use = names_to_use.map do |name|
        if name =~ /latitude|longitude/ && row[name]
          lats_or_lngs = row[name].split(".", 3).map(&:to_f)
          puts lats_or_lngs
          floatized = lats_or_lngs[0] + (lats_or_lngs[1] / 60) + (lats_or_lngs[2] / 60 / 60)
          [name, floatized]
        else
          [name, row[name]]
        end
      end.to_h
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
