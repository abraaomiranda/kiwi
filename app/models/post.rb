class Post < ApplicationRecord

  belongs_to :author, class_name: 'User', foreign_key: 'user_id'

  validates :author, presence: true
  validates :content, presence: true, length: { maximum: 140 }

  default_scope { order(created_at: :desc) }

  delegate :username, :name, to: :author, prefix: true

end
