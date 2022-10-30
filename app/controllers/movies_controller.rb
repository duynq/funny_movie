class MoviesController < ApplicationController
  before_action :authenticate!, only: %i[new create]

  DEFAULT_PERPAGE = 3

  def index
    @movies = Movie.order('created_at DESC')
  end

  def new
    @movie = Movie.new
  end

  def create
    movie_service = MovieService.new(movie_params[:youtube_url])
    @movie = Movie.new(movie_service.infor)
    @movie.youtube_url = movie_params[:youtube_url]
    @movie.user = current_user
    if @movie.save
      flash[:success] = 'Share movie successfully'
      redirect_to :root
    else
      flash[:danger] = 'Your movie is invalid'
      redirect_to '/share'
    end
  end

  private

  def movie_params
    params.require(:movie).permit(:youtube_url)
  end
end
