module ApplicationHelper
  APPNAME   = "アプリケーション"
  DEVELOPER = "O.S"

  def view_appname
    return APPNAME
  end

  def view_developer
    return DEVELOPER
  end
  def head_title(title = '')
    if title.empty?
        return APPNAME
    else
        return APPNAME  + " | " + title
    end
  end

  def memo_empty(memo = '')
    if memo.empty?
        return 'まだメモが存在しません'
    else
        return memo
    end
  end

  def star_color_favo( favo = 0)
    case favo
    when 0 then
      return 'fill:#C00;','fill:#000;','fill:#000;','fill:#000;'
    when 1 then
      return 'fill:#C00;','fill:#CC0;','fill:#000;','fill:#000;'
    when 2 then
      return 'fill:#C00;','fill:#CC0;','fill:#CC0;','fill:#000;'
    when 3 then
      return 'fill:#C00;','fill:#CC0;','fill:#CC0;','fill:#CC0;'
    end
  end

  def navi_link( )
    return 'text' 
    #'<a href="https://www.google.com/maps/dir/?api=1&origin=' + base_lat + ',' + base_lng + '&destination=' + place_name +'&destination_place_id=' + place_id + '&travelmode=walking' + '">' + text + '</a>'
  end
end
