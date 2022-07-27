module ApplicationHelper
  def memo_empty(memo = '')
    if memo.empty?
        'まだメモが存在しません'
    else
        memo
    end
  end
end
