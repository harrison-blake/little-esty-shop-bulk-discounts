require 'rails_helper'

RSpec.describe "Merchant discounts Edit Page" do
  describe "when I visit a merchant's bulk discount edit page" do

    before :each do
      @merchant = Merchant.create!(name: "Harrison")
      @discount_1 = @merchant.bulk_discounts.create!(name: "Discount 1",
                                                     discount: 0.15,
                                                     threshold: 10)
    end

    it "Displays a header that lets the user know this is the edit discount page" do
      visit "/merchants/#{@merchant.id}/bulk_discounts/#{@discount_1.id}/edit"
      expect(page).to have_content("Edit Discount")
    end

    it "displays a prepopulated form to edit the discount" do
      visit "/merchants/#{@merchant.id}/bulk_discounts/#{@discount_1.id}/edit"

      expect(page).to have_field("name")
      target = find_field('name').value
      expect(target).to have_content(@discount_1.name)

      expect(page).to have_field("discount")
      target = find_field('discount').value
      expect(target).to have_content(@discount_1.discount)

      expect(page).to have_field("threshold")
      target = find_field('threshold').value
      expect(target).to have_content(@discount_1.threshold)
    end

    it "redirects me to the bulk discount's show page after I make any changes and display new info on show page" do
      visit "/merchants/#{@merchant.id}/bulk_discounts/#{@discount_1.id}/edit"
      fill_in :name, with: "Discount 2"
      fill_in :discount, with: 0.20
      fill_in :threshold, with: 17
      click_on 'Edit Discount'
      expect(current_path).to eq("/merchants/#{@merchant.id}/bulk_discounts/#{@discount_1.id}")

      expect(page).to have_content("Discount 2")
      expect(page).to have_content("20% off if you buy 17 or more items.")
    end

    it "keeps me on the edit page if invalid info is entered" do
      visit "/merchants/#{@merchant.id}/bulk_discounts/#{@discount_1.id}/edit"

      fill_in :name, with: "Discount 2"
      fill_in :discount, with: "not a number"
      fill_in :threshold, with: 17
      click_on 'Edit Discount'

      expect(current_path).to eq("/merchants/#{@merchant.id}/bulk_discounts/#{@discount_1.id}/edit")
      expect(page).to have_content("Required information is invalid")
    end
  end
end
