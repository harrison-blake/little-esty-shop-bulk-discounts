# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Merchant.first.bulk_discounts.create!(name: "Discount 1",
                                      discount: 0.15,
                                      threshold: 10)

Merchant.first.bulk_discounts.create!(name: "Discount 2",
                                      discount: 0.20,
                                      threshold: 15)
