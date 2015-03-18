class MoviesController < ApplicationController

  ## =====================================
  ## =====================================
  ##
  ## ShotHere API v1
  ##
  ## =====================================
  ## =====================================

  # GET /movies
  # GET /movies.json
  def index
    scope = Movie.where.not(title: nil, rating: nil).order(rating: :desc)

    respond_to do |format|
      format.html # index.html.haml
      format.json do
        if params[:page]
          @movies = scope.paginate(page: params[:page])
        else
          @movies = scope
        end

        if params[:only] == 'locations'
          @movies = @movies.includes(:locations)
          render json: @movies,
                 include: {
                  locations: {
                    only: [:address, :longitude, :latitude]
                  }
                 },
                 except: [:created_at, :updated_at]
        else
          render json: @movies,
                 include: [:locations, :directors, :genres],
                 except: [:created_at, :updated_at]
        end
      end
    end
  end

  # GET /movies/1.json
  def show
    @movie = Movie.find(params[:id])

    respond_to do |format|
      format.html { render :index }
      format.json { render json: @movie, include: [:locations, :directors, :genres] }
    end
  end

  # GET /movies/new.json
  def new
    @movie = Movie.new

    respond_to do |format|
      format.json { render json: @movie }
    end
  end

  # POST /movies.json
  def create
    @movie = Movie.where(params[:movie].select {|k| k == 'imdb_id'}).first_or_create(params[:movie].select {|k,_| k == 'imdb_id'})

    respond_to do |format|
      if @movie.save
        format.json { render json: @movie, include: [:locations, :directors, :genres], status: :created, notice: 'Movie was successfully created.' }
      else
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /movies/1.json
  def update
    @movie = Movie.find(params[:id])

    respond_to do |format|
      if @movie.update_attributes movie_params
        format.json { head :no_content, notice: 'Movie was successfully updated.' }
      else
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1.json
  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy

    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private

  def movie_params
    params.require(:movie).permit(:imdb_id)
  end
end
