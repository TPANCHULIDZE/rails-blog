class User < ApplicationRecord
  include ActiveModel::Validations

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  devise :omniauthable, omniauth_providers: [:google_oauth2]

  enum status: %i[guest member admin]
  after_initialize :set_default_status, if: :new_record?

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :mobiles, dependent: :destroy
  has_many :locations, dependent: :destroy
  
  mount_uploader :avatar, AvatarUploader

  validates :username, presence: true
  validates :avatar, file_size: { less_than_or_equal_to: 5.megabytes }
  validates :status, presence: true

  def self.from_omniauth(auth)
  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    user.email = auth.info.email
    user.password = Devise.friendly_token[0, 20]
    user.username = auth.info.name
    user.skip_confirmation!
  end
end
  
  private 

  def set_default_status
    self.status ||= :guest
  end
end
