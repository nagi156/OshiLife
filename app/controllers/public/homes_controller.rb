class Public::HomesController < ApplicationController
  def top
    @page = "top"
  end

  def about
    @page = "about"
  end

  def privacy
    @page = "privacy"
  end

  def terms_of_service
    @page = "terms_of_service"
  end
end
