# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # Include universal Open Graph support for all models
  include Zeropoint::OpenGraph
end
