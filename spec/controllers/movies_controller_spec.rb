require 'spec_helper'

describe MoviesController do

  before do
    stub_request(:get, /http:\/\/akas.imdb.com\/title\/tt[0-9]+\/.*/)
  end

  # This should return the minimal set of attributes required to create a valid
  # Movie. As you add validations to Movie, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "imdb_id" => "1130884" } }
  let(:other_valid_attributes) { { "imdb_id" => "1130884" } }
  let(:invalid_attributes) { { "title" => "bzzzz" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # MoviesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    describe "with no parameters"  do
      describe "in json format" do
        it "assigns all movies as @movies" do
          movie = create :movie
          get :index, {format: :json}, valid_session
          expect(assigns(:movies)).to eq([movie])
          expect(response).to_not be ""
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
        expect(assigns(:movies)).to eq([movie])
        expect(response.body).to_not be ""
        expect(response.status).to be 200
      end
      it "returns an empty array if page number is too low or too high" do
        create :movie
        get :index, {page: 2, format: :json}, valid_session
        expect(assigns(:movies)).to eq []
        expect(response.body).to_not be "[]"
        expect(response.status).to be 200
      end
    end
  end

  describe "GET show" do
    it "assigns the requested movie as @movie" do
      movie = create :movie
      get :show, {:id => movie.to_param, format: :json}, valid_session
      expect(assigns(:movie)).to eq(movie)
    end
  end

  describe "GET new" do
    it "assigns a new movie as @movie" do
      get :new, {format: :json}, valid_session
      expect(assigns(:movie)).to be_a_new(Movie)
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
        expect(assigns(:movie)).to be_a(Movie)
        expect(assigns(:movie)).to be_persisted
      end

      it "return the created movie in JSON including the locations, genres and directors" do
        post :create, {:movie => valid_attributes, format: :json}, valid_session
        expected = JSON.load(Movie.find_by_imdb_id(valid_attributes['imdb_id']).to_json(include: [:locations, :directors, :genres]))
        JSON.load(response.body).each { |k,attr|
          if attr.is_a? Array
            # Unordered Array cf: https://github.com/dchelimsky/rspec/blob/master/lib/spec/matchers/match_array.rb
            expect(attr).to  match(expected[k])
          else
            expect(attr).to eql(expected[k])
          end
        }
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved movie as @movie" do
        # Trigger the behavior that occurs when invalid params are submitted
        post :create, {:movie => invalid_attributes, format: :json}, valid_session
        expect(assigns(:movie)).to be_a_new(Movie)
      end

      it "respond with a 422 unpreprocessable entity error" do
        # Trigger the behavior that occurs when invalid params are submitted
        post :create, {:movie => invalid_attributes, format: :json}, valid_session
        expect(response.status).to eq(422)
      end
    end
  end

  describe "PUT update .json format" do
    describe "with valid params" do
      let(:movie) { create :scarface }

      it "updates the requested movie" do
       put :update, {:id => movie.id, :movie => valid_attributes, format: :json}, valid_session

        expect(WebMock).to have_requested(:get, "http://akas.imdb.com/title/tt1130884/combined")
      end

      it "assigns the requested movie as @movie" do
        put :update, {:id => movie.id, :movie => valid_attributes, format: :json}, valid_session
        expect(assigns(:movie)).to eq(movie)
      end

      it "respond with no content (204 response)" do
        put :update, {:id => movie.id, :movie => valid_attributes, format: :json}, valid_session
        expect(response.status).to eq(204)
      end
    end

    describe "with invalid params" do
      let(:movie) { create :movie }

      it "assigns the movie as @movie" do
        put :update, {:id => movie.id, :movie => invalid_attributes, format: :json}, valid_session

        expect(assigns(:movie)).to eq(movie)
      end

      it "respond with a 422 unpreprocessable entity error" do
        put :update, {:id => movie.id, :movie => invalid_attributes, format: :json}, valid_session

        expect(response.status).to eq(422)
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
      expect(response.status).to eq(204)
    end
  end
end
