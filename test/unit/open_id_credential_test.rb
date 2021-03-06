
require 'test_helper'

class OpenIdCredentialTest < ActiveSupport::TestCase
  def setup
    @klass = OpenIdCredential
    @basic = @klass.new(
      :user_id      => users(:yuya).id,
      :identity_url => "http://example.jp/identity_url")

    @yuya_livedoor  = open_id_credentials(:yuya_livedoor)
    @shinya_example = open_id_credentials(:shinya_example)
  end

  #
  # 検証
  #

  test "all fixtures are valid" do
    assert_equal(true, @klass.all.all?(&:valid?))
  end

  test "basic is valid" do
    assert_equal(true, @basic.valid?)
  end

  test "validates_presence_of :user_id" do
    @basic.user_id = nil
    assert_equal(false, @basic.valid?)
  end

  test "validates_presence_of :identity_url" do
    @basic.identity_url = nil
    assert_equal(false, @basic.valid?)
  end

  test "validates_length_of :identity_url" do
    [
      ["http://example.com/" + "a" * 181, 200, true ],
      ["http://example.com/" + "a" * 182, 201, false],
    ].each { |value, size, expected|
      @basic.identity_url = value
      assert_equal(size, value.size, value)
      assert_equal(expected, @basic.valid?, value)
    }
  end

  test "validates_format_of :identity_url" do
    [
     ["http://example.com/foo",  true ],
     ["https://example.com/foo", true ],
     ["ftp://example.com/foo",   false],
    ].each{ |value, expected|
      @basic.identity_url = value
      assert_equal(expected, @basic.valid?, value)
    }
  end

  test "validates_uniqueness_of :identity_url, on create" do
    @basic.identity_url = @yuya_livedoor.identity_url
    assert_equal(false, @basic.valid?)
  end

  test "validates_uniqueness_of :identity_url, on update" do
    @yuya_livedoor.identity_url = @shinya_example.identity_url
    assert_equal(false, @yuya_livedoor.valid?)
  end

  #
  # 関連
  #

  test "belongs_to :user" do
    assert_equal(
      users(:yuya),
      @yuya_livedoor.user)

    assert_equal(
      users(:shinya),
      @shinya_example.user)
  end
end
