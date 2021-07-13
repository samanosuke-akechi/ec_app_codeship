require 'rails_helper'

RSpec.describe 'Product', type: :system do
  describe '商品一覧機能' do
    before do
      product = Product.create(
        name: "どら焼き",
        description: "美味しいです",
        price: 100
      )
    end

    it '作成した商品が表示されている' do
      # 商品一覧ページへアクセスする
      visit products_path
      # 作成した商品が登録されている
      expect(page).to have_content 'どら焼き'
      expect(page).to have_content '100'
    end
  end
end
