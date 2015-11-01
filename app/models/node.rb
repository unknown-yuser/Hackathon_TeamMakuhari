class Node < ActiveRecord::Base
  has_many :link_nodes, primary_key: :node_id, foreign_key: :node_id
  has_many :links, through: :link_nodes

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      node = find_by(node_id: row["node_id"]) || new
      names_to_use = attribute_names.select { |name| !name.in? ["id", "created_at", "updated_at"] }
      attributes_to_use = names_to_use.map do |name|
        if name =~ /latitude|longitude/ && row[name]
          lats_or_lngs = row[name].split(".", 3).map(&:to_f)
          floatized = lats_or_lngs[0] + (lats_or_lngs[1] / 60) + (lats_or_lngs[2] / 60 / 60)
          [name, floatized]
        else
          [name, row[name]]
        end
      end.to_h
      puts attributes_to_use
      node.update_attributes(attributes_to_use)
      node.save!
      (1..5).each do |n|
        l = node.send "link_#{n}"
        ln = LinkNode.find_or_initialize_by(link_id: l, node_id: node.node_id)
        ln.save!
      end
    end
  end
end
