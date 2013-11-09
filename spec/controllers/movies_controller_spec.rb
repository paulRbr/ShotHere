require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe MoviesController do

  # This should return the minimal set of attributes required to create a valid
  # Movie. As you add validations to Movie, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "imdb_id" => "1130884" } }
  let(:other_valid_attributes) { { "imdb_id" => "1130884" } }
  let(:invalid_attributes) { { "imdb_id" => "bzzzz" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # MoviesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET empty index" do
    it "should only render the index html page" do
      get :empty_index, {}, valid_session
      response.status.should be 200
    end
  end

  describe "GET index" do
    describe "with no parameters"  do
      describe "in json format" do
        it "assigns all movies as @movies" do
          movie = create :movie
          get :index, {format: :json}, valid_session
          assigns(:movies).should eq([movie])
          response.should_not be ""
        end
      end
      describe "in html format" do
        it "should only render the index html page" do
          get :empty_index, {}, valid_session
          response.status.should be 200
        end
      end
    end
    describe "with pagination parameter" do
      before do
        class Movie
          self.per_page = 1
        end
      end
      it "assigns only movies from desired page as @movies" do
        create :movie
        movie = create :scarface
        get :index, {page: 2, format: :json}, valid_session
        assigns(:movies).should eq [movie]
        response.body.should_not be ""
        response.status.should be 200
      end
      it "returns an empty array if page number is too low or too high" do
        create :movie
        get :index, {page: 2, format: :json}, valid_session
        assigns(:movies).should eq []
        response.body.should_not be "[]"
        response.status.should be 200
      end
    end
  end

  describe "GET show" do
    it "assigns the requested movie as @movie" do
      movie = create :movie
      get :show, {:id => movie.to_param, format: :json}, valid_session
      assigns(:movie).should eq(movie)
    end
  end

  describe "GET new" do
    it "assigns a new movie as @movie" do
      get :new, {format: :json}, valid_session
      assigns(:movie).should be_a_new(Movie)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Movie" do
        expect {
          post :create, {:movie => valid_attributes, format: :json}, valid_session
        }.to change(Movie, :count).by(1)
      end

      it "assigns a newly created movie as @movie" do
        post :create, {:movie => valid_attributes, format: :json}, valid_session
        assigns(:movie).should be_a(Movie)
        assigns(:movie).should be_persisted
      end

      it "return the created movie in JSON including the locations, genres and directors" do
        post :create, {:movie => valid_attributes, format: :json}, valid_session
        response.body.should eq Movie.last.to_json(include: [:locations, :directors, :genres])
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved movie as @movie" do
        # Trigger the behavior that occurs when invalid params are submitted
        Movie.any_instance.stub(:save).and_return(false)
        post :create, {:movie => invalid_attributes, format: :json}, valid_session
        assigns(:movie).should be_a_new(Movie)
      end

      it "respond with a 422 unpreprocessable entity error" do
        # Trigger the behavior that occurs when invalid params are submitted
        Movie.any_instance.stub(:save).and_return(false)
        post :create, {:movie => invalid_attributes, format: :json}, valid_session
        response.status.should eq(422)
      end
    end
  end

  describe "PUT update .json format" do
    describe "with valid params" do
      it "updates the requested movie" do
        movie = create :movie
        # Assuming there are no other movies in the database, this
        # specifies that the Movie created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Movie.any_instance.should_receive(:update_attributes).with(valid_attributes)
        put :update, {:id => movie.to_param, :movie => valid_attributes, format: :json}, valid_session
      end

      it "assigns the requested movie as @movie" do
        movie = create(:movie, imdb_id: "113088")
        put :update, {:id => movie.to_param, :movie => valid_attributes, format: :json}, valid_session
        assigns(:movie).should eq(movie)
      end

      it "respond with no content (204 response)" do
        movie = create :movie
        put :update, {:id => movie.to_param, :movie => valid_attributes, format: :json}, valid_session
        response.status.should eq(204)
      end
    end

    describe "with invalid params" do
      it "assigns the movie as @movie" do
        movie = create :movie
        # Trigger the behavior that occurs when invalid params are submitted
        Movie.any_instance.stub(:save).and_return(false)
        put :update, {:id => movie.to_param, :movie => invalid_attributes, format: :json}, valid_session
        assigns(:movie).should eq(movie)
      end

      it "respond with a 422 unpreprocessable entity error" do
        movie = create :movie
        # Trigger the behavior that occurs when invalid params are submitted
        Movie.any_instance.stub(:save).and_return(false)
        put :update, {:id => movie.to_param, :movie => invalid_attributes, format: :json}, valid_session
        response.status.should eq(422)
      end
    end
  end

  describe "DELETE destroy .json format" do
    it "destroys the requested movie" do
      movie = create :movie
      expect {
        delete :destroy, {:id => movie.to_param, format: :json}, valid_session
      }.to change(Movie, :count).by(-1)
    end

    it "respond with no content (204 response)" do
      movie = create :movie
      delete :destroy, {:id => movie.to_param, format: :json}, valid_session
      response.status.should eq(204)
    end
  end
end
