class ShopListController < ApplicationController
  def home

    # パラメーターを設定
    # params = URI.encode_www_form({})
    # URIを設定
    uri = URI.parse("https://iorc.net/fake/json.json")

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
    @memo_exists = []
    @place_num    = 0
    # 例外処理
    begin
      @result = JSON.parse(response.body)

      while !@result[ "results" ][ @place_num ][ "place_id" ].nil?
        @place_name.push    ( @result[ "results" ][ @place_num ][ "name" ])
        @place_id.push      ( @result[ "results" ][ @place_num ][ "place_id" ])
        @place_address.push ( @result[ "results" ][ @place_num ][ "vicinity" ])

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
        if Memo.exists?(user_id: current_user.id, place_id: @place_id[@place_num]) then
          @memo_exists.push("memo存在します")
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
        @place_num+=1
      end

    # エラー処理
    rescue => e
      @message = "e.message"
    end

    # Memoの存在確認
  end

  def new
  end
end
