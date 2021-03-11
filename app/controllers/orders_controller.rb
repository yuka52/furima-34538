class OrdersController < ApplicationController
  def index
    @orders_destination = OrderDestination.new
  end

  def create
  end
end
