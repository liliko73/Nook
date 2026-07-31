require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーションのテスト' do
    subject { user.valid? }

    let(:user) { build(:user) }

    context '正常系' do
      it 'すべての必要な値が存在すれば有効であること' do
        expect(user).to be_valid
      end
    end

    context '異常系' do
      it 'メールアドレスがない場合は無効であること' do
        user.email = ''
        expect(user).not_to be_valid
        expect(user.errors[:email]).to include("can't be blank")
      end

      it '重複したメールアドレスの場合は無効であること' do
        create(:user, email: 'test@example.com')
        user.email = 'test@example.com'
        expect(user).not_to be_valid
        expect(user.errors[:email]).to include("has already been taken")
      end

      it 'パスワードがない場合は無効であること' do
        user.password = ''
        expect(user).not_to be_valid
        expect(user.errors[:password]).to include("can't be blank")
      end

      it 'ユーザー名がない場合は無効であること' do
        user.username = ''
        expect(user).not_to be_valid
        expect(user.errors[:username]).to include("can't be blank")
      end

      it '生年月日（年）がない場合は無効であること' do
        user.birthday_year = nil
        expect(user).not_to be_valid
        expect(user.errors[:birthday_year]).to include("can't be blank")
      end

      it '生年月日（月）がない場合は無効であること' do
        user.birthday_month = nil
        expect(user).not_to be_valid
        expect(user.errors[:birthday_month]).to include("can't be blank")
      end

      it '生年月日（日）がない場合は無効であること' do
        user.birthday_date = nil
        expect(user).not_to be_valid
        expect(user.errors[:birthday_date]).to include("can't be blank")
      end

      it '性別がない場合は無効であること' do
        user.gender = nil
        expect(user).not_to be_valid
        expect(user.errors[:gender]).to include("can't be blank")
      end

      it '自己紹介（ひとこと）がない場合は無効であること' do
        user.self_introduction = ''
        expect(user).not_to be_valid
        expect(user.errors[:self_introduction]).to include("can't be blank")
      end
    end

    context '異常系（文字数制限）' do
      it 'ユーザー名が51文字以上の場合は無効であること' do
        user.username = 'a' * 51
        expect(user).not_to be_valid
        expect(user.errors[:username]).to include('is too long (maximum is 50 characters)')
      end

      it '自己紹介が201文字以上の場合は無効であること' do
        user.self_introduction = 'a' * 201
        expect(user).not_to be_valid
        expect(user.errors[:self_introduction]).to include('is too long (maximum is 200 characters)')
      end
    end
  end

  describe '関連付けのテスト' do
    context 'アソシエーション' do
      it 'Childモデルと1対多（has_many）のリレーションを持っていること' do
        association = described_class.reflect_on_association(:children)
        expect(association.macro).to eq :has_many
      end
    end
  end
end
