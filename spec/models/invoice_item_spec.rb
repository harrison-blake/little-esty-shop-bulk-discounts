require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'relationships' do
    it { should belong_to(:item) }
    it { should belong_to(:invoice) }
    it { should have_many(:bulk_discounts).through(:item) }
  end

  before :each do
    # @merchant = Merchant.create!(:name "Harrison Blake")
  end

  describe "##instance methods" do
    describe "best_applicable_discount" do
      xit "it returns the most cost effective discount" do
        @merchant.bulk_discounts.create!(name: "Discount 1",
                                              discount: 0.15,
                                              threshold: 10)

        @merchant.first.bulk_discounts.create!(name: "Discount 2",
                                              discount: 0.20,
                                              threshold: 15)


      end
    end
  end
end
