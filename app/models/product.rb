class Product < ActiveRecord::Base
  #validates name, price required, and maybe category [if category name is required]
  belongs_to :category
  belongs_to :brand

  has_many :line_items
  before_destroy :ensure_not_referenced_by_any_line_items


#by using brand and category instead of brand_id, category_id, we are making sure that there is a brand. category object present
 validates_presence_of :name, :current_price, :quantity, :description, :brand, :category

 #want price to be 0 or positive float
 validates_numericality_of :current_price, greater_than_or_equal_to: 0.01

#want quantity to be greater
 validates_numericality_of :quantity, greater_than_or_equal_to: 0

has_attached_file :avatar,
    styles: { large: "500x500#", medium: "300x300#", thumb: "100x100#" },
    default_url: ":style_missing.jpg"
validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

private

  def ensure_not_referenced_by_any_line_items
    if line_items.empty?
      return true
    else
      errors.add(:base, "Cannot delete because line items are present")
      return false
  end

end
