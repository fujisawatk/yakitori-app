class Post < ApplicationRecord
  belongs_to :user
  has_one :restaurant, dependent: :destroy
  accepts_nested_attributes_for :restaurant
  has_many :categories, through: :post_categories
  has_many :post_categories

  mount_uploader :img, ImgUploader
end