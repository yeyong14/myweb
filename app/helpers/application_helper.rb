module ApplicationHelper
  def full_title(page_title)
    base_title="Twitter?"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end
	
	def timeago(time, options = {})
    options[:class]
    options[:class] = options[:class].blank? ? "timeago" : [options[:class],"timeago"].join(" ")
    content_tag(:abbr, "", options.merge(:title => time.iso8601)) if time
  end
end
