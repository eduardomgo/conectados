class Friend < ApplicationRecord
  belongs_to :asker, class_name: "User"
  belongs_to :replyer, class_name: "User"
end
