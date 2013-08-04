class SearchesController < ApplicationController
  def movies
    search do
      list = Movie.select("title, id").limit(Rails.configuration.search_limit).where "title LIKE ?", "%#{params[:q]}%"
      if list.empty?
        begin
          search_imdb_data(params[:q]) 
        rescue => e
          Rails.logger.debug e
          []
        end
      else
        list
      end
    end
  end

  def locations
    search do
      Location.select("address, id").limit(Rails.configuration.search_limit).where "address LIKE ?", "%#{params[:q]}%"
    end
  end

  def imdb_movies
    search do 
      begin
        search_imdb_data(params[:q]) 
      rescue => e
        Rails.logger.debug e
        []
      end
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

  def search_imdb_data(query)
    query.gsub!(/[ ]/, '+')
    Rails.logger.debug query
    uri = URI.parse("http://mymovieapi.com/?title=#{query}&type=json&limit=5")
    response = Net::HTTP.get_response(uri)
    begin
      data = JSON.parse(response.body)
    rescue JSON::ParseError
      data = nil
    end
    if data.nil?
      raise "Unable to use mymovieapi.com"
    elsif !data.kind_of?(Array) and data["error"]
      raise data["error"]
    elsif data.kind_of?(Array) and data.empty?
      raise "No result found"
    end
    data
  end

end
