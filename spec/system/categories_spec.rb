require 'rails_helper'

describe 'Categories', type: :system do

  describe 'カテゴリーページ' do
    before do
      @post = FactoryBot.create(:post)
    end

    it '全てのユーザーがアクセス出来る' do
      visit root_path
      find('#sidebar').hover
      wait_for_ajax
      # テスト用カテゴリーのため、追加される要素の最後を指定
      page.all(".sidebar-parts")[14].click

      expect(page).to have_current_path category_path(@post.category_ids[0])
      expect(page).to have_content 'もも串の投稿一覧'
      expect(page).to have_selector '.post-item'
    end
  end
end