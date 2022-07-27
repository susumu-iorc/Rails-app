class MemosController < ApplicationController
  def show
    @pageid = params[:place_id]
  end
end
