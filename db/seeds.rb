# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

a = User.create(email: "a@a", password: "aaaaaa")
b = User.create(email: "b@b", password: "bbbbbb")
c = User.create(email: "c@c", password: "cccccc")
d = User.create(email: "d@d", password: "dddddd")
e = User.create(email: "e@e", password: "eeeeee")

# a = User.find_by(email: "a@a");b = User.find_by(email: "b@b");c = User.find_by(email: "c@c");d = User.find_by(email: "d@d");e = User.find_by(email: "e@e");

a.friendships.build(friend: b, accepted: true).save
a.friendships.build(friend: c, accepted: true).save
a.friendships.build(friend: d, accepted: false).save
a.friendships.build(friend: e, accepted: false).save

b.friendships.build(friend: c, accepted: true).save
b.friendships.build(friend: d, accepted: true).save

c.friendships.build(friend: d, accepted: true).save

d.friendships.build(friend: e, accepted: false).save

