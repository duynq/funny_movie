require 'rails_helper'

RSpec.describe 'Movies', type: :request do
  describe 'POST /create' do
    context 'when create successfully' do
      it 'return successful message' do
        user = FactoryBot.create :user, email: 'test@gmail.com', password: 'Aa@123456'
        login_as(user)

        post '/movies', params: { movie: {youtube_url: 'https://www.youtube.com/watch?v=ONpaD0DMp1Y'}}
        expect(response).to redirect_to(:root)
        follow_redirect!
        expect(response).to render_template(:index)
        expect(response.body).to include('Share movie successfully')
      end

      it 'return faily message' do
        user = FactoryBot.create :user, email: 'test@gmail.com', password: 'Aa@123456'
        login_as(user)

        post '/movies', params: { movie: {youtube_url: 'https://www.youtube.com/watch?v=test_youtube_id_invalid'}}
        expect(response).to render_template(:new)
        expect(response.body).to include('Your movie is invalid')
      end
    end
  end
end
