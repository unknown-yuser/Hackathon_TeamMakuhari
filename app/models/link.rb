class Link < ActiveRecord::Base
  has_many :node

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      link = find_by(id: row["id"]) || new
      names_to_use = attribute_names.select { |name| !name.in? ["id", "created_at", "updated_at"] }
      attributes_to_use = names_to_use.map { |name| [name, row[name]] }.to_h
      puts attributes_to_use
      link.update_attributes(attributes_to_use)
      link.save!
    end
  end
end
