class SearchesController < ApplicationController
  def movies
    search do
      Movie.select("title, id").limit(Rails.configuration.search_limit).where "title LIKE ?", "%#{params[:q]}%"
    end
  end

  def locations
    search do
      Location.select("address, id").limit(Rails.configuration.search_limit).where "address LIKE ?", "%#{params[:q]}%"
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
