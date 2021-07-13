require 'rails_helper'

RSpec.describe 'User', type: :system do
  describe 'ユーザー認証機能' do
    before do
      User.create(
        name: "john",
        email: "john@example",
        password: "abc123",
        password_confirmation: "abc123"
      )
    end

    it 'ログインができる' do
      # ログインページへアクセス
      visit new_user_session_path
      # emailを入力
      fill_in "user_email", with: "john@example"
      # passwordを入力
      fill_in "user_password", with: "abc123"
      # ログインボタンをクリック
      find('input[value="Log in"]').click
      # 商品一覧ページへ遷移していることを確認
      expect(current_path).to eq(products_path)
      # 「ログインしました。」が表示されていることを確認
      expect(page).to have_content 'ログインしました。'
    end
  end
end