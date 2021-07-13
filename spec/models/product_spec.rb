require 'rails_helper'

RSpec.describe Product, type: :model do
  context '商品名が入力されている場合' do
    it '商品登録が成功すること' do
      product = Product.new(
        name: "商品A",
        description: "テスト商品です",
        price: 100
      )

      expect(product).to be_valid
    end
  end

  context '商品名が入力されていない場合' do
    it '商品登録が失敗すること' do
      product = Product.new(
        name: "",
        description: "テスト商品です",
        price: 100
      )

      product.valid?
      expect(product.errors[:name]).to include("を入力してください")
    end
  end
end
