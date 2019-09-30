class Post < ApplicationRecord
  belongs_to :user
  has_one :restaurant, dependent: :destroy
  accepts_nested_attributes_for :restaurant

  mount_uploader :img, ImgUploader
end
