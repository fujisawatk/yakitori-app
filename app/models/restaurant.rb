class Restaurant < ApplicationRecord
  belongs_to :post

  validate :restaurant_check

  private
    def restaurant_check
      errors.add(:name, 'を登録してください') if !name.present?
    end

end
