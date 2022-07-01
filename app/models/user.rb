class User < ApplicationRecord
  include ActiveModel::Validations
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  mount_uploader :avatar, AvatarUploader

  validates :avatar, file_size: { less_than_or_equal_to: 5.megabytes }
end
