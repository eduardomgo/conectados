class Friend < ApplicationRecord
  belongs_to :asker, class_name: "User"
  belongs_to :replyer, class_name: "User"
  
  validate :no_narcisism
  validate :reflex

  def no_narcisism
    if self.asker.id == self.replyer.id
      errors.add(:narcisist,  "Você não pode se adicionar")
    end
  end
end
