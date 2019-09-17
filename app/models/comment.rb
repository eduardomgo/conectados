class Comment < ApplicationRecord
    # Dependências
    belongs_to :user
    belongs_to :post

    # Validações
    validates :content, presence: true, length: {in: 2..140}
end