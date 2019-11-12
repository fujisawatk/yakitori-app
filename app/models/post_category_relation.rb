# frozen_string_literal: true

class PostCategoryRelation < ApplicationRecord
  belongs_to :post
  belongs_to :category
end
