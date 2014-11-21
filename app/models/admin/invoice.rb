class Admin::Invoice < ActiveRecord::Base
  has_many :invoice_positions

end
