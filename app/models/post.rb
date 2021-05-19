class Post < ApplicationRecord
  has_many :like_relations
  has_many :comments
  belongs_to :user
end
