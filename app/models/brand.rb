class Brand < ActiveRecord::Base
  #validation - make sure no repeats, maybe require name
  has_many :products
end
