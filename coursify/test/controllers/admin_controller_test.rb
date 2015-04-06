require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  test "should get content" do
    get :content
    assert_response :success
  end

  test "should get settings" do
    get :settings
    assert_response :success
  end

end
