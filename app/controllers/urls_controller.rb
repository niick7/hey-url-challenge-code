# frozen_string_literal: true

require 'browser'

class UrlsController < ApplicationController
  def index
    # recent 10 short urls
    @url = Url.new
    @urls = Url.latest
  end

  def create
    @url = Url.new(url_params)
    if @url.save
      @url = Url.new
      @urls = Url.latest
    end
    respond_to do |format|
      format.js
    end
  end

  def show
    @url = Url.find_by_short_url(params[:url])
    if @url.present?
      @metrics_clicks = @url.clicks
                            .where('created_at > ? and created_at < ?', Time.now.beginning_of_month, Time.now.end_of_month)
                            .group_by_day(:created_at)
                            .count
      @metrics_browsers = @url.clicks.group(:browser).count
      @metrics_platforms = @url.clicks.group(:platform).count
    else
      render_not_found
    end
  end

  def visit
    # params[:short_url]
    url = Url.find_by_short_url(params[:short_url]) or render_not_found
    if url
      url.clicks.create(platform: browser.platform.name, browser: browser.name)
      redirect_to root_path
    end
  end

  private

  def url_params
    params.require(:url).permit(:original_url, :short_url)
  end
end
