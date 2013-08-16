require 'spec_helper'

describe Movie do

  before(:each) do
    @movie = create :movie
  end

  describe "to_json" do
    it "doesn't contain locations" do
      JSON.parse(@movie.to_json).should_not include('locations')
    end
  end
end
