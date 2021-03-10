class Merchant::BulkDiscountsController < ApplicationController
  def index
    @holiday_names = HolidayService.new.holiday_names
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def new
  end

  def edit
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def update
    bulk_discount = BulkDiscount.find(params[:id])
    bulk_discount.update(name: params[:name],
                      discount: params[:discount],
                     threshold: params[:threshold])

    if bulk_discount.save
      redirect_to "/merchants/#{params[:merchant_id]}/bulk_discounts/#{params[:id]}"
    else
      flash[:notice] = "Required information is invalid"
      redirect_to "/merchants/#{params[:merchant_id]}/bulk_discounts/#{params[:id]}/edit"
    end
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    bd = merchant.bulk_discounts.new(name: params[:name],
                                 discount: params[:discount],
                                threshold: params[:threshold])

    if bd.save
      redirect_to "/merchants/#{merchant.id}/bulk_discounts"
    else
      flash[:notice] = "Required information is invalid"
      redirect_to "/merchants/#{merchant.id}/bulk_discounts/new"
    end
  end

  def destroy
    bd = BulkDiscount.find(params[:id])
    bd.delete

    redirect_to "/merchants/#{params[:merchant_id]}/bulk_discounts"
  end
end
