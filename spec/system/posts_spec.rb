# frozen_string_literal: true

require 'rails_helper'

describe 'Posts', type: :system do
  let(:user_a) {  FactoryBot.create(:user, nickname: 'user_a', email: 'test@example.com') }
  let(:user_b) {  FactoryBot.create(:user, nickname: 'user_b', email: 'testb@example.com') }

  describe '記事投稿機能' do
    before do
      sign_in(user_a)
      visit root_path
      click_link '投稿する'
    end

    it '記事を投稿出来ること' do
      expect do
        attach_file '画像', "spec/factories/images/test.jpeg"
        fill_in 'タイトル', with: '焼き鳥'
        fill_in '本文', with: '美味しい！'
        check 'もも'

        fill_in 'key', with: '鳥貴族 鶴見東口店'
        click_button('検索')
        wait_for_ajax
        find("input[data-id='0']").click
        click_button '投稿する'

        expect(page).to have_current_path root_path
        expect(page).to have_content '記事を投稿しました'
      end.to change(Post, :count).by(1)
    end

    it 'おすすめの焼き鳥を複数選択しても、記事を投稿出来ること' do
      expect do
        attach_file '画像', "spec/factories/images/test.jpeg"
        fill_in 'タイトル', with: '焼き鳥'
        fill_in '本文', with: '美味しい！'
        check 'もも'
        check 'むね'
        check 'ねぎま'

        fill_in 'key', with: '鳥貴族 鶴見東口店'
        click_button('検索')
        wait_for_ajax
        find("input[data-id='0']").click
        click_button '投稿する'

        expect(page).to have_current_path root_path
        expect(page).to have_content '記事を投稿しました'
      end.to change(Post, :count).by(1)
    end

    it '未記入の項目があれば、入力した値を残して投稿画面にリダイレクトされる' do
      expect do
        fill_in 'タイトル', with: ''
        fill_in '本文', with: '美味しい！'
        click_button '投稿する'

        expect(page).to have_content '投稿する'
        expect(page).to have_content 'タイトルを入力してください'
        expect(find_field('本文').value).to eq('美味しい！')
      end.to_not change(Post, :count)
    end
  end

  describe '記事詳細表示機能' do
    before do
      @post = FactoryBot.create(:post, title: "焼き鳥", body: '美味しい！', user: user_a)
    end

    context '記事を投稿したユーザー' do
      before do
        sign_in(user_a)
      end

      it '記事の詳細を閲覧出来、編集・削除機能を選択できること' do
        visit root_path
        first(:css, '.post-item').click
        # 詳細データ
        expect(page).to have_content(@post.title)
        expect(page).to have_content(@post.body)
        expect(page).to have_content('もも')
        expect(page).to have_content(@post.restaurant.name)
        link = find('.button_to')
        expect(link[:action]).to eq "https://example.com/"
        # 編集・削除アイコン
        expect(page).to have_selector '#edit-icon'
        expect(page).to have_selector '#del-icon'
      end
    end

    context '記事を投稿していないユーザー' do
      before do
        sign_in(user_b)
      end

      it '記事の詳細を閲覧出来るが、編集・削除機能を選択出来ないこと' do
        visit root_path
        first(:css, '.post-item').click
        # 詳細データ
        expect(page).to have_content(@post.title)
        expect(page).to have_content(@post.body)
        expect(page).to have_content('もも')
        expect(page).to have_content(@post.restaurant.name)
        link = find('.button_to')
        expect(link[:action]).to eq "https://example.com/"
        # 編集・削除アイコン
        expect(page).to_not have_selector '#edit-icon'
        expect(page).to_not have_selector '#del-icon'
      end
    end
  end

  describe '記事編集・削除機能' do
    before do
      @post = FactoryBot.create(:post, title: "未編集のタイトル", body: '未編集の本文', user: user_a)
    end

    context '記事を投稿したユーザー' do
      before do
        sign_in(user_a)
      end

      it '記事を編集出来ること' do
        expect do
          visit post_path(@post)
          find("#edit-icon").click

          expect(find_field('タイトル').value).to eq(@post.title)
          fill_in 'タイトル', with: '編集済みのタイトル'

          expect(find_field('本文').value).to eq(@post.body)
          fill_in '本文', with: '編集済みの本文'

          expect(page).to have_checked_field('もも')
          check 'ねぎま'

          fill_in 'key', with: '鳥貴族 京急川崎駅前店'
          click_button('検索')
          wait_for_ajax
          find("input[data-id='0']").click
          click_button '変更する'

          expect(page).to have_current_path mylist_user_path(user_a)
          expect(page).to have_content '記事を編集しました。'
        end.to_not change(Post, :count)
      end

      it '未記入の項目があれば、入力した値を残して編集画面にリダイレクトされる' do
        expect do
          visit post_path(@post)
          find("#edit-icon").click

          fill_in 'タイトル', with: ''
          click_button '変更する'

          expect(page).to have_content '編集する'
          expect(page).to have_content 'タイトルを入力してください'
          expect(find_field('本文').value).to eq('未編集の本文')
        end.to_not change(Post, :count)
      end

      it '記事を削除出来ること' do
        expect do
          visit post_path(@post)
          find("#del-icon").click

          expect(page.driver.browser.switch_to.alert.text).to eq "削除しますか？"
          page.driver.browser.switch_to.alert.accept

          expect(page).to have_current_path mylist_user_path(user_a)
          expect(page).to have_content '記事を削除しました。'
        end.to change(Post, :count).by(-1)
      end
    end
    context '記事を投稿していないユーザー' do
      before do
        sign_in(user_b)
      end

      it 'URLで編集しようとしたら、トップページにリダイレクトされること' do
        visit edit_post_path(@post)
        expect(current_path).to eq root_path
        expect(page).to have_content '記事を編集出来ません。'
      end
    end
  end

  describe '記事検索機能' do
    before do
      @post = FactoryBot.create(:post, title: "焼き鳥", body: '美味しい！', user: user_a)
    end

    it '全てのユーザーが検索出来ること' do
      visit root_path
      fill_in 'post_keyword', with: '焼き鳥'
      find("#search-button").click

      expect(page).to have_content '"焼き鳥"の検索結果'
      expect(page).to have_selector '.post-item'
    end
  end
end
