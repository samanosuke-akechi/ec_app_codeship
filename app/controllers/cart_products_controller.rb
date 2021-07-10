class CartProductsController < ApplicationController
  def index
    cart = current_user.cart || current_user.create_cart
    @products = current_user.cart.products  # ログインユーザーのカート内の商品情報を代入
    @total_price = @products.pluck(:price).sum()  # カート内の全商品の値段の合計を取得
    @product_group = @products.group(:name).count
  end
  
  def create
    cart = current_user.cart || current_user.create_cart  # ログインユーザーがカートを持っていればそれを変数に代入、持っていなければオブジェクトを生成して代入
    product = Product.find_by(id: params[:product_id])  # パラメーターで送られてきた商品IDを元にレコードを代入
    cart.cart_products.create(product_id: product.id)  # create_cartは、has_one関連づけをすると使用できるメソッドで、.create_<関連先>とすることでオブジェクトを生成できる。つまりこの場合はログインユーザーに紐づくカートが生成される（cartsテーブルにuser_idが保存される）。
    redirect_to cart_products_path, notice: "カートに追加しました"
  end

  def destroy
    cart = current_user.cart
    product = Product.find(params[:product_id])
    delete_product = cart.cart_products.find_by(product_id: product.id)
    delete_product.destroy
    redirect_to products_path, notice: "削除しました"
  end
end