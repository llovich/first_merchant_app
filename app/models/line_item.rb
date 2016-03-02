class LineItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :cart

  #TODO: before save, reduce product quantity field in product
  #TODO: before delete/destroy, add back to the product inventory quantity field
end
