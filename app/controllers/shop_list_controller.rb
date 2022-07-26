class ShopListController < ApplicationController
  def show
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
    # 例外処理
    begin
      @result = JSON.parse(response.body)

      @place_name     = @result["results"][0]["name"]
      @place_id       = @result["results"][0]["place_id"]
      @place_address  = @result["results"][0]["vicinity"]


    # エラー処理
    rescue => e
      @message = "e.message"
    end
  end
end
