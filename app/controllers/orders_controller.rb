class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  
  def index
    @item = Item.find(params[:item_id])
    if Order.exists?(item_id:@item.id) || @item.user_id == current_user.id
      redirect_to root_path
    else
      @order_information = OrderInformation.new
    end
  end

  def create
    @item = Item.find(params[:item_id])
    @order_information = OrderInformation.new(order_information_params)
    if @order_information.valid? && @order_information.save
      redirect_to root_path
    else
      render :index
    end
  end

  def order_information_params
    params.require(:order_information).permit(:post_code,:region_id,:city,:address,:building,:phone_number,:item_id).merge(item_id:@item.id,user_id: current_user.id)
  end
end
