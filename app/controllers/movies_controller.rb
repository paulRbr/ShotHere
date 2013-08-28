class MoviesController < ApplicationController
  # GET /movies
  # GET /movies.json
  def index
    @movies = Movie.order(:rating).take(100)

  respond_to do |format|
      format.html # index.html.haml
      format.json { render json: @movies, :include => [:locations, :directors, :genres] }
    end
  end

  # GET /
  def empty_index
    respond_to do |format|
      format.html { render :index } # index.html.haml
    end
  end


  # GET /movies/1.json
  def show
    @movie = Movie.find(params[:id])

    respond_to do |format|
      format.html { render :index }
      format.json { render json: @movie, :include => [:locations, :directors, :genres] }
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
    @movie = Movie.where(params[:movie].select {|k,v| k == "imdb_id"}).first_or_create
    @movie.update_attributes(params[:movie].select {|k,v| k == "imdb_id"})

    respond_to do |format|
      if @movie.save
        format.json { render json: @movie, :include => [:locations, :directors, :genres], status: :created, location: @movie, notice: 'Movie was successfully created.' }
      else
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /movies/1.json
  def update
    @movie = Movie.find(params[:id])

    respond_to do |format|
      if @movie.update_attributes(params[:movie].select {|k,v| k == "imdb_id"})
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
end
