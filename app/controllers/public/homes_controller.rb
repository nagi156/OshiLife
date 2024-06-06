class Public::HomesController < ApplicationController
  def top
    @page = "top"
  end
  
  def about
    @page = "about"
  end
end
