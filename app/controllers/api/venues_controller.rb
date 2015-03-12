class Api::VenuesController < ApplicationController
  before_action :set_venue, only: [:show, :edit, :update, :destroy]

  # GET /api/venues
  # GET /api/venues.json
  def index
    @venues = Venue.all
  end

  # GET /api/venues/1
  # GET /api/venues/1.json
  def show
  end

  # GET /api/venues/new
  def new
    @venue = Venue.new
  end

  # GET /api/venues/1/edit
  def edit
  end

  # POST /api/venues
  # POST /api/venues.json
  def create
    @venue = Venue.new(venue_params)

    respond_to do |format|
      if @venue.save
        format.html { redirect_to [:api, @venue], notice: 'Venue was successfully created.' }
        format.json { render :show, status: :created, location: @venue }
      else
        format.html { render :new }
        format.json { render json: @venue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /api/venues/1
  # PATCH/PUT /api/venues/1.json
  def update
    respond_to do |format|
      if @venue.update(venue_params)
        format.html { redirect_to [:api, @venue], notice: 'Venue was successfully updated.' }
        format.json { render :show, status: :ok, location: @venue }
      else
        format.html { render :edit }
        format.json { render json: @venue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /api/venues/1
  # DELETE /api/venues/1.json
  def destroy
    @venue.destroy
    respond_to do |format|
      format.html { redirect_to api_venues_url, notice: 'Venue was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_venue
      @venue = Venue.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def venue_params
      params.require(:venue).permit(:name)
    end
end
