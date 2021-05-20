class Post < ApplicationRecord
  has_many :like_relations, dependent: :delete_all
  has_many :comments, dependent: :delete_all
  belongs_to :user

  def get_user_like(user)
    query = like_relations.where(user: user)
    if query.count > 0
      [:liked, query.first]
    else
      [nil, like_relations.build(user: user)]
    end
  end

  def self.visible_to_user(user)
    where(user: user.friends(include_self: true))
  end
end
