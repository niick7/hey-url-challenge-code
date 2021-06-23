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
require 'rails_helper'

RSpec.describe Url, type: :model do
  before do
    @url = create(:url)
  end

  describe 'validations' do
    it 'validates original URL is a valid URL' do
      @url.original_url = 'http://google.com'
      @url.save
      expect(@url.errors.size).to eq(0)
    end

    context 'validates short URL' do
      it 'is present' do
        should validate_presence_of(:short_url)
      end

      it 'with lengths' do
        @url.short_url = 'ABC'
        @url.save
        expect(@url.errors.full_messages).to include('Short URL is the wrong length (should be 5 characters)')
      end

      it 'invalid with special character' do
        @url.short_url = 'ABCD#'
        @url.save
        expect(@url.errors.full_messages).to include('Short URL is invalid')
      end

      it 'invalid with special number' do
        @url.short_url = 'ABCD1'
        @url.save
        expect(@url.errors.full_messages).to include('Short URL is invalid')
      end

      it 'invalid with special lowercase' do
        @url.short_url = 'ABCDe'
        @url.save
        expect(@url.errors.full_messages).to include('Short URL is invalid')
      end

      it 'duplicated' do
        url = @url.dup
        url.save
        expect(url.errors.full_messages).to include('Short URL has already been taken')
      end

      it 'valid' do
        @url.short_url = 'ABCDF'
        @url.save
        expect(@url.errors.size).to eq(0)
      end
    end
  end
end
