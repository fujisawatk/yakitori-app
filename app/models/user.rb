# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2 twitter]

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes
  has_many :liked_users, through: :likes, source: :user

  validates :nickname, presence: true, length: { maximum: 50 }
  def self.from_omniauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first
    if user.nil?
      user = User.create(
        uid: auth.uid,
        provider: auth.provider,
        nickname: auth.info.name,
        email: User.dummy_email(auth),
        password: Devise.friendly_token[0, 20]
      )
    end
    user
  end

  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end
end
