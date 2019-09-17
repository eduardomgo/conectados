class Post < ApplicationRecord
    # Dependências
    has_one_attached :image
    belongs_to :user
    has_many :likes, dependent: :destroy
    has_many :comments, dependent: :destroy
    
    # Validações
    validate :image_size
    validates :content, presence: true, length: {in: 2..140}

    def image_size
        if image.attached? and image.blob.byte_size > 1000000
            image.purge
            errors.add(:icon,  "Imagem muito grande")
        end
    end
end
