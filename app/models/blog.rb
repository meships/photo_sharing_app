class Blog < ApplicationRecord
    validates :title, presence: true
    validates :title, length: { minimum: 1, maximum:75}
    belongs_to :user
    mount_uploader :image, ImageUploader
    has_many :favorites, dependent: :destroy
    has_many :favorite_users, through: :favorites, source: :user
end