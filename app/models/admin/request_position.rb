class Admin::RequestPosition < ActiveRecord::Base

  belongs_to :request
  belongs_to :article

  validates :quantity, presence: true

end
