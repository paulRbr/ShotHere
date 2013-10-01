class SearchesController < ApplicationController
  def movies
    search do
      by = params[:by] || "title"
      list = Movie.select("title, id, poster").limit(Rails.configuration.search_limit).where "#{by} LIKE ?", "%#{params[:q]}%"
      if params[:imdb]
        begin
          list = list.concat search_imdb_data(params[:q], by)
        rescue => e
          Rails.logger.debug e
        end
      end
      list.uniq {|movie| movie["title"]}
    end
  end

  def locations
    search do
      by = params[:by] || "address"
      Location.select("address, id").limit(Rails.configuration.search_limit).where "#{by} LIKE ?", "%#{params[:q]}%"
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

  def search_imdb_data(query, by)
    query.gsub!(/[ ]/, '+')
    by.gsub!(/imdb_/,'')
    Rails.logger.debug query
    uri = URI.parse("http://mymovieapi.com/?#{by}=#{query}&type=json&limit=#{Rails.configuration.search_limit}")
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
