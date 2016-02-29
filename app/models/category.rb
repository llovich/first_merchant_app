class Category < ActiveRecord::Base
  #validation - make sure no repeats, require name as they are seeded and can then use titleize in index.html
  has_many :products
  validates_uniqueness_of :name
end
