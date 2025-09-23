# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

user1 = User.find_or_create_by!(email: "user1@example.com") do |u|
  u.password = "password"
end

num_points = 500
locations = []

# 代々木公園の中心付近（北緯・東経）
center_lat = 35.6717
center_lng = 139.6949

# 初期位置は中心付近
lat = center_lat
lng = center_lng

start_time = Time.current

num_points.times do |i|
  # ランダムに少しだけ移動
  lat += rand(-0.0001..0.0002)
  lng += rand(-0.0001..0.0003)

  recorded_at = start_time + i * 0.1 # 0.1秒ごとに記録

  locations << { lat: lat, lng: lng, recorded_at: recorded_at }
end

# DBへ保存
locations.each do |location|
  Location.find_or_create_by!(
    user: user1,
    recorded_at: location[:recorded_at]
  ) do |l|
    l.lat = location[:lat]
    l.lng = location[:lng]
  end
end

puts "Sample locations for user1 (bike loop) created!"
