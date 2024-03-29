class MemosController < ApplicationController
  protect_from_forgery 
  def show
    if user_signed_in?
      @place_id = params[:place_id]
      @shop   = Shop.find_by(place_id: @place_id)
      @memo   = Memo.find_by(place_id: @place_id, user_id: current_user.id)
      @base = Base.find_by(user_id: current_user.id)
      gon.base = @base
      gon.shop = @shop
    else
      redirect_to root_path
    end
  end

  def update

    # user_signed_in 及び　current_user.idが動かないので妥協策としてparms[:user_id]を使用する
    if user_signed_in? || params[:user_id]
      # @memo = Memo.find_by(place_id: params[:place_id], user_id: current_user.id)
      @memo = Memo.find_by(place_id: params[:place_id], user_id: params[:user_id])
      # メモの更新
      if !params[:memo].nil?
        puts "FAVORITE => #{@memo.favorite}"
        if @memo.update(memo:params[:memo])
          # 更新に成功した場合リロード
          redirect_to request.referer
        end
      end

      # 回数の更新
      if !params[:count].nil?
        puts "FAVORITE => #{@memo.favorite}"
        if @memo.update(count: @memo.count + 1)
          # 更新に成功した場合リロード
          redirect_to request.referer
        end
      end

      # お気に入り変更
      if !params[:favo].nil?

        if params[:favo].to_i >= 0 && params[:favo].to_i <= 3 
            @memo.favorite = params[:favo].to_i
        end
        if @memo.update(favorite: @memo.favorite)
          # 更新に成功した場合リロード
          redirect_to request.referer
        end
      end
    else
      puts "ERRORRRRRRRRRRRR@@@@@@@@@@@@@@@@@@@@@@"   # 特に意味はないが、デバッグしやすいように
      puts current_user.id
      redirect_to request.referer
    end
  end
end
