require 'rails_helper'

describe User do
  describe '#create' do
    context 'メールで新規登録出来ること' do
      it "nicknameとemail、passwordとpassword_confirmationが存在すれば登録できること" do
        user = build(:user)
        expect(user).to be_valid
      end

      it "nicknameが50文字以下なら登録できること" do
        str = "a"
        num = 50
        name = str * num
        user = build(:user, nickname: name)
        expect(user).to be_valid
      end

      it "passwordが6文字以上であれば登録出来ること" do
        user = build(:user, password: "000000", password_confirmation: "000000")
        expect(user).to be_valid
      end

      it "passwordが20文字以上であれば登録出来ること" do
        str = "0"
        num = 20
        pass = str * num
        user = build(:user, password: pass, password_confirmation: pass)
        expect(user).to be_valid
      end
    end

    context 'メールで新規登録出来ないこと'do
      it "nicknameが空では登録できないこと" do
        user = build(:user, nickname: "")
        user.valid?
        expect(user.errors[:nickname]).to include("を入力してください")
      end
      
      it "nicknameが51文字以上では登録できないこと" do
        str = "a"
        num = 51
        name = str * num
        user = build(:user, nickname: name)
        user.valid?
        expect(user.errors[:nickname]).to include("は50文字以内で入力してください")
      end

      it "emailが空では登録できないこと" do
        user = build(:user, email: "")
        user.valid?
        expect(user.errors[:email]).to include("が入力されていません。")
      end

      it "重複したemailが存在する場合登録出来ないこと" do
        user = create(:user)
        second_user = build(:user, email: user.email)
        second_user.valid?
        expect(second_user.errors[:email]).to include("は既に使用されています。")
      end
      it "passwordが空では登録できないこと" do
        user = build(:user, password: "")
        user.valid?
        expect(user.errors[:password]).to include("が入力されていません。")
      end

      it "passwordが存在してもpassword_confirmationが空では登録できないこと" do
        user = build(:user, password_confirmation: "")
        user.valid?
        expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
      end

      it "passwordが5文字以下であれば登録出来ないこと" do
        user = build(:user, password: "00000", password_confirmation: "00000")
        user.valid?
        expect(user.errors[:password]).to include("は6文字以上に設定して下さい。")
      end

      it "passwordが21文字以下であれば登録出来ないこと" do
        str = "0"
        num = 21
        pass = str * num
        user = build(:user, password: pass, password_confirmation: pass)
        user.valid?
        expect(user.errors[:password]).to include("は20文字以下に設定して下さい。")
      end
    end
  end
end