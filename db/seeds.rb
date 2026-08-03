# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Theme.find_or_create_by!(title: 'うちの推しグッズ 離乳食編') do |theme|
  theme.body = '離乳食を作る時、あげる時など、「うちはこれを使ってた！」「この商品のこういうところが良かった！」を教えてください✨'
end

puts "Theme created successfully!"
