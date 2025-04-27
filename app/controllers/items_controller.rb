class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :ensure_correct_user_for_edit, only: [:edit, :update]
  before_action :ensure_correct_user_for_destroy, only: [:destroy]

  def index
    @products = Product.order(created_at: :desc)
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to root_path, notice: '商品を出品しました。'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to item_path(@product), notice: '商品情報を更新しました。'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @product.destroy
      redirect_to root_path, notice: '商品を削除しました。'
    else
      redirect_to item_path(@product), alert: '商品の削除に失敗しました。'
    end
  end

  private

  def product_params
    params.require(:product).permit(:image, :name, :description, :category_id, :condition_id, :shipping_cost_id, :prefecture_id,
                                    :shipping_date_id, :price).merge(user_id: current_user.id)
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def ensure_correct_user_for_edit
    return if @product.user_id == current_user.id

    redirect_to root_path, alert: '出品者以外のユーザーは編集できません。'
  end

  def ensure_correct_user_for_destroy
    return if @product.user_id == current_user.id

    redirect_to root_path, alert: '出品者以外のユーザーは削除できません。'
  end
end
