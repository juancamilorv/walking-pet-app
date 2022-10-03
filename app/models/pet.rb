class Pet < ApplicationRecord
  belongs_to :user
  has_many :users, through: :services

  has_one_attached :photo
end
