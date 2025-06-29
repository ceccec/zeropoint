# frozen_string_literal: true

module ApplicationHelper
  # Flash message helpers
  def flash_class(key)
    case key.to_sym
    when :notice, :success
      'bg-green-100 text-green-800'
    when :alert, :error
      'bg-red-100 text-red-800'
    when :warning
      'bg-yellow-100 text-yellow-800'
    when :info
      'bg-blue-100 text-blue-800'
    else
      'bg-gray-100 text-gray-800'
    end
  end

  def render_flash_messages
    return unless flash.any?

    content_tag :div, class: 'mb-4' do
      flash.map do |key, value|
        content_tag :div, value, class: "p-3 rounded #{flash_class(key)}"
      end.join.html_safe
    end
  end

  # User helpers
  def user_avatar(user, size: 40)
    if user.avatar.attached?
      image_tag user.avatar, class: "rounded-full w-#{size} h-#{size}"
    else
      content_tag :div, user.full_name.first.upcase,
                  class: "rounded-full w-#{size} h-#{size} bg-blue-500 text-white flex items-center justify-center font-bold"
    end
  end

  def user_link(user)
    link_to user.full_name, user_path(user), class: 'text-blue-600 hover:text-blue-800'
  end

  # Post helpers
  def post_excerpt(post, length: 150)
    content_tag :p, post.excerpt(length), class: 'text-gray-600'
  end

  def post_meta(post)
    content_tag :div, class: 'text-sm text-gray-500' do
      safe_join([
        t('demo.posted_by'),
        user_link(post.user),
        t('demo.on'),
        time_ago_in_words(post.created_at),
        t('demo.ago')
      ], ' ')
    end
  end

  def post_tags(post)
    return unless post.respond_to?(:tag_list) && post.tag_list.any?

    content_tag :div, class: 'mt-2' do
      safe_join(post.tag_list.map do |tag|
        content_tag :span, tag, class: 'inline-block bg-blue-100 text-blue-800 text-xs px-2 py-1 rounded mr-1 mb-1'
      end)
    end
  end

  # Form helpers
  def form_group(field, label_text = nil, &block)
    label_text ||= field.to_s.humanize
    content_tag :div, class: 'mb-4' do
      safe_join([
        label_tag(field, label_text, class: 'block text-sm font-medium text-gray-700 mb-1'),
        capture(&block)
      ])
    end
  end

  def text_field_with_label(form, field, label_text = nil, options = {})
    form_group(field, label_text) do
      form.text_field field, options.merge(class: 'w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500')
    end
  end

  def text_area_with_label(form, field, label_text = nil, options = {})
    form_group(field, label_text) do
      form.text_area field, options.merge(class: 'w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500', rows: 4)
    end
  end

  def select_with_label(form, field, choices, label_text = nil, options = {})
    form_group(field, label_text) do
      form.select field, choices, options.merge(class: 'w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500')
    end
  end

  # Button helpers
  def primary_button(text, url = nil, options = {})
    classes = 'bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500'
    options[:class] = "#{classes} #{options[:class]}".strip

    if url
      link_to text, url, options
    else
      content_tag :button, text, options
    end
  end

  def secondary_button(text, url = nil, options = {})
    classes = 'bg-gray-300 text-gray-700 px-4 py-2 rounded hover:bg-gray-400 focus:outline-none focus:ring-2 focus:ring-gray-500'
    options[:class] = "#{classes} #{options[:class]}".strip

    if url
      link_to text, url, options
    else
      content_tag :button, text, options
    end
  end

  def danger_button(text, url = nil, options = {})
    classes = 'bg-red-600 text-white px-4 py-2 rounded hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-red-500'
    options[:class] = "#{classes} #{options[:class]}".strip

    if url
      link_to text, url, options
    else
      content_tag :button, text, options
    end
  end

  # Card helpers
  def card(title = nil, &block)
    content_tag :div, class: 'bg-white rounded-lg shadow-md p-6' do
      safe_join([
        (content_tag(:h3, title, class: 'text-lg font-semibold mb-4') if title),
        capture(&block)
      ].compact)
    end
  end

  def card_header(title, &block)
    content_tag :div, class: 'border-b border-gray-200 pb-4 mb-4' do
      safe_join([
        content_tag(:h3, title, class: 'text-lg font-semibold'),
        (capture(&block) if block_given?)
      ].compact)
    end
  end

  # Status helpers
  def status_badge(status)
    classes = case status.to_s
    when 'published', 'active', 'success'
                'bg-green-100 text-green-800'
    when 'draft', 'pending'
                'bg-yellow-100 text-yellow-800'
    when 'archived', 'inactive', 'error'
                'bg-red-100 text-red-800'
    else
                'bg-gray-100 text-gray-800'
    end

    content_tag :span, status.to_s.humanize, class: "inline-block px-2 py-1 text-xs font-medium rounded #{classes}"
  end

  # Pagination helpers
  def pagination_info(collection)
    return unless collection.respond_to?(:current_page)

    content_tag :div, class: 'text-sm text-gray-500 text-center mt-4' do
      t('demo.pagination_info',
        current_page: collection.current_page,
        total_pages: collection.total_pages,
        total_count: collection.total_count)
    end
  end

  # Search helpers
  def search_form(url: nil, placeholder: nil)
    url ||= request.path
    placeholder ||= t('demo.search_placeholder')

    form_with url: url, method: :get, local: true, class: 'mb-4' do |form|
      content_tag :div, class: 'flex' do
        safe_join([
          form.text_field(:q, value: params[:q], placeholder: placeholder,
                           class: 'flex-1 px-3 py-2 border border-gray-300 rounded-l-md focus:outline-none focus:ring-2 focus:ring-blue-500'),
          content_tag(:button, t('demo.search'), type: 'submit',
                               class: 'px-4 py-2 bg-blue-600 text-white rounded-r-md hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500')
        ])
      end
    end
  end
end
