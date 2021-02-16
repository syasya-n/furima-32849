class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new,:edit]
  before_action :set_item, only: [:destroy,:show,:edit,:update]

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

  def update
    redirect_to root_path if current_user.id != @item.user.id
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit
    end
  end

  def edit
    redirect_to root_path if current_user.id != @item.user.id
  end

  def destroy
    if current_user.id == @item.user.id
      if @item.destroy
        redirect_to root_path
      else
        render :show
      end
    end
  end

  def show
  end
  
  private

  def item_params
    params.require(:item).permit(:image, :name, :description, :category_id, :condition_id, :shipping_fee_person_id,
                                 :ship_from_region_id, :delivery_day_id, :price).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
