# frozen_string_literal: true

# == Schema Information
#
# Table name: clicks
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  url_id     :bigint
#  browser    :string           not null
#  platform   :string           not null
#
require 'rails_helper'

RSpec.describe Click, type: :model do
  describe 'validations' do
    it 'validates url_id is valid' do
      should validate_presence_of(:url_id)
    end

    it 'validates browser is not null' do
      should validate_presence_of(:browser)
    end

    it 'validates platform is not null' do
      should validate_presence_of(:browser)
    end

    it 'belongs_to url' do
      should belong_to(:url)
    end
  end
end
