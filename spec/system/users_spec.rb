require 'rails_helper'

describe 'Users', type: :system do
  describe '新規登録機能' do
    it 'ニックネームとメールアドレス、パスワードを入力・送信すると、アカウントが作成されること' do
      expect do
        visit new_user_registration_path
        fill_in 'user_nickname', with: 'テスト太郎'
        fill_in 'user_email', with: 'test1234@example.com'
        fill_in 'user_password', with: 'test1234'
        fill_in 'user_password_confirmation', with: 'test1234'
        click_button '新規登録'

        expect(page).to have_content 'アカウントを登録しました。'
        expect(page).to have_link '投稿する'
        expect(page).to have_selector 'a[data-method=delete]', text: 'ログアウト'
      end.to change(User, :count).by(1)
    end
  end

  describe 'ログイン機能' do
    let(:user) do
      FactoryBot.create(:user)
    end

    it 'メールアカウントでログインできること' do
      visit new_user_session_path
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_button 'ログイン'

      expect(page).to have_content 'ログインしました。'
      expect(page).to have_link '投稿する'
      expect(page).to have_selector 'a[data-method=delete]', text: 'ログアウト'
    end
  end

  describe 'ログアウト機能' do
    it 'ログアウト出来る' do
      user = FactoryBot.create(:user)
      sign_in(user)

      visit root_path
      click_link 'ログアウト'
      expect(page).to have_content 'ログアウトしました。'
      expect(page).not_to have_link '投稿する'
      expect(page).to have_link 'ログイン'
    end
  end
end