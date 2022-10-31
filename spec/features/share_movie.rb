require 'rails_helper'

describe 'creating a user', type: :feature, js: true do
  context 'when share video successfully' do
    it 'share successfully' do
      user = FactoryBot.create :user, email: 'test@gmail.com', password: 'Aa@123456'
      login_as(user)

      visit '/movies/new'

      within '#new_movie' do
        fill_in 'movie_youtube_url', with: 'https://www.youtube.com/watch?v=ONpaD0DMp1Y'
      end      

      click_button 'Share'

      expect(page).to have_content 'Share movie successfully'
    end
  end

  context 'when share video faily' do
    it 'share failly' do
      user = FactoryBot.create :user, email: 'test@gmail.com', password: 'Aa@123456'
      login_as(user)

      visit '/movies/new'

      within '#new_movie' do
        fill_in 'movie_youtube_url', with: 'https://www.youtube.com/watch?v=test_id_false'
      end      

      click_button 'Share'

      expect(page).to have_content 'Your movie is invalid'
    end
  end
end
