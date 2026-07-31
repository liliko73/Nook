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

      it 'ユーザー名がない場合は無効であること' do
        user.username = ''
        expect(user).not_to be_valid
        expect(user.errors[:username]).to include("can't be blank")
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
