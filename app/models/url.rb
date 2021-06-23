# frozen_string_literal: true

# == Schema Information
#
# Table name: urls
#
#  id           :bigint           not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  short_url    :string           not null
#  original_url :string           not null
#  clicks_count :integer          default(0)
#
class Url < ApplicationRecord
  scope :latest, -> { order(created_at: :desc).limit(10) }

  # Associations
  has_many :clicks, dependent: :destroy

  # Validations
  validates :original_url, presence: true, format: { with: /\A#{URI.regexp.to_s}\z/ }
  # With this regular expression /\A[A-Z]/ which mean no special and white space character
  validates :short_url, presence: true, length: { is: 5 }, format: { with: /\A[A-Z]+\z/ }, uniqueness: true
end
