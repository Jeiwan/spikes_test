class Admin::Invoice < ActiveRecord::Base

  has_many :invoice_positions
  accepts_nested_attributes_for :invoice_positions, allow_destroy: true

  paginates_per 2

end
