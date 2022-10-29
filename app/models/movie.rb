class Movie < ApplicationRecord
  belongs_to :user

  validates :youtube_url, youtube_link_format: true, presence: true
  validates :youtube_id, :title, :description, presence: true
  validates :youtube_id, uniqueness: {case_sensitive: true}
end
