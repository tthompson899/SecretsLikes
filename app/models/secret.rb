class Secret < ActiveRecord::Base
  belongs_to :user

  has_many :likes, dependent: :destroy
  has_many :users_liked, through: :likes, source: :user #changed for consistency but was not neccessary

  validates :content, presence: :true
end
