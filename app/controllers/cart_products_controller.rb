class CartProductsController < ApplicationController
  def create
    if current_user.cart  # ログインユーザーが買い物カゴを持っている場合
      cart = current_user.cart
      product = Product.find_by(id: params[:product_id])  # パラメーターで送られてきた商品IDを元にレコードを代入
      cart.cart_products.create(product_id: product.id)  # cart_idとproduct_idを保存
      redirect_to product_path(product), notice: "カートに追加しました"
    else  # ログインユーザーが買い物カゴを持っていない場合
      cart = current_user.create_cart  # create_cartは、has_one関連づけをすると使用できるメソッドで、.create_<関連先>とすることでオブジェクトを生成できる。つまりこの場合はログインユーザーに紐づくカートが生成される（cartsテーブルにuser_idが保存される）。
      product = Product.find_by(id: params[:product_id])
      cart.cart_products.create(product_id: product.id)
      redirect_to product_path(product), notice: "カートに追加しました"
    end
  end
end