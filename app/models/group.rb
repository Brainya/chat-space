class Group < ApplicationRecord
  has_many :users
  validates :name, presence: true, uniqueness: true
  accepts_nested_attributes_for :users
end
