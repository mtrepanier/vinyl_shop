class Api::ConcertsController < ApplicationController
  before_action :set_concert, only: [:show, :edit, :update, :destroy]
  before_action :set_venues_and_artists, only: [:new, :edit, :create, :update]

  # GET /api/concerts
  # GET /api/concerts.json
  def index
    @concerts = Concert.all
  end

  # GET /api/concerts/1
  # GET /api/concerts/1.json
  def show
  end

  # GET /api/concerts/new
  def new
    @concert = Concert.new
  end

  # GET /api/concerts/1/edit
  def edit
  end

  # POST /api/concerts
  # POST /api/concerts.json
  def create
    @concert = Concert.new(concert_params)

    respond_to do |format|
      if @concert.save
        format.html { redirect_to [:api,@concert], notice: 'Concert was successfully created.' }
        format.json { render :show, status: :created, location: [:api,@concert] }
      else
        format.html { render :new }
        format.json { render json: @concert.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /api/concerts/1
  # PATCH/PUT /api/concerts/1.json
  def update
    respond_to do |format|
      if @concert.update(concert_params)
        format.html { redirect_to [:api,@concert], notice: 'Concert was successfully updated.' }
        format.json { render :show, status: :ok, location: [:api,@concert] }
      else
        format.html { render :edit }
        format.json { render json: @concert.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /concerts/1
  # DELETE /concerts/1.json
  def destroy
    @concert.destroy
    respond_to do |format|
      format.html { redirect_to api_concerts_url, notice: 'Concert was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_concert
      @concert = Concert.find(params[:id])      
    end

    def set_venues_and_artists
      @artists = Artist.all
      @venues = Venue.all
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def concert_params
      params.require(:concert).permit(:show_date, :venue_id, :price, :artist_ids => [])
    end
end
