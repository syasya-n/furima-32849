class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  before_action :set_item,only: [:index,:create]
  
  def index
    if Order.exists?(item_id:@item.id) || @item.user_id == current_user.id
      redirect_to root_path
    else
      @order_information = OrderInformation.new
    end
  end

  def create
    @order_information = OrderInformation.new(order_information_params)
    if @order_information.valid? && @order_information.save
      pay_item
      redirect_to root_path
    else
      render :index
    end
  end

  def order_information_params
    params.require(:order_information).permit(:post_code,:region_id,:city,:address,:building,:phone_number).merge(item_id:@item.id,user_id: current_user.id,token: params[:token])
  end

  private

  def set_item
    @item = Item.find(params[:item_id])  
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: order_information_params[:token],
      currency: 'jpy'
    )
  end
end
