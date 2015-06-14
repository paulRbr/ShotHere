require 'spec_helper'

describe Movie do

  before(:each) do
    stub_request(:get, /http:\/\/akas.imdb.com\/title\/tt[0-9]+\/.*/)
    @movie = create :movie, locations: [create(:location)]
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
      @movie.locations.should_not  be_empty
    end

    describe "retrieve Scarface movie from imdb" do
      before(:each) do
        @scarface = create :scarface, directors: [create(:brian)]
      end
      it "should have 'Scarface' as title" do
        @scarface.title.should eq 'Scarface'
      end
      it "should have a director called 'Brian De Palma '" do
        @scarface.directors.should_not be_empty
        @scarface.directors.first.name.should include 'Brian'
      end
    end
  end
end
