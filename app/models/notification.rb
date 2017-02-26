class Notification < ApplicationRecord
  belongs_to :owner, class_name: 'User'
  belongs_to :recipient, :class_name => 'User'

  validates :message, :reference_id, :reference_class, presence: true

  default_scope { order(created_at: :desc) }

  def reference
    @reference ||= reference_class.constantize.find_by(id: reference_id)
  end
end
