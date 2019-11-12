require 'rails_helper'

describe 'Comments', type: :system do
  let(:user_a) {  FactoryBot.create(:user, nickname: 'user_a', email: 'test@example.com') }
  let(:user_b) {  FactoryBot.create(:user, nickname: 'user_b', email: 'testb@example.com') }
  let(:post) { FactoryBot.create(:post, user: user_a) }

  describe 'コメント機能' do
    context 'ログインユーザー' do
      before do
        @post = FactoryBot.create(:post, user: user_a)
        @comment = FactoryBot.create(:comment, comment: "ユーザーAのコメント", post: @post)
        sign_in(user_b)
      end

      it 'コメントの閲覧、投稿が出来ること' do
        expect do
          visit root_path
          first(:css, '.post-item').click

          expect(page).to have_content(@post.title)
          expect(page).to have_content(@post.body)

          expect(page).to have_content 'ユーザーAのコメント'
          expect(page).to have_link 'user_a'

          expect(page).to have_selector '#comment-area'
          fill_in 'comment-area', with: 'ユーザーBのコメント'
          click_button 'comment-button'

          expect(page).to have_content 'ユーザーBのコメント'
          expect(page).to have_link 'user_b'
        end.to change(Comment, :count).by(1)
      end
    end

    context '未ログインユーザー' do
      before do
        @post = FactoryBot.create(:post, user: user_a)
        @comment = FactoryBot.create(:comment, comment: "ユーザーAのコメント", post: @post)
      end

      it 'コメントの閲覧は出来るが、投稿は出来ないこと' do
        visit root_path
        first(:css, '.post-item').click

        expect(page).to have_content(@post.title)
        expect(page).to have_content(@post.body)

        expect(page).to have_content 'ユーザーAのコメント'
        expect(page).to have_link 'user_a'

        expect(page).to_not have_selector '#comment-area'
        expect(page).to_not have_link 'コメントする'
      end
    end
  end
end