require 'rails_helper'

RSpec.describe 'Sessions', type: :request do

  describe 'POST /create' do
    context 'when login successfully' do
      it 'return successful message' do
        post '/users/sessions', params: { user: {email: 'test@gmail.com', password_digest: 'Aa@123456' }}
        expect(response).to redirect_to(:root)
        follow_redirect!
        expect(response).to render_template(:index)
        expect(response.body).to include('Login successfully')
      end
    end

    context 'when login failly' do
      let!(:user) {FactoryBot.create :user, email: 'quangduyx188@gmail.com', password: 'Aa@123456'}

      it 'the email is blank' do
        post '/users/sessions', params: { user: {email: '', password_digest: 'Aa@123456' }}
        expect(response).to redirect_to(:root)
        follow_redirect!
        expect(response.body).to include('Email can&#39;t be blank')
      end

      it 'the email is invalid' do
        post '/users/sessions', params: { user: {email: 'test', password_digest: 'Aa@123456' }}
        expect(response).to redirect_to(:root)
        follow_redirect!
        expect(response.body).to include('Email is invalid')
      end

      it 'the password is wrong' do
        post '/users/sessions', params: { user: {email: 'quangduyx188@gmail.com', password_digest: '12345678' }}
        expect(response).to redirect_to(:root)
        follow_redirect!
        expect(response.body).to include('Email or Password are wrong')
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'logout successfully' do
      delete '/users/sessions'
      expect(response).to redirect_to(:root)
      follow_redirect!
      expect(response.body).to include('Logout successfully')
    end
  end
end
