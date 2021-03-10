require 'rails_helper'

RSpec.describe "Merchant discounts index Page" do
  describe "when I visit a merchant's bulk discount index page" do

    before :each do
      @merchant = Merchant.create!(name: "Harrison")
      @discount_1 = @merchant.bulk_discounts.create!(name: "Discount 1",
                                                     discount: 0.15,
                                                     threshold: 10)
    end

    it "I see all my my bulk discounts for this merchant" do
      visit "/merchants/#{@merchant.id}/bulk_discounts"

      within(".display-3") do
        expect(page).to have_content(@merchant.name)
      end

      within(".discounts") do
        expect(page).to have_content("Discount 1 - 15% off if you buy 10 or more items.")
      end
    end

    it "Displays links to all the discounts offerred by the merchant" do
      visit "/merchants/#{@merchant.id}/bulk_discounts"

      expect(page).to have_link(@discount_1.name)
    end

    it "When discount linked is clicked the user is taken to the discounts show page" do
      visit "/merchants/#{@merchant.id}/bulk_discounts"

      expect(page).to have_link(@discount_1.name)
      click_on(@discount_1.name)
      expect(current_path).to eq("/merchants/#{@merchant.id}/bulk_discounts/#{@discount_1.id}")
    end

    it "Displays a link a link to create a new discount " do
      visit "/merchants/#{@merchant.id}/bulk_discounts"
      expect(page).to have_link("Add New Discount")
    end

    it "Takes me to a create discount page where I see a form to add a new bulk discount" do
      visit "/merchants/#{@merchant.id}/bulk_discounts"
      click_on("Add New Discount")
      expect(current_path).to eq("/merchants/#{@merchant.id}/bulk_discounts/new")
    end

    it "displays a link to delete next to each bulk" do
      visit "/merchants/#{@merchant.id}/bulk_discounts"

      expect(page).to have_button("delete")
    end

    it "after clicking delete, you no longer see that bulk discount's info" do
      visit "/merchants/#{@merchant.id}/bulk_discounts"

      first(:button, "delete").click
      expect(current_path).to eq("/merchants/#{@merchant.id}/bulk_discounts")
      expect(page).to_not have_content(@discount_1.name)
      expect(page).to_not have_content(@discount_1.discount)
      expect(page).to_not have_content(@discount_1.threshold)
    end
  end
end
