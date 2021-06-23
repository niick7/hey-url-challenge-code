# frozen_string_literal: true

require 'rails_helper'
require 'webdrivers'

# WebDrivers Gem
# https://github.com/titusfortner/webdrivers
#
# Official Guides about System Testing
# https://api.rubyonrails.org/v5.2/classes/ActionDispatch/SystemTestCase.html

RSpec.describe 'Short Urls', type: :system do
  before do
    driven_by :selenium, using: :chrome
    # If using Firefox
    # driven_by :selenium, using: :firefox
    #
    # If running on a virtual machine or similar that does not have a UI, use
    # a headless driver
    # driven_by :selenium, using: :headless_chrome
    # driven_by :selenium, using: :headless_firefox
    @url = create(:url)
  end

  describe 'index' do
    it 'shows a list of short urls' do
      create(:url, short_url: 'ABCDF')
      create(:url, short_url: 'ABCDG')
      create(:url, short_url: 'ABCDH')
      create(:url, short_url: 'ABCDI')
      create(:url, short_url: 'ABCDJ')

      create(:url, short_url: 'ABCDK')
      create(:url, short_url: 'ABCDL')
      create(:url, short_url: 'ABCDM')
      create(:url, short_url: 'ABCDN')
      create(:url, short_url: 'ABCDO')

      create(:url, short_url: 'ABCDP')
      create(:url, short_url: 'ABCDQ')
      create(:url, short_url: 'ABCDS')
      create(:url, short_url: 'ABCDT')
      create(:url, short_url: 'ABCDU')

      visit root_path
      expect(page).to have_text('HeyURL!')
      expect(page).to have_selector('tr', count: 11) # 1 tr header and 10 tr body data
    end
  end

  describe 'show' do
    it 'shows a panel of stats for a given short url' do
      visit url_path('ABCDE')
      expect(page).to have_text(@url.short_url)
    end

    context 'when not found' do
      it 'shows a 404 page' do
        visit url_path('NOTFOUND')
        expect(page).to have_text("The page you were looking for doesn't exist.")
      end
    end
  end

  describe 'create' do
    context 'when url is valid' do
      it 'creates the short url' do
        visit '/'
        fill_in 'url[original_url]', with: 'https://www.google.com/'
        fill_in 'url[short_url]', with: 'DNHAN'
        click_on 'Create Shorten URL'
        expect(page).to have_text('DNHAN')
      end

      it 'redirects to the home page' do
        # Because I used ajax for submitting the form
        # Then we don't have to redirect anymore
        # visit '/'
        # add more expections
      end
    end

    context 'when url is invalid' do
      it 'does not create the short url and shows a message' do
        visit '/'
        fill_in 'url[original_url]', with: 'www.google.com/'
        fill_in 'url[short_url]', with: 'GOOGL'
        click_on 'Create Shorten URL'
        expect(page).to have_text('Original URL is invalid')
      end

      it 'redirects to the home page' do
        visit '/'
        click_on 'HeyURL!'
        expect(page).to have_text('HeyURL!')
      end
    end
  end

  describe 'visit' do
    it 'redirects the user to the root path' do
      visit visit_path('ABCDE')
      expect(page).to have_text('HeyURL!')
    end

    context 'when not found' do
      it 'shows a 404 page' do
        visit visit_path('NOTFOUND')
        expect(page).to have_text("The page you were looking for doesn't exist.")
      end
    end
  end
end
