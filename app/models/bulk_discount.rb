class BulkDiscount < ApplicationRecord
  belongs_to :merchant
  validates :name, :discount, :threshold, presence: true
  validates :threshold, :discount, numericality: true
end
