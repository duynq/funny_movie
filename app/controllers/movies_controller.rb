class MoviesController < ApplicationController
  before_action :authenticate!, only: %i[new create]

  DEFAULT_PERPAGE = 3

  def index
    @movies = Movie.order('created_at DESC').page(params[:page]).per(DEFAULT_PERPAGE)
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    movie_service = MovieService.new(@movie.youtube_url)
    movie_service.execute
    if movie_service.success?
      @movie.title = movie_service.title
      @movie.description = movie_service.description
      @movie.youtube_id= movie_service.youtube_id
    end
    @movie.user = current_user
    if @movie.save
      flash[:success] = 'Share movie successfully'
      redirect_to :root
    else
      flash[:danger] = 'Your movie is invalid'
      redirect_to '/new'
    end
  end

  private

  def movie_params
    params.require(:movie).permit(:youtube_url)
  end
end
