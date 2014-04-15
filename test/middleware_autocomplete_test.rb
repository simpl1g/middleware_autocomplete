require 'test_helper'

class MiddlewareAutocompleteTest < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, MiddlewareAutocomplete
  end

  test "loads routes" do
    assert_equal MiddlewareAutocomplete::ROUTES, {'/autocomplete/posts' => PostsAutocomplete}
  end
end
