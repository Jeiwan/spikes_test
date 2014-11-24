class User < ActiveRecord::Base

  has_many :orders

  validates :username, presence: true, uniqueness: { case_sensitive: false }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable

  def email_required?
      false
  end

  def email_changed?
      false
  end
end
