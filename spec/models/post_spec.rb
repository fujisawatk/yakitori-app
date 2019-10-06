require 'rails_helper'
require 'faker'

describe Post do
  describe '#build' do
    context '新規投稿出来ること' do
      it "全ての項目が存在すれば投稿出来ること" do
        post = create(:post)
        expect(post).to be_valid
      end

      it "titleが40文字以下であれば登録出来ること" do
        num = 40
        title = "a" * num
        post = build(:post, title: title)
        expect(post).to be_valid
      end

      it "bodyが1000文字以下であれば登録出来ること" do
        num = 1000
        body = "a" * num
        post = build(:post, body: body)
        expect(post).to be_valid
      end

      it "categoryが複数選択されても登録出来ること" do
        post = build(:post)
        post.categories << FactoryBot.build(:category, name: "むね")
        expect(post).to be_valid
      end
    end

    context '新規投稿出来ないこと' do
      it "titleが空では登録出来ないこと" do
        post = build(:post, title: "")
        post.valid?
        expect(post.errors[:title]).to include("を入力してください")
      end

      it "titleが41文字以上では登録出来ないこと" do
        num = 41
        title = "a" * num
        post = build(:post, title: title)
        post.valid?
        expect(post.errors[:title]).to include("は40文字以内で入力してください")
      end

      it "bodyが空では登録出来ないこと" do
        post = build(:post, body: "")
        post.valid?
        expect(post.errors[:body]).to include("を入力してください")
      end

      it "bodyが1001文字以上では登録出来ないこと" do
        num = 1001
        body = "a" * num
        post = build(:post, body: body)
        post.valid?
        expect(post.errors[:body]).to include("は1000文字以内で入力してください")
      end

      it "imgが空では登録出来ないこと" do
        post = build(:post, img: "")
        post.valid?
        expect(post.errors[:img]).to include("を挿入してください")
      end

      it "imgの拡張子がJPEGまたはPNG以外では登録出来ないこと" do
        img = File.open("#{Rails.root}/spec/factories/images/test.bmp")
        post = build(:post, img: img)
        post.valid?
        expect(post.errors[:img]).to include("の拡張子がJPEGまたはPNGを挿入してください")
      end
      
      it "categoryが空では登録出来ないこと" do
        post = build(:post)
        post.categories.clear
        post.valid?
        expect(post.errors[:category_ids]).to include("のおすすめを選択してください")
      end
      
      it "restrauntが空では登録出来ないこと" do
        post = build(:post)
        post.restaurant.name = ""
        post.restaurant.url = ""
        post.valid?
        expect(post.restaurant.errors[:name]).to include("を登録してください")
      end

    end
  end
end