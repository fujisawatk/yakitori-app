require 'rails_helper'

describe Comment do
  describe '#create' do
    context 'コメント出来ること' do
      it "commentが入力されていたら登録出来ること" do
        comment = create(:comment)
        expect(comment).to be_valid
      end

      it "commentが200文字以下であれば登録出来ること" do
        num = 200
        com = "a" * num
        comment = build(:comment, comment: com)
        expect(comment).to be_valid
      end
    end

    context 'コメント出来ないこと' do
      it 'commentが空では登録出来ないこと' do
        comment = build(:comment, comment: "")
        comment.valid?
        expect(comment.errors[:comment]).to include("を入力してください")
      end

      it "commentが200文字以上では登録出来ないこと" do
        num = 201
        com = "a" * num
        comment = build(:comment, comment: com)
        comment.valid?
        expect(comment.errors[:comment]).to include("は200文字以内で入力してください")
      end
    end
  end
end
