
require 'test_helper'

class CombinedTaggingTest < ActiveSupport::TestCase
  def setup
    @klass = CombinedTagging
    @basic = @klass.new(
      :serial     => 1,
      :article_id => articles(:mainichi1).id)
  end

  #
  # 関連
  #

  test "belongs_to :article" do
    assert_equal(
      articles(:asahi1),
      combined_taggings(:asahi1).article)

    assert_equal(
      articles(:asahi3),
      combined_taggings(:asahi3).article)
  end

  test "belongs_to :division_tag" do
    assert_equal(
      tags(:rail),
      combined_taggings(:asahi1).division_tag)

    assert_equal(
      nil,
      combined_taggings(:asahi2).division_tag)
  end

  test "belongs_to :category_tag1" do
    assert_equal(
      tags(:social),
      combined_taggings(:asahi1).category_tag1)

    assert_equal(
      nil,
      combined_taggings(:asahi3).category_tag1)
  end

  test "belongs_to :category_tag2" do
    assert_equal(
      tags(:economy),
      combined_taggings(:asahi1).category_tag2)

    assert_equal(
      nil,
      combined_taggings(:asahi3).category_tag2)
  end

  test "belongs_to :area_tag1" do
    assert_equal(
      tags(:kanto),
      combined_taggings(:asahi1).area_tag1)

    assert_equal(
      nil,
      combined_taggings(:asahi3).area_tag1)
  end

  test "belongs_to :area_tag2" do
    assert_equal(
      tags(:kinki),
      combined_taggings(:asahi1).area_tag2)

    assert_equal(
      nil,
      combined_taggings(:asahi3).area_tag2)
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

  test "validates_presence_of :serial" do
    @basic.serial = nil
    assert_equal(false, @basic.valid?)
  end

  test "validates_presence_of :article_id" do
    @basic.article_id = nil
    assert_equal(false, @basic.valid?)
  end

  test "validates_uniqueness_of :article_id, on create" do
    @basic.article_id = articles(:asahi1).id
    assert_equal(false, @basic.valid?)
  end

  test "validates_uniqueness_of :article_id, on update" do
    record = combined_taggings(:asahi1)
    record.article_id = articles(:asahi2).id
    assert_equal(false, record.valid?)
  end
end
