class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook]

  has_many :friendships
  # has_many :friends, through: :friendships

  # class_name is literally the name of the class
  # for example, User.create -> class name is "User"
  has_many :inverse_friendships, class_name: "Friendship", foreign_key: :friend_id
  # has_many :inverse_friends, through: :inverse_friendships, source: :user
end
