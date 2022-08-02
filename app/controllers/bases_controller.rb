class BasesController < ApplicationController
  def new
  end
  def create
    @base = Base.new
    full_address = "#{params[:pref]}#{params[:city]}#{params[:area]}" 
    puts full_address
  end
end
