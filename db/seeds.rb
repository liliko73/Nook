# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# 1. テスト用ユーザーの作成（メール認証対応＆詳細プロフィール設定）
user = User.find_or_create_by!(email: 'test1@example.com') do |u|
  u.password = 'password'
  u.password_confirmation = 'password'
  
  # ユーザー情報
  u.username = '名無しの１'
  u.self_introduction = 'よろしくお願いします😊'
  u.birthday_year = 1995
  u.birthday_month = 1
  u.birthday_date = 1
  u.gender = 1 # ※ enum や DB の定義値（0, 1 や female 等）に合わせて変更してください
  u.prefecture = '大阪府' # ※ DB の定義値に合わせて変更してください

  # Devise Confirmable のメール認証スキップ
  u.skip_confirmation! if u.respond_to?(:skip_confirmation!)

  # 子供の情報（1つ目のネストされた属性）
  if u.respond_to?(:children)
    u.children.build(
      birthday_year: 2025,
      birthday_month: 2,
      birthday_date: 2,
      gender: 1 # ※ enum や DB の定義値に合わせて変更してください
    )
  end
end

# 2. Loungeのトークテーマとコメントの作成
theme = Theme.find_or_create_by!(title: 'うちの推しグッズ 離乳食編') do |t|
  t.body = '離乳食を作る時、あげる時など、「うちはこれを使ってた！」「この商品のこういうところが良かった！」を教えてください✨'
end

# テーマに対するコメントの作成
if defined?(Comment) && Comment.column_names.include?('theme_id')
  Comment.find_or_create_by!(theme: theme, user: user, body: 'リッチェルの小分け冷凍容器🥕')
elsif theme.respond_to?(:comments)
  theme.comments.find_or_create_by!(user: user, body: 'リッチェルの小分け冷凍容器🥕')
end

# 3. Askの質問投稿の作成
if defined?(Question)
  Question.find_or_create_by!(title: '平日の朝ごはん何食べさせてますか？') do |q|
    q.user = user
    q.body = '1歳半の我が子はまだ自分でご飯を食べてくれないので、つきっきりでご飯をあげているのですが、自分の準備もあるので、できればそろそろ自分でご飯を食べて欲しいなと思っています😅 みなさんは朝ごはん何を食べさせてますか？'
  end
end

puts "Seed data with user profile and child loaded successfully!"