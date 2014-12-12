# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)





10.times do |i|

	user = User.new(:email => i.to_s+"@"+i.to_s+".com", :password => i.to_s,  :password_confirmation => i.to_s)
	user.save!
	puts "user", i
end

10000.times do |i|
	Video.create(title: i.to_s, category: "action", user_id: i % 10 + 1)
	puts "video", i
end



10000.times do |i|
	Comment.create(message: i.to_s, video_id: i%10, user_id: i % 10 + 1)
	puts "comment", i
end




