class AddNicknameToUsers < ActiveRecord::Migration[5.2]
  def change
    change_column_null :users, :nickname, null: false
  end
end
