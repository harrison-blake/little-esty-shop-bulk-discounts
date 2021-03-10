class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice
  has_many :bulk_discounts, through: :item
  enum status: [ :pending, :packaged, :shipped ]

  def best_applicable_discount
    bulk_discounts.where('? >= bulk_discounts.threshold', self.quantity)
    .order(discount: :desc)
    .first
  end

  def revenue_with_discounts
    best = self.best_applicable_discount
    if best.nil?
      revenue_without_discounts.to_f
    else
      revenue_without_discounts - (revenue_without_discounts * best.discount).to_f
    end
  end

  def revenue_without_discounts
    self.unit_price * self.quantity
  end
end
