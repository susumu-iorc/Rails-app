class BasesController < ApplicationController
  #住所登録のページ
  def show
    @base = Base.find_by(user_id: current_user.id)
  end

  # 住所登録の変更手続き
  def create
    @base = Base.new
    @full_address = "#{params[:pref]}#{params[:city]}#{params[:area]}" 
    puts Constants::GOOGLE_API_KEY 

    # パラメーターを設定
    # params = URI.encode_www_form({})
    # URIを設定
    @full_address = URI.encode_www_form_component(@full_address)
    uri = URI.parse("https://maps.googleapis.com/maps/api/geocode/json?new_forward_geocoder=true&address=#{@full_address}&key=#{Constants::GOOGLE_API_KEY}")

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
    @result = JSON.parse(response.body)
      
    if @result["status"] == "OK"
      if !Base.exists?(user_id: current_user.id)
        base = Base.new(  user_id:        current_user.id,
                          user_post_code: params[:post_code],
                          user_pref:      params[:pref],
                          user_city:      params[:city],
                          user_area:      params[:area],
                          lat:            @result["results"][0]["geometry"]["location"]["lat"],
                          lng:            @result["results"][0]["geometry"]["location"]["lng"]
                       ) 
        if base.save
          puts 'make'
        else
          puts 'make miss'
        end
      else
        base = Base.update( user_id:        current_user.id,
                            user_post_code: params[:post_code],
                            user_pref:      params[:pref],
                            user_city:      params[:city],
                            user_area:      params[:area],
                            lat:            @result["results"][0]["geometry"]["location"]["lat"],
                            lng:            @result["results"][0]["geometry"]["location"]["lng"]
                            )
        puts 'SET'
       end
    end       


  end
end
