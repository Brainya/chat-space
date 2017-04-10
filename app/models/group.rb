class Group < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :user_groups
  has_many :users, through: :user_groups
  accepts_nested_attributes_for :users
end
