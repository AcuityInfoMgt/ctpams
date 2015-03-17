# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
if User.count == 0
  user = CreateAdminService.new.call
  puts 'CREATED ADMIN USER: ' << user.email
end

if Program.count == 0
  Program.create(name: 'CT')
  Program.create(name: 'CTE')
  Program.create(name: 'TSI')
end

if Region.count == 0
  Region.create(name: 'Africa')
  Region.create(name: 'East Asia Pacific')
  Region.create(name: 'Europe')
  Region.create(name: 'Near East')
  Region.create(name: 'South and Central Asia')
  Region.create(name: 'Western Hemisphere')
end
