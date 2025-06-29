# frozen_string_literal: true

module LayoutHelper
  def page_title(title = nil)
    content_for(:title, title) if title
    (content_for?(:title)) ? content_for(:title) : 'GraphQL UI Layout Demo'
  end

  def page_header(title, subtitle = nil)
    content_tag :div, class: 'mb-6' do
      safe_join([
        content_tag(:h1, title, class: 'text-3xl font-bold text-gray-900'),
        (content_tag(:p, subtitle, class: 'text-gray-600 mt-2') if subtitle)
      ].compact)
    end
  end

  def breadcrumb(items)
    return unless items.any?

    content_tag :nav, class: 'mb-4' do
      content_tag :ol, class: 'flex items-center space-x-2 text-sm text-gray-500' do
        safe_join(items.map.with_index do |item, index|
          if item.is_a?(Array)
            text, url = item
            if index == items.length - 1
              content_tag(:li, text, class: 'text-gray-900')
            else
              safe_join([
                link_to(text, url, class: 'hover:text-gray-700'),
                content_tag(:span, '>', class: 'mx-2')
              ])
            end
          else
            content_tag(:li, item, class: 'text-gray-900')
          end
        end)
      end
    end
  end

  def sidebar_section(title, &block)
    content_tag :div, class: 'mb-6' do
      safe_join([
        content_tag(:h3, title, class: 'text-lg font-semibold text-gray-900 mb-3'),
        capture(&block)
      ])
    end
  end

  def sidebar_link(text, url, options = {})
    active_class = (current_page?(url)) ? 'bg-blue-100 text-blue-700' : 'text-gray-600 hover:bg-gray-100'
    link_to text, url, options.merge(class: "block px-3 py-2 rounded-md text-sm font-medium #{active_class}")
  end

  def sidebar_nav(items)
    content_tag :nav, class: 'space-y-1' do
      safe_join(items.map do |item|
        if item.is_a?(Array)
          text, url, options = item
          sidebar_link(text, url, options || {})
        else
          content_tag(:div, item, class: 'px-3 py-2 text-sm text-gray-500')
        end
      end)
    end
  end

  def main_content(&block)
    content_tag :div, class: 'flex-1', &block
  end

  def sidebar(&block)
    content_tag :div, class: 'w-64 bg-white shadow-sm border-r border-gray-200 p-4', &block
  end

  def two_column_layout(sidebar_content = nil, &block)
    content_tag :div, class: 'flex min-h-screen bg-gray-50' do
      safe_join([
        (sidebar { sidebar_content } if sidebar_content),
        main_content { capture(&block) }
      ].compact)
    end
  end

  def container(&block)
    content_tag :div, class: 'max-w-7xl mx-auto px-4 sm:px-6 lg:px-8', &block
  end

  def grid_layout(columns: 3, gap: 6, &block)
    content_tag :div, class: "grid grid-cols-1 md:grid-cols-2 lg:grid-cols-#{columns} gap-#{gap}", &block
  end

  def flex_layout(direction: 'row', justify: 'start', align: 'start', gap: 4, &block)
    classes = "flex flex-#{direction} justify-#{justify} items-#{align} gap-#{gap}"
    content_tag :div, class: classes, &block
  end

  def responsive_container(&block)
    content_tag :div, class: 'w-full max-w-4xl mx-auto', &block
  end

  def section(title = nil, &block)
    content_tag :section, class: 'mb-8' do
      safe_join([
        (content_tag(:h2, title, class: 'text-2xl font-bold text-gray-900 mb-4') if title),
        capture(&block)
      ].compact)
    end
  end

  def divider
    content_tag :hr, class: 'border-gray-200 my-6'
  end

  def spacer(height = 4)
    content_tag :div, '', class: "h-#{height}"
  end

  def loading_spinner(text = 'Loading...')
    content_tag :div, class: 'flex items-center justify-center p-4' do
      safe_join([
        content_tag(:div, '', class: 'animate-spin rounded-full h-8 w-8 border-b-2 border-blue-600'),
        content_tag(:span, text, class: 'ml-2 text-gray-600')
      ])
    end
  end

  def empty_state(title, description, action_text = nil, action_url = nil)
    content_tag :div, class: 'text-center py-12' do
      safe_join([
        content_tag(:h3, title, class: 'text-lg font-medium text-gray-900 mb-2'),
        content_tag(:p, description, class: 'text-gray-600 mb-4'),
        (if action_text && action_url
           link_to(action_text, action_url,
                   class: 'bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700')
         end)
      ].compact)
    end
  end

  def meta_tags(description: nil, keywords: nil, author: nil, og_image: nil)
    safe_join([
      (tag.meta(name: 'description', content: description) if description),
      (tag.meta(name: 'keywords', content: keywords) if keywords),
      (tag.meta(name: 'author', content: author) if author),
      (tag.meta(property: 'og:image', content: og_image) if og_image)
    ].compact)
  end
end
