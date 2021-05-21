class Friendship < ApplicationRecord
  validates :user, presence: true
  validates :friend, presence: true
  # presence doesn't work with boolean fields
  # validates :accepted, presence: true
  validates_inclusion_of :accepted, in: [true, false]

  belongs_to :user, counter_cache: true
  belongs_to :friend, class_name: "User"
end
