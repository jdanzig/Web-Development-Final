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
end
