require 'test_helper'

class  Api::ArtistsControllerTest < ActionController::TestCase
  setup do
    @artist = artists(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:artists)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create artist" do
    assert_difference('Artist.count') do
      post :create, artist: { artist_thumbnail_url: @artist.artist_thumbnail_url, name: @artist.name, spotify_artist_id: @artist.spotify_artist_id }
    end

    assert_redirected_to api_artist_path(assigns(:artist))
  end

  test "should show artist" do
    get :show, id: @artist
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @artist
    assert_response :success
  end

  test "should update artist" do
    patch :update, id: @artist, artist: { artist_thumbnail_url: @artist.artist_thumbnail_url, name: @artist.name, spotify_artist_id: @artist.spotify_artist_id }
    assert_redirected_to api_artist_path(assigns(:artist))
  end

  test "should destroy artist" do
    assert_difference('Artist.count', -1) do
      delete :destroy, id: @artist
    end

    assert_redirected_to api_artists_path
  end
end
