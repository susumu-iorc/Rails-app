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




    @place_name =[]
    @place_id =[]
    @place_address=[]
    @place_num = 0
    # 例外処理
    begin
      @result = JSON.parse(response.body)

      while !@result["results"][ @place_num]["place_id"].nil?
        @place_name.push( @result["results"][ @place_num]["name"])
        @place_id.push( @result["results"][ @place_num]["place_id"])
        @place_address.push(@result["results"][ @place_num]["vicinity"])
        @place_num+=1
      end

    # エラー処理
    rescue => e
      @message = "e.message"
    end
  end
end
