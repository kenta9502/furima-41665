class PurchasesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :set_product, only: [:index, :create]
  before_action :redirect_if_seller_or_sold, only: [:index]

  def index
    # @product
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @purchase_address = PurchaseAddress.new(user_id: current_user.id, product_id: @product.id)
  end

  def create
    @purchase_address = PurchaseAddress.new(purchase_address_params)
    if @purchase_address.valid?
      pay_item
      @purchase_address.save
      redirect_to root_path, notice: '購入が完了しました。'
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_product
    @product = Product.find(params[:item_id])
  end

  # Add this new method and add it to before_actions
  def redirect_if_seller_or_sold
    # Prevent seller from accessing purchase page for their own item
    if @product.user_id == current_user.id
      redirect_to root_path, alert: 'ご自身の出品物は購入できません。'
    # Prevent accessing purchase page for an already sold item
    elsif @product.purchase.present?
      redirect_to root_path, alert: '商品は売却済みです。'
    end
  end

  def purchase_address_params
    params.require(:purchase_address).permit(:post_code, :prefecture_id, :municipality, :street_address, :building_name,
                                             :phone_number).merge(user_id: current_user.id, product_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @product.price,
      card: purchase_address_params[:token],
      currency: 'jpy'
    )
  end
end
