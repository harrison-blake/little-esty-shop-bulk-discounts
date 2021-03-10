require 'rails_helper'

RSpec.describe "Merchant discounts show Page" do
  describe "when I visit a merchant's bulk discount index page" do

    before :each do
      @merchant = Merchant.create!(name: "Harrison")
      @discount_1 = @merchant.bulk_discounts.create!(name: "Discount 1",
                                                     discount: 0.15,
                                                     threshold: 10)
    end

    it "displays the discounts name as the header" do
      visit "/merchants/#{@merchant.id}/bulk_discounts/#{@discount_1.id}"

      expect(page).to have_content(@discount_1.name)
    end

    it "displays the discounts threshold and percentage discount" do
      visit "/merchants/#{@merchant.id}/bulk_discounts/#{@discount_1.id}"

      expect(page).to have_content("15% off if you buy 10 or more items.")
    end

    it "displays a link to edit this bulk discount" do
      visit "/merchants/#{@merchant.id}/bulk_discounts/#{@discount_1.id}"

      expect(page).to have_link("edit")
    end

    it "takes you to the discount's edit page after clicking edit" do
      visit "/merchants/#{@merchant.id}/bulk_discounts/#{@discount_1.id}"

      click_on("edit")
      expect(current_path).to eq("/merchants/#{@merchant.id}/bulk_discounts/#{@discount_1.id}/edit")
    end
  end
end
