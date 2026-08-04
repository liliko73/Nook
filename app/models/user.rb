class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  # 関連付け（アソシエーション）
  # お子様との1対多の関係を設定
  has_many :children, dependent: :destroy, validate: true
  # コメントとの1対多の関係を設定
  has_many :comments, dependent: :destroy

  # フォームから子供の情報も同時に受け取れるようにする
  accepts_nested_attributes_for :children, allow_destroy: true

  # 性別のenum
  enum :gender, { male: 0, female: 1, other: 2 }

  # バリデーション
  validates :username, presence: true, length: { maximum: 50 }
  validates :birthday_year, presence: true
  validates :birthday_month, presence: true
  validates :birthday_date, presence: true
  validates :gender, presence: true

  # ひとこと
  validates :self_introduction, presence: true, length: { maximum: 200 }

  # 定数定義
  # 都道府県リスト
  PREFECTURES = %w[
    北海道 青森県 岩手県 宮城県 秋田県 山形県 福島県
    茨城県 栃木県 群馬県 埼玉県 千葉県 東京都 神奈川県
    新潟県 富山県 石川県 福井県 山梨県 長野県 岐阜県
    静岡県 愛知県 三重県 滋賀県 京都府 大阪府 兵庫県
    奈良県 和歌山県 鳥取県 島根県 岡山県 広島県 山口県
    徳島県 香川県 愛媛県 高知県 福岡県 佐賀県 長崎県
    熊本県 大分県 宮崎県 鹿児島県 沖縄県
  ].freeze
end

