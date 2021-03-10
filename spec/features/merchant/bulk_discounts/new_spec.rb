require 'rails_helper'

RSpec.describe "Merchant discounts new Page" do
  describe "when I visit a merchant's bulk discount new page" do

    before :each do
      @merchant = Merchant.create!(name: "Harrison")
      @discount_1 = @merchant.bulk_discounts.create!(name: "Discount 1",
                                                     discount: 0.15,
                                                     threshold: 10)
    end

    it "Displays a header that lets the user know this is the discount new page" do
      visit "/merchants/#{@merchant.id}/bulk_discounts/new"
      expect(page).to have_content("Add New Discount")
    end

    it "Displays a form to add a new bulk discount" do
      visit "/merchants/#{@merchant.id}/bulk_discounts/new"

      expect(page).to have_field("name")
      expect(page).to have_field("discount")
      expect(page).to have_field("threshold")
    end

    it "if valid info is entered, I'm taken back to bulk discount index with the new discount info added" do
      visit "/merchants/#{@merchant.id}/bulk_discounts/new"

      fill_in :name, with: "Discount 2"
      fill_in :discount, with: 0.10
      fill_in :threshold, with: 12
      click_on 'Add Discount'

      expect(current_path).to eq("/merchants/#{@merchant.id}/bulk_discounts")

      expect(page).to have_content("Discount 2 - 10% off if you buy 12 or more items.")
    end

    it "if invalid info is entered, I'm taken back to bulk discount index with the new discount info added" do
      visit "/merchants/#{@merchant.id}/bulk_discounts/new"

      fill_in :name, with: ""
      fill_in :discount, with: 0.10
      fill_in :threshold, with: 12
      click_on 'Add Discount'

      expect(current_path).to eq("/merchants/#{@merchant.id}/bulk_discounts/new")
    end
  end
end
