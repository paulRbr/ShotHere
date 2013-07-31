require 'spec_helper'

describe "movies/index" do
  before(:each) do
    assign(:movies, [
      stub_model(Movie,
        :title => "Title",
        :imdb_id => 1
      ),
      stub_model(Movie,
        :title => "Title",
        :imdb_id => 1
      )
    ])
  end

  it "renders a movies and a map container" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "#movies", :count => 1
    assert_select "#map", :count => 1
  end
end
