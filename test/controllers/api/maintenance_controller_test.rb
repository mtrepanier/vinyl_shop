require 'test_helper'

class Api::MaintenanceControllerTest < ActionController::TestCase
  test "should get refresh_from_cheapthrills" do
    get :refresh_from_cheapthrills
    assert_response :success
  end

end
