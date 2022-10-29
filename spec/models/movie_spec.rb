require 'rails_helper'

RSpec.describe Movie, type: :model do
  describe 'validation' do
    context 'presence' do
      it { should validate_presence_of :youtube_id }
      it { should validate_presence_of :youtube_url }
      it { should validate_presence_of :title }
      it { should validate_presence_of :description }
    end

    context 'association' do
      it { should belong_to(:user) }
    end

    context 'format youtube link format' do
      let(:movie) { FactoryBot.build :movie, youtube_url: 'https://www.youtube.com/watch?v=1PgE4XjmHEY' }
      let(:movie2) { FactoryBot.build :movie, youtube_url: 'test fail youtube link format' }
      before do
        movie.valid?
        movie2.valid?
      end

      it 'the youtube link is valid' do
        expect(movie.errors.messages[:youtube_url].empty?).to eq true
      end

      it 'the youtube link is invalid' do
        expect(movie2.errors.messages[:youtube_url]).to eq ['is invalid']
      end
    end

    context 'when youtube id unique' do
      let(:user) { FactoryBot.create :user }
      let(:movie) { FactoryBot.create :movie, youtube_url: 'https://www.youtube.com/watch?v=1PgE4XjmHEY', user: user, youtube_id: '1PgE4XjmHEY' }
      let(:movie2) { FactoryBot.build :movie, youtube_url: 'https://www.youtube.com/watch?v=1PgE4XjmHEY', youtube_id: movie.youtube_id }

      before do
        movie2.valid?
      end

      it 'the youtube id is already token' do
        expect(movie2.errors.messages[:youtube_id].first).to eq 'has already been taken'
      end
    end
  end
end
