class Post < ApplicationRecord
  has_many :like_relations
  belongs_to :user
end
