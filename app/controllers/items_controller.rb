class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_item, only: [:edit, :show, :update, :destroy]
  before_action :redirect_root, only: [:edit, :update, :destroy]
  
  def index
    @items = Item.all.order('created_at DESC')
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
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit
    end
  end

  def destroy
    redirect_to root_path if @item.destroy
  end

  def listed
    items = Item.all
    @myitems = current_user.items
    
    this_month = Date.today.all_month
    @price = 0
    @myitems.each do |item|
     if (item.order.present?) && (this_month.include?(Date.parse(item.order[:created_at].to_s)))
       @price += item.price
     end
    end
  end

  private

  def item_params
    params.require(:item).permit(
      :image, :name, :description, :category_id, :condition_id,
      :delivery_fee_id, :prefecture_id, :days_to_ship_id, :price
    ).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def redirect_root
    if (current_user.id != @item.user_id) || !@item.order.nil?
      redirect_to root_path
    end
  end
end