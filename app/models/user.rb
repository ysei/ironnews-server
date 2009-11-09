# == Schema Information
# Schema version: 20091030050149
#
# Table name: users
#
#  id         :integer       not null, primary key
#  created_at :datetime      not null
#  updated_at :datetime      not null
#  name       :string(40)    not null, index_users_on_name(unique)
#

# ユーザ
class User < ActiveRecord::Base
  NameMaxLength = 40 # chars
  NamePattern   = /\A[A-Za-z0-9_]+\z/

  # TODO: テストデータを追加
  # TODO: [関連] Taggingモデルとの関連を追加
  # TODO: [関連] OpenIdCredentialモデルとの関連を追加

  validates_presence_of :name
  validates_length_of :name, :maximum => NameMaxLength, :allow_blank => true
  validates_format_of :name, :with => NamePattern, :allow_blank => true
end
