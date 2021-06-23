# frozen_string_literal: true

class UrlSerializer
  include FastJsonapi::ObjectSerializer
  set_key_transform :dash
  set_type :urls

  attributes :created_at, :original_url, :click
  attributes :url, &:short_url
  attribute :click do |object|
    object.clicks.count
  end

  has_many :clicks
end
