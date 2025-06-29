# frozen_string_literal: true

module FormHelper
  def form_card(title, &block)
    content_tag :div, class: 'bg-white rounded-lg shadow-md p-6' do
      safe_join([
        content_tag(:h2, title, class: 'text-xl font-semibold mb-4'),
        capture(&block)
      ])
    end
  end

  def form_row(&block)
    content_tag :div, class: 'mb-4', &block
  end

  def form_label(form, field, text = nil, options = {})
    text ||= field.to_s.humanize
    form.label field, text, options.merge(class: 'block text-sm font-medium text-gray-700 mb-1')
  end

  def form_text_field(form, field, options = {})
    form.text_field field, options.merge(
      class: 'w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500'
    )
  end

  def form_email_field(form, field, options = {})
    form.email_field field, options.merge(
      class: 'w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500'
    )
  end

  def form_password_field(form, field, options = {})
    form.password_field field, options.merge(
      class: 'w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500'
    )
  end

  def form_text_area(form, field, options = {})
    form.text_area field, options.merge(
      class: 'w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500',
      rows: 4
    )
  end

  def form_select(form, field, choices, options = {})
    form.select field, choices, options.merge(
      class: 'w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500'
    )
  end

  def form_check_box(form, field, options = {})
    form.check_box field, options.merge(
      class: 'h-4 w-4 text-blue-600 focus:ring-blue-500 border-gray-300 rounded'
    )
  end

  def form_radio_button(form, field, value, options = {})
    form.radio_button field, value, options.merge(
      class: 'h-4 w-4 text-blue-600 focus:ring-blue-500 border-gray-300'
    )
  end

  def form_file_field(form, field, options = {})
    form.file_field field, options.merge(
      class: 'w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500'
    )
  end

  def form_submit(form, text, options = {})
    form.submit text, options.merge(
      class: 'bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500'
    )
  end

  def form_group_with_label(form, field, label_text = nil, input_type = :text_field, options = {})
    form_row do
      label = form_label(form, field, label_text)
      input = send("form_#{input_type}", form, field, options)
      safe_join([ label, input ])
    end
  end

  def form_errors_for(record, field)
    return unless record.errors[field].any?

    content_tag :div, class: 'text-red-600 text-sm mt-1' do
      record.errors[field].join(', ')
    end
  end

  def form_errors_summary(record)
    return unless record.errors.any?

    content_tag :div, class: 'bg-red-50 border border-red-200 rounded-md p-4 mb-4' do
      safe_join([
        content_tag(:h3, 'Please correct the following errors:', class: 'text-red-800 font-medium mb-2'),
        content_tag(:ul, class: 'text-red-700 text-sm list-disc list-inside') do
          safe_join(record.errors.full_messages.map { |msg| content_tag(:li, msg) })
        end
      ])
    end
  end

  def form_actions(&block)
    content_tag :div, class: 'flex justify-end space-x-3 mt-6', &block
  end

  def form_primary_action(text, options = {})
    content_tag :button, text, options.merge(
      type: 'submit',
      class: 'bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500'
    )
  end

  def form_secondary_action(text, url, options = {})
    link_to text, url, options.merge(
      class: 'bg-gray-300 text-gray-700 px-4 py-2 rounded hover:bg-gray-400 focus:outline-none focus:ring-2 focus:ring-gray-500'
    )
  end

  def form_cancel_action(text = 'Cancel', url = :back, options = {})
    link_to text, url, options.merge(
      class: 'bg-gray-300 text-gray-700 px-4 py-2 rounded hover:bg-gray-400 focus:outline-none focus:ring-2 focus:ring-gray-500'
    )
  end
end
