require 'spec_helper'

describe "layouts/application" do

  it "renders a map container" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should have_selector('#map')
  end
end
