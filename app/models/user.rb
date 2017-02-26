class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :login

  has_many :posts
  has_many :follows_relation, class_name: 'Follow', foreign_key: 'follower_id', dependent: :destroy
  has_many :followers_relation, class_name: 'Follow', foreign_key: 'followed_id', dependent: :destroy
  has_many :followers, class_name: 'User', through: :followers_relation, source: :follower
  has_many :follows, class_name: 'User', through: :follows_relation, source: :followed
  has_many :notifications, foreign_key: 'recipient_id'

  validates :username,
            :presence => true,
            :uniqueness => {
                :case_sensitive => false
            }

  validates :name, presence: true

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_hash).first
    end
  end

  def following?(user)
    follows.include? user
  end

end
