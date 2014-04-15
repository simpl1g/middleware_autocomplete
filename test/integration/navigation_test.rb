require 'test_helper'

class NavigationTest < ActionDispatch::IntegrationTest
  def json_response
    ActiveSupport::JSON.decode @response.body
  end

  test "returns json from autocomplete route" do
    get autocomplete_posts_path

    assert_response :success
    assert_equal ['Another One Title', 'Second Title', 'Title'], json_response
  end

  test "passes request params" do
    get autocomplete_posts_path, q: 'Another'

    assert_response :success
    assert_equal ['Another One Title'], json_response
  end
end

