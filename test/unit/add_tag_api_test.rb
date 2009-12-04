
require 'test_helper'

class AddTagApiTest < ActiveSupport::TestCase
  def setup
    @klass = AddTagApi
  end

  #
  # カラム
  #

  test "columns" do
    [
      [:article_id, nil, "1", 1],
      [:tag,        nil, "1", "1"],
    ].each { |name, default, set_value, get_value|
      form = @klass.new
      assert_equal(default, form.__send__(name))
      form.__send__("#{name}=", set_value)
      assert_equal(get_value, form.__send__(name))
    }
  end
end
