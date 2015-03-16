class Api::ArtistsController < ApplicationController
  before_action :set_artist, only: [:show, :edit, :update, :destroy]

  # GET /api/artists
  # GET /api/artists.json
  def index
    @artists = Artist.all
  end

  # GET /api/artists/1
  # GET /api/artists/1.json
  def show
  end

  # GET /api/artists/new
  def new
    @artist = Artist.new
  end

  # GET /api/artists/1/edit
  def edit
  end

  # POST /api/artists
  # POST /api/artists.json
  def create
    @artist = Artist.new(artist_params)

    respond_to do |format|
      if @artist.save
        format.html { redirect_to [:api, @artist], notice: 'Artist was successfully created.' }
        format.json { render :show, status: :created, location: [:api, @artist] }
      else
        format.html { render :new }
        format.json { render json: @artist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /api/artists/1
  # PATCH/PUT /api/artists/1.json
  def update
    respond_to do |format|
      if @artist.update(artist_params)
        format.html { redirect_to [:api, @artist], notice: 'Artist was successfully updated.' }
        format.json { render :show, status: :ok, location: [:api, @artist] }
      else
        format.html { render :edit }
        format.json { render json: @artist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /api/artists/1
  # DELETE /api/artists/1.json
  def destroy
    @artist.destroy
    respond_to do |format|
      format.html { redirect_to api_artists_url, notice: 'Artist was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_artist
      @artist = Artist.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def artist_params
      params.require(:artist).permit(:name, :spotify_artist_id, :artist_thumbnail_url)
    end
end
