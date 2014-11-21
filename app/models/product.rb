class Product < ActiveRecord::Base

  belongs_to :product_stack
  belongs_to :article

end
