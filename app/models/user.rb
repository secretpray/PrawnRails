class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: %i[user admin].freeze, _default: :user
  validates :email, presence: true, uniqueness: true
  validates :role, presence: true, inclusion: { in: roles.keys }
  after_commit :set_username, on: %i[create update]

  private

  def set_username
    return if username.present?

    username = email.split('@').first
    update(username: username)
  end
end
