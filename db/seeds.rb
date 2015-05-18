(ActiveRecord::Base.connection.tables.map!(&:camelize).map!(&:singularize) - [ 'SchemaMigration' ]).each do |t|
  t.constantize.destroy_all
end

require 'pp'
require 'uri'
require 'multi_json'
file = File.expand_path('../recipes.json', __FILE__)
json = File.read(file)
records = MultiJson.load(json, :symbolize_keys => true)
@pb = ProgressBar.create :title => 'recipes', :total => records.count
records.each_with_index do |record,idx|
  category = Category.where(:name => record[:category]).first
  if !category
    category = Category.new(:name => record[:category])
    category.save!
  end
  recipe = Recipe.new({
    :name => record[:name],
    :category => category,
    :url => record[:url],
    :quantity_served => record[:recipeYield],
    :description => record[:description],
  })
  record[:ingredients].to_s.strip.split("\n").map!(&:strip).reject(&:blank?).each do |ingredient|
    recipe.ingredients.build(:description => ingredient)
  end
  if record[:image]
    begin
      img = HTTParty.get(record[:image])
      recipe.picture = StringIO.new(img) unless img.blank?
      recipe.picture = nil unless recipe.picture_content_type =~ /\Aimage\/.*\Z/
    rescue Exception => e
      Kernel.warn e
    end
  end
  recipe.save!

  @pb.increment
end
Kernel.sleep 2