module Enumerable
  def average
    return nil if empty?
    inject(:+, 0) / count
  end
end