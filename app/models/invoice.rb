class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions, dependent: :destroy
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items
  has_many :bulk_discounts, through: :invoice_items

  enum status: [ :cancelled, :'in progress', :completed ]

  def self.incomplete
    where.not(status: 2)
  end

  def self.ordered_by_dated
    order(:created_at)
  end

  def total_revenue
    invoice_items.sum('quantity * unit_price')
  end

  def discounted_revenue
    invoice_items.sum(&:revenue_with_discounts)
  end

  # def total_revenue_with_discount
  #   invoice_items
  #   .select('invoice_items.quantity, sum(invoice_items.quantity * invoice_items.unit_price)')
  #   .group(:quantity)
  # end

  # def total_discount
  #   invoice_items.where('invoice_items.quantity >= ?', 10)
  #   .sum('invoice_items.quantity * invoice_items.unit_price * .20')
  # end
end
