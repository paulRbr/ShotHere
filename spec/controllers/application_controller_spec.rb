require 'spec_helper'

describe ApplicationController do

  let(:valid_session) { {} }

  describe "GET empty index" do
    it "should only render the index html page" do
      get :empty_index, {}, valid_session
      response.status.should be 200
    end
  end

end
