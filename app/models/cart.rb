class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy

  def subtotal
    #this is slow, should use sql to do sum for you
    #line_items.to_a.sum{ |item| item.total}

    #use sql
    #("SUM(quantity * price) AS sum") does the sum
    #[0] gets the first one in table/all values
    # .sum is returning the sum field of [0]
    line_items.select("SUM(quantity * price) AS sum")[0].sum

  end
end
