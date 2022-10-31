class MovieService
  attr_accessor :youtube_url, :youtube_id, :title, :description, :message

  def initialize(youtube_url)
    @youtube_url = youtube_url
  end

  def execute
    movie_youtube = VideoInfo.new(youtube_url)
    self.youtube_id = movie_youtube.video_id
    movie_youtube_data = movie_youtube.data['items'].first['snippet']
    self.title = movie_youtube_data['title']
    self.description = movie_youtube_data['description']
  rescue Exception => e
    self.message = e.message
  end

  def success?
    message.nil?
  end
end
