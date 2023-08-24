class Post < ApplicationRecord

  belongs_to :user
  has_many :comments

  validates :title, presence: true
  validates :content, presence: true

  def as_json(options = {})
    super(options.merge(include: [:user, comments: {include: :user}]))
  end
end
