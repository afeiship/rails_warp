# db/seeds.rb - 用于填充测试应用 dummy 的初始数据

puts "开始创建种子数据..."

# 创建 100 个用户
(1..100).each do |i|
  name = "User #{i}"
  user = User.find_or_create_by!(name: name) do |u|
    u.name = name
  end
  # 每创建 10 个用户输出一次进度
  if i % 10 == 0
    puts "已创建 #{i} 个用户..."
  end
end

puts "种子数据创建完成！共创建了 #{User.count} 个用户。"