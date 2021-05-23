class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook]

  validates :name, presence: true

  has_many :friendships, dependent: :delete_all
  has_many :posts, dependent: :delete_all
  has_many :like_relations, dependent: :delete_all
  has_many :comments, dependent: :delete_all
  has_one_attached :image, dependent: :delete_all

  # class_name is literally the name of the class
  # for example, User.create -> class name is "User"
  has_many :inverse_friendships, class_name: "Friendship", foreign_key: :friend_id

  # send mail after user creation
  after_create :send_welcome_mail
  def send_welcome_mail
    UserMailer.with(user: self).welcome_email.deliver_later
  end

  def friends(include_self: false)
    forward_friend_ids = friendships.select("friend_id as user_id").where(accepted: true)
    backwards_friend_ids = inverse_friendships.select(:user_id).where(accepted: true)
    base_relation = User.where(id: forward_friend_ids).or(User.where(id: backwards_friend_ids))
    if include_self
      base_relation.or(User.where(id: self))
    else
      base_relation
    end
  end

  def sent_friendships(return_users: false)
    if return_users
      User.where(id: friendships.select("friend_id as user_id").where(accepted: false))
    else
      friendships.where(accepted: false)
    end
  end

  def received_friendships(return_users: false)
    if return_users
      User.where(id: inverse_friendships.select(:user_id).where(accepted: false))
    else
      inverse_friendships.where(accepted: false)
    end
  end

  def has_friendship
    friends.or(sent_friendships(return_users: true)).or(received_friendships(return_users: true))
  end

  def get_friendship(user)
    # return this user's friendship with another user
    friendships.where(friend_id: user).or(inverse_friendships.where(user_id: user)).first
  end
end
