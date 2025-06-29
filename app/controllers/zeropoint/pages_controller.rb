# frozen_string_literal: true

module Zeropoint
  class PagesController < Zeropoint::BaseController
    # Serve index.html at root
    def index
      render template: 'zeropoint/pages/index', layout: false
    end
  end
end
