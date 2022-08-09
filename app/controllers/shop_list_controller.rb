class ShopListController < ApplicationController
  def home
    if user_signed_in?
      # ユーザーが住所を登録していない場合
      if !Base.exists?(user_id: current_user.id)
        #@base = Base.new
        redirect_to "/config/base"
      #登録している場合
      else
        @base = Base.find_by(user_id: current_user.id)
        # 住所が不正っぽい場合
        if @base.lat.blank? || @base.lng.blank?
          redirect_to "/config/base"
        else
          gon.base = @base
          # PLACE API のURI
          uri = URI.parse("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{@base.lat},#{@base.lng}&radius=500&types=restaurant&language=ja&key=#{Constants::GOOGLE_API_KEY}")
          # ダミー用json
          # uri = URI.parse("https://iorc.net/fake/json.json")
          @query = uri.query

          # データ取得
          http = Net::HTTP.new(uri.host, uri.port)
          request = Net::HTTP::Get.new(uri.request_uri)
          # httpsのサイトに送るときは要記述
          http.use_ssl = true
          # リクエストを送る
          response = http.request(request)
          # レスポンスの確認
          logger.debug response.code
          logger.debug response.body

          @place_name   = []
          @place_id     = []
          @place_address= []
          @place_lat    = []
          @place_lng    = []
          @memo_exists  = []
          @memo         = []
          @navi_link_html = []
          @place_num    = 0
          # 例外処理
          begin
            @result = JSON.parse(response.body)

            while !@result[ "results" ][ @place_num ][ "place_id" ].nil?
              @place_name.push    ( @result[ "results" ][ @place_num ][ "name" ])
              @place_id.push      ( @result[ "results" ][ @place_num ][ "place_id" ])
              @place_address.push ( @result[ "results" ][ @place_num ][ "vicinity" ])
              @place_lat.push ( @result["results"][ @place_num ]["geometry"]["location"]["lat"])
              @place_lng.push ( @result["results"][ @place_num ]["geometry"]["location"]["lng"])

              #Shopがデータベースに存在しなかったらデータベースに保存
              if !Shop.exists?(place_id: @place_id[@place_num])
                shop = Shop.new(  place_id:      @result["results"][ @place_num ]["place_id"],
                                  shop_name:     @result["results"][ @place_num ]["name"],
                                  shop_address:  @result["results"][ @place_num ]["vicinity"],
                                  lat:           @result["results"][ @place_num ]["geometry"]["location"]["lat"],
                                  lng:           @result["results"][ @place_num ]["geometry"]["location"]["lng"])
                if shop.save
                  # @memo_exists.push("保存しました")
                else
                  # @memo_exists.push("保存失敗")
                end
              end

              # Memoがデータベースに存在しなかっtら作成、保存
              if Memo.exists?(user_id: current_user.id, place_id: @place_id[@place_num])

              else
                memo = Memo.new( user_id: current_user.id, 
                                  place_id: @result["results"][ @place_num ]["place_id"],
                                  memo: "",
                                  count: 0,
                                  favorite: 0)
                if memo.save
                  @memo_exists.push("memo作りました")
                end
              end

              @memo.push( Memo.find_by(place_id: @place_id[@place_num], user_id: current_user.id) )
              @place_num+=1
            end


          # エラー処理
          rescue => e
            @message = "e.message"
          end
        end
      end
    end
    # gonでjsにわたす変数を宣言
    gon.A_Z_Char = [*'A'..'Z']
    gon.place_name = @place_name 
    gon.place_id   = @place_id 
    gon.place_num = @place_num
    gon.place_lat = @place_lat
    gon.place_lng = @place_lng
    gon.navi_link = @navi_link_html
  end
  def new
  end
end
