# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'

50.times do
  Article.create(name: Faker::Commerce.product_name)
end

User.create(username: 'admin', password: 'adminadmin', admin: true)
User.create(username: 'buyer', password: 'buyerbuyer')
Admin::Setting.create(name: "quantity_threhsold", value: "10")
