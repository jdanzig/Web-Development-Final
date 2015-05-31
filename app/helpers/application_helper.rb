module ApplicationHelper
  def navbar_entry(*args, &block)
    link_text = block_given? ? block.yield : args.shift
    url = args.shift
    content_tag :li, :class => ( current_page?(url) ? [ :active ] : [] ) do
      link_to url, *args do
        link_text
      end
    end
  end

  def star(filled=true)
    content_tag :i, :class => [ 'fa', filled ? 'fa-star' : 'fa-star-o' ] do 
    end
  end

  def stars(num=5)
    return "No Ratings" if num.nil?
    filled = [[5,num].min, 0].max
    empty = 5-filled
    arr = []
    filled.times { arr << star }
    empty.times { arr << star(false) }
    arr.join.html_safe
  end

end
