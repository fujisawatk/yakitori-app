class Post < ApplicationRecord
  belongs_to :user
  has_one :restaurant, dependent: :destroy
  accepts_nested_attributes_for :restaurant
  has_many :post_category_relations
  has_many :categories, through: :post_category_relations
  has_many :comments, dependent: :destroy

  mount_uploader :img, ImgUploader
end