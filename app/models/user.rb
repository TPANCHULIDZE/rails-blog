class User < ApplicationRecord
  include ActiveModel::Validations
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  enum status: %i[guest member admin]
  after_initialize :set_default_status, if: :new_record?

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :mobiles, dependent: :destroy
  has_many :locations, dependent: :destroy
  
  mount_uploader :avatar, AvatarUploader

  validates :avatar, file_size: { less_than_or_equal_to: 5.megabytes }
  validates :status, presence: true

  private 

  def set_default_status
    self.status ||= :guest
  end
end
