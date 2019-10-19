class Post < ApplicationRecord
  belongs_to :user
  has_one :restaurant, dependent: :destroy
  accepts_nested_attributes_for :restaurant
  has_many :post_category_relations, dependent: :destroy
  has_many :categories, through: :post_category_relations
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post

  mount_uploader :img, ImgUploader

  validates :title, length: { maximum: 40 }, presence: true
  validates :body, length: { maximum: 1000 }, presence: true
  validate :category_check
  validate :img_check

  private
    def img_check
      if img.present?
          errors.add(:img, 'の拡張子がJPEGまたはPNGを挿入してください') if !img.content_type.in?(%('image/jpeg image/png'))
      else
        errors.add(:img, 'を挿入してください')
      end
    end

    def category_check
      errors.add(:category_ids, 'のおすすめを選択してください') if !category_ids.present?
    end

end