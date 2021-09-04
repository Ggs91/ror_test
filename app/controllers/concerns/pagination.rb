module Pagination
  DEFAULT_PAGE = 1
  DEFAULT_PER_PAGE = 10

  def page
    params[:page] || DEFAULT_PAGE
  end

  def per_page
    params[:per_page] || DEFAULT_PER_PAGE
  end
end
