class CartProductsController < ApplicationController
  def index
    cart = current_user.cart || current_user.create_cart
    @products = current_user.cart.products  # ログインユーザーのカート内の商品情報を代入
  end
  
  def create
    cart = current_user.cart || current_user.create_cart  # ログインユーザーがカートを持っていればそれを変数に代入、持っていなければオブジェクトを生成して代入
    product = Product.find_by(id: params[:product_id])  # パラメーターで送られてきた商品IDを元にレコードを代入
    cart.cart_products.create(product_id: product.id)  # create_cartは、has_one関連づけをすると使用できるメソッドで、.create_<関連先>とすることでオブジェクトを生成できる。つまりこの場合はログインユーザーに紐づくカートが生成される（cartsテーブルにuser_idが保存される）。
    redirect_to product_path(product), notice: "カートに追加しました"
  end
end