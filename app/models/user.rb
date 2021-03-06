class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  enum role: [:user, :admin]

  has_one :profile, dependent: :destroy
  has_many :company_profiles
  has_many :clients
  has_many :quotations

  before_create :build_default_profile

  attr_accessor :login

  validates :username,
    presence: true,
    uniqueness: {
      case_sensitive: false
  }
  validate :validate_username

  default_scope -> { order('users.created_at DESC') }

  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { value: login.downcase }]).first
    else
      if conditions[:username].nil?
        where(conditions).first
      else
        where(username: conditions[:username]).first
      end
    end
  end

  def enterprise?
    enterprise == true
  end

  private

    def build_default_profile
      build_profile
      true
    end
end
