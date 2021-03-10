require 'rails_helper'

RSpec.describe "Merchant invoice show page" do
  before :each do
    @customer = Customer.create!(first_name: "First1", last_name: "Last1")
    @invoice = @customer.invoices.create!(status: 1)
    @merchant = Merchant.create!(name: "Merchant1")
    @item1 = @merchant.items.create!(name: "Item1", description: "Description1", unit_price: 2)
    @item2 = @merchant.items.create!(name: "Item2", description: "Description2", unit_price: 3)

    @invoice_item1 = InvoiceItem.create!(item: @item1, invoice: @invoice, quantity: 1, unit_price: 1, status: 0)
    @invoice_item2 = InvoiceItem.create!(item: @item2, invoice: @invoice, quantity: 2, unit_price: 2, status: 1)
  end

  describe "when I visit a merchant invoice show page" do
    it "shows the invoice information" do
      visit "/merchants/#{@merchant.id}/invoices/#{@invoice.id}"

      expect(page).to have_content("Invoice ID: #{@invoice.id}")
      expect(page).to have_content("Invoice status: #{@invoice.status}")
      expect(page).to have_content("Created at: #{@invoice.created_at.strftime('%A, %b %d, %Y')}")
    end

    it "shows the customer information" do
      visit "/merchants/#{@merchant.id}/invoices/#{@invoice.id}"

      within(".customer_info") do
        expect(page).to have_content("Customer: #{@customer.first_name} #{@customer.last_name}")
      end
    end

    it "shows all items info" do
      visit "/merchants/#{@merchant.id}/invoices/#{@invoice.id}"

      within(".item_info") do
        within("#item_id_#{@item1.id}") do
          expect(page).to have_content("Item: #{@item1.name}")
          expect(page).to have_content("Quantity ordered: #{@invoice_item1.quantity}")
          expect(page).to have_content("Price: #{@invoice_item1.unit_price}")
          expect(page).to have_content("Item status: #{@invoice_item1.status}")
        end

        within("#item_id_#{@item2.id}") do
          expect(page).to have_content("Item: #{@item2.name}")
          expect(page).to have_content("Quantity ordered: #{@invoice_item2.quantity}")
          expect(page).to have_content("Price: #{@invoice_item2.unit_price}")
          expect(page).to have_content("Item status: #{@invoice_item2.status}")
        end
      end
    end

    it "shows the total revinue that will be generated by this invoice" do
      visit "/merchants/#{@merchant.id}/invoices/#{@invoice.id}"

      within(".total_revenue") do
        expect(page).to have_content("Total without Bulk Discount: $5.00")
      end
    end

    it "has a select field to update the invoice status" do
      visit "/merchants/#{@merchant.id}/invoices/#{@invoice.id}"

      expect(page).to have_field(:status)
    end
  end

  describe "when the update button is clicked" do
    it "redierects you to the same show page where the status has been updated" do
      visit "/merchants/#{@merchant.id}/invoices/#{@invoice.id}"

      select(:completed, from: :status)
      click_button(:Submit)

      expect(current_path).to eq("/merchants/#{@merchant.id}/invoices/#{@invoice.id}")
      expect(page).to have_content("Invoice status: completed")
    end
  end
end
