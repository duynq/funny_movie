require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation' do
    context 'presence' do
      it { should validate_presence_of :email }
      it { should validate_presence_of :password_digest }
    end

    context 'association' do
      it { should have_many(:movies).dependent(:destroy) }
    end

    context 'format email' do
      let(:user) { FactoryBot.build :user, email: 'test@gamil.com' }
      let(:user2) { FactoryBot.build :user, email: 'test' }
      before do
        user.valid?
        user2.valid?
      end

      it 'the email is valid' do
        expect(user.errors.messages.empty?).to eq true
      end

      it 'the email is invalid' do
        expect(user2.errors.messages[:email]).to eq ['is invalid']
      end
    end
  end

  describe 'enscrypted password' do
    let(:user) {FactoryBot.build :user, password: 'Aa@123456'}

    it 'encrypted successfully' do
      expect(user.password_digest).to eq user.password
    end
  end
end
