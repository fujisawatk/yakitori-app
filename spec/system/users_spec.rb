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

  describe 'SNS認証での新規登録' do
    before do
      Rails.application.env_config["devise.mapping"] = Devise.mappings[:user]
      Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:twitter]
      Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
      OmniAuth.config.mock_auth[:twitter] = nil
      OmniAuth.config.mock_auth[:google_oauth2] = nil
      OmniAuth.config.mock_auth[:twitter] = twitter_mock
      OmniAuth.config.mock_auth[:google_oauth2] = google_oauth2_mock
    end

    it 'Twitterアカウントで新規登録出来ること' do
      expect do
        visit root_path
        find('#twitter-signup').click
        
        expect(page).to have_content 'SNS認証でログインしました。'
        expect(page).to have_link '投稿する'
        expect(page).to have_selector 'a[data-method=delete]', text: 'ログアウト'
      end.to change(User, :count).by(1)
    end

    it 'Googleアカウントで新規登録出来ること' do
      expect do
        visit root_path
        find('#google-signup').click
        
        expect(page).to have_content 'SNS認証でログインしました。'
        expect(page).to have_link '投稿する'
        expect(page).to have_selector 'a[data-method=delete]', text: 'ログアウト'
      end.to change(User, :count).by(1)
    end

    it 'SNSアカウントを持たない場合、ログインページにリダイレクトされること' do
      
      visit root_path
      find('#twitter-signup').click
      allow(User).to receive(:from_omniauth).and_return(nil)

      expect(page).to have_current_path root_path
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

    describe 'SNS認証でのログイン機能' do
      before do
        Rails.application.env_config["devise.mapping"] = Devise.mappings[:user]
        Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:twitter]
        Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
        OmniAuth.config.mock_auth[:twitter] = nil
        OmniAuth.config.mock_auth[:google_oauth2] = nil
        OmniAuth.config.mock_auth[:twitter] = twitter_mock
        OmniAuth.config.mock_auth[:google_oauth2] = google_oauth2_mock
      end
      it 'Twitterアカウントでログイン出来ること' do
        user = FactoryBot.create(:user, nickname: 'twitter-user',
                                        provider: 'twitter',
                                        uid: "0000000000000000000"
                                )

        expect do
          visit new_user_session_path
          find('#twitter-login').click

          expect(page).to have_content 'SNS認証でログインしました。'
          expect(page).to have_link '投稿する'
          expect(page).to have_selector 'a[data-method=delete]', text: 'ログアウト'
        end.to_not change(User, :count)
      end
  
      it 'Googleアカウントでログイン出来ること' do
        user = FactoryBot.create(:user, nickname: 'google-user',
                                        provider: 'google_oauth2',
                                        uid: "100000000000000000000"
                                )

        expect do
          visit new_user_session_path
          find('#google-login').click

          expect(page).to have_content 'SNS認証でログインしました。'
          expect(page).to have_link '投稿する'
          expect(page).to have_selector 'a[data-method=delete]', text: 'ログアウト'
        end.to_not change(User, :count)
      end
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