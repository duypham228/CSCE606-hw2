class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    # check if there are saved state in session
    # if session[:ratings]
    #   @sesstion_ratings = session[:ratings]
    # end
    
    
    # if session[:sort_by]
    #   @session_sort_by = session[:sort_by]
    # else
    #   @session_sort_by 
    @all_ratings = Movie.all_ratings
    
    # part 2: sorting
    # we need variable sort_by
    if params[:sort_by] # on same page
      @sort_by = params[:sort_by]
    else # from different page
      # check whether there are state in session or not
      if session[:sort_by]
        @sort_by = session[:sort_by]
      # nothing in session
      # else
      #   @sort_by = ""
      end
    end
    
    if params[:ratings] # on same page
      @ratings_to_show_keys = params[:ratings].keys
      @ratings_to_show = params[:ratings]
    else # from different page
      # check whether there are state in session or not
      if session[:ratings]
        @ratings_to_show_keys = session[:ratings].keys
        @ratings_to_show = session[:ratings]
      # nothing in session
      # else
      #   @ratings_to_show_keys = []
      #   @ratings_to_show = []
      end
    end
    
    #update session
    session[:ratings] = params[:ratings]
    session[:sort_by] = params[:sort_by]
    @movies = Movie.with_ratings(@ratings_to_show_keys, @sort_by)
    
   
    
    
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
end
