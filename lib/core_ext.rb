module Enumerable
  def average
    return nil if empty?
    inject(:+) / count
  end
end