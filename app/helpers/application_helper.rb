module ApplicationHelper
  def duration_of_time_in_words(secs)
    distance_of_time_in_words(0, secs, include_seconds: true)
  end

  def button_link_to(name = nil, options = {}, html_options = {}, &block)    
    name, options, html_options = capture(&block), name, options if block_given?
    html_options[:class] ||= ""
    html_options[:class] += " btn btn-default"

    if html_options[:disabled]
      content_tag(:span, name, html_options)
    else
      link_to(name, options, html_options)
    end
  end
end
