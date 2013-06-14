module ApplicationHelper
  def title(page_title)
    content_for(:title) { h(page_title.to_s) }
  end

  def fluid(enabled=true)
    @is_fluid = enabled
  end
end
