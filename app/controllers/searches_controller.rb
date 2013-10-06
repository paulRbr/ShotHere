class SearchesController < ApplicationController
  def movies
    search do
      by = params[:by] || "title"
      Movie.select("title, id, poster, year").limit(Rails.configuration.search_limit).where "#{by} LIKE ?", "%#{params[:q]}%"
    end
  end

  def imdb_movies
    search do
      begin
        imdb_list = Imdb::Search.new("#{params[:q]}")
        imdb_list.movies
      end
    end
  end

  def locations
    search do
      by = params[:by] || "address"
      Location.select("address, id").limit(Rails.configuration.search_limit).where "#{by} LIKE ?", "%#{params[:q]}%"
    end
  end

  private

  def search(&block)    
    if params[:q]
      @results = yield if block_given?

      respond_to do |format|
        format.json { render json: @results }
      end
    else
      respond_to do |format|
        format.json { render json: 'No search query was specified.'}
      end
    end
  end
end
