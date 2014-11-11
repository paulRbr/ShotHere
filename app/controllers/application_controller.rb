class ApplicationController < ActionController::Base
  protect_from_forgery

  # GET /
  def empty_index
    respond_to do |format|
      format.html { render :index } # index.html.haml
    end
  end
end
