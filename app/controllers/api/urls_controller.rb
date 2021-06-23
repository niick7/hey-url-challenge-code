# frozen_string_literal: true

module Api
  class UrlsController < Api::BaseController
    def index
      options = {}
      options[:include] = %i[clicks 'clicks.browser' 'clicks.platform']
      render json: UrlSerializer.new(Url.latest, options).serialized_json
    end
  end
end
