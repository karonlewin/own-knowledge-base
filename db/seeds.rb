# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Review.destroy_all
Annotation.destroy_all
User.destroy_all

User.create(email: 'karon@karon.com', password: '123456')

a = Annotation.create(title: 'test', content: 'content test')
r = a.reviews.first
r.date = DateTime.now
r.save!
