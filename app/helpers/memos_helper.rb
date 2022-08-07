module MemosHelper
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
end
