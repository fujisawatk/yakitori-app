# frozen_string_literal: true

class Restaurant < ApplicationRecord
  belongs_to :post

  validate :restaurant_check

  private

  def restaurant_check
    errors.add(:name, 'を登録してください') unless name.present?
  end
end
