# frozen_string_literal: true

module ApiResponseHandler
  extend ActiveSupport::Concern

  private

  def render_success(data, status: :ok)
    render json: { success: true, data: data }, status: status
  end

  def render_error(message, status: :unprocessable_entity, errors: nil)
    response = { success: false, error: message }
    response[:errors] = errors if errors.present?
    render json: response, status: status
  end

  def render_not_found(resource = 'Resource')
    render_error("#{resource} not found", :not_found)
  end

  def render_unauthorized
    render_error(t('demo.messages.unauthorized'), :unauthorized)
  end

  def render_forbidden
    render_error(t('demo.messages.forbidden'), :forbidden)
  end

  def render_validation_errors(record)
    render_error('Validation failed', :unprocessable_entity, record.errors.full_messages)
  end

  def render_paginated_response(collection, serializer: nil)
    data = if serializer
             collection.map { |item| serializer.new(item).as_json }
    else
             collection
    end

    response = {
      data: data,
      pagination: {
        current_page: collection.current_page,
        total_pages: collection.total_pages,
        total_count: collection.total_count,
        per_page: collection.limit_value
      }
    }

    render_success(response)
  end

  def render_search_results(results, query)
    render_success({
                     results: results,
                     query: query,
                     count: results.count
                   })
  end
end
