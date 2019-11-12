require 'rails_helper'

describe 'Likes', type: :system do
  let(:user_a) {  FactoryBot.create(:user, nickname: 'user_a', email: 'test@example.com') }
  let(:user_b) {  FactoryBot.create(:user, nickname: 'user_b', email: 'testb@example.com') }

  describe 'いいね機能' do
    context 'ログインユーザー' do
      before do
        @post = FactoryBot.create(:post, user: user_a)
        sign_in(user_b)
      end

      it 'いいねが出来ること' do
        expect do
          visit root_path
          first(:css, '.post-item').click

          expect(page).to have_content(@post.title)
          expect(page).to have_content(@post.body)

          first(:css, '#nolike').click

          expect(page).to have_selector '#like'
        end.to change(Like, :count).by(1)
      end

      it 'いいねの取り消しが出来ること' do
        expect do
          FactoryBot.create(:like, user: user_b, post: @post)
          visit root_path
          first(:css, '.post-item').click

          expect(page).to have_content(@post.title)
          expect(page).to have_content(@post.body)

          first(:css, '#like').click

          expect(page).to have_selector '#nolike'
        end.to change(Like, :count).by(0)
      end
    end

    context '未ログインユーザー' do
      before do
        @post = FactoryBot.create(:post, user: user_a)
        FactoryBot.create(:like, user: user_b, post: @post)
      end

      it 'いいね出来ないこと' do
        visit root_path
        first(:css, '.post-item').click

        expect(page).to have_content(@post.title)
        expect(page).to have_content(@post.body)

        expect(page).to have_selector '#nolike-icon'
        expect(page).to_not have_selector '#like'
      end
    end
  end
end