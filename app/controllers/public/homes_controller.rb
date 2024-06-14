class Public::HomesController < ApplicationController
  before_action :set_sidebar
  
  def top
  end

  def about
  end

  def privacy
  end

  def terms_of_service
  end
  
  private
  
  def set_sidebar
    @show_sidebar = false
  end
end
