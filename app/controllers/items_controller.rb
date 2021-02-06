class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new]

  def index
    @items = Item.includes(:user).order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
    @category = Category.data.find{|o| o[:id] == @item.category_id}
    @condition = Condition.data.find{|o| o[:id] == @item.condition_id}
    @delivery_day = DeliveryDay.data.find{|o| o[:id] == @item.delivery_day_id}
    @ship_from_region = ShipFromRegion.data.find{|o| o[:id] == @item.ship_from_region_id}
    @shipping_fee_person = ShippingFeePerson.data.find{|o| o[:id] == @item.shipping_fee_person_id}
  end
  private

  def item_params
    params.require(:item).permit(:image, :name, :description, :category_id, :condition_id, :shipping_fee_person_id,
                                 :ship_from_region_id, :delivery_day_id, :price).merge(user_id: current_user.id)
  end
end
