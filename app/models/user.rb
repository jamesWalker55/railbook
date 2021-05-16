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

  def friends
    forward_friend_ids = friendships.select("friend_id as user_id").where(accepted: true)
    backwards_friend_ids = inverse_friendships.select(:user_id).where(accepted: true)
    User.where(id: forward_friend_ids).or(User.where(id: backwards_friend_ids))
  end

  def received_friendships
    # backwards_friend_ids = inverse_friendships.select(:user_id).where(accepted: false)
    # User.where(id: backwards_friend_ids)
    inverse_friendships.where(accepted: false)
  end

  def sent_friendships
    # forward_friend_ids = friendships.select("friend_id as user_id").where(accepted: false)
    # User.where(id: forward_friend_ids)
    friendships.where(accepted: false)
  end
end
