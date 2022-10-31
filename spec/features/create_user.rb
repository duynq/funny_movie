require 'rails_helper'

describe 'creating a user', type: :feature, js: true do

  it 'successfully creates user' do
    visit '/'

    within '#new_user' do
      fill_in 'user_email', with: 'quangduyx188@gmail.com'
      fill_in 'user_password_digest', with: '12345678'
    end
   click_button 'Login / Register'

   expect(page).to have_content 'Login successfully'
  end

  context 'when login user faily' do
    let!(:user) {FactoryBot.create :user, email: 'quangduyx188@gmail.com', password: 'Aa@123456'}
    it 'failly login user with wrong password' do
      visit '/'

      within '#new_user' do
        fill_in 'user_email', with: 'quangduyx188@gmail.com'
        fill_in 'user_password_digest', with: '123'
      end
      click_button 'Login / Register'

      expect(page).to have_content 'Email or Password are wrong'
    end

    it 'failly login user with wrong email format' do
      visit '/'

      within '#new_user' do
        fill_in 'user_email', with: 'quangduyx188@gmail'
        fill_in 'user_password_digest', with: '123'
      end
      click_button 'Login / Register'

      expect(page).to have_content 'Email is invalid'
    end
  end
end
