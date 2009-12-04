
require 'test_helper'

class AddTagApiTest < ActiveSupport::TestCase
  def setup
    @klass = AddTagApi
    @basic = @klass.new(
      :article_id => 1,
      :tag        => "tag")
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

  #
  # 検証
  #

  test "basic is valid" do
    assert_equal(true, @basic.valid?)
  end

  test "validates_presence_of :article_id" do
    @basic.article_id = ""
    assert_equal(false, @basic.valid?)
  end

  test "validates_presence_of :tag" do
    @basic.tag = ""
    assert_equal(false, @basic.valid?)
  end
end
