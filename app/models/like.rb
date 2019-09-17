class Like < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validate :check_existence

  def check_existence
    if Like.find_by(post_id: self.post.id, user_id: self.user.id)
      errors.add(:lik,  "Já gostou deste post")
    end
  end
end
