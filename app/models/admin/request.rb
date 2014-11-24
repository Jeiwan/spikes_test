class Admin::Request < ActiveRecord::Base

  has_many :request_positions, class_name: "Admin::RequestPosition"
  accepts_nested_attributes_for :request_positions

end
