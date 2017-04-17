class Group < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validate :user_ids_validation
  has_many :user_groups
  has_many :users, through: :user_groups
  has_many :messages

  def user_ids_validation
    errors.add(:name, "メンバーが選択されていません") unless user_ids.present?
  end
end
