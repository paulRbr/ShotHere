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

  describe "pre populate by imdb data" do
    it "should have a title attribute" do
      @movie.title.should_not be nil
    end
    it "should have filming locations" do
      @movie.locations.should_not be nil
      @movie.locations.should be_an Array
    end

    describe "retrieve Scarface movie from imdb" do
      before(:each) do
        @scarface = create :scarface
      end
      it "should have 'Scarface' as title" do
        @scarface.title.should eq 'Scarface'
      end
      it "should have a director called 'Brian De Palma '" do
        @scarface.directors.should be_an Array
        STDOUT.puts @scarface.directors.first.to_json
        @scarface.directors.first.name.should include 'Brian De Palma'
      end
    end
  end
end
