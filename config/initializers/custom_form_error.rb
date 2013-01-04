ActionView::Base.field_error_proc = Proc.new do |html_tag, instance, options|
  if options['bootstrap_friendly'].present?
    out = Nokogiri::HTML::DocumentFragment.parse(html_tag)
    out.search('input').each { |anchor| anchor['class'] = anchor['class'] << ' error' }
    out.to_html.html_safe
  else
    "<div class=\"field_with_errors\">#{html_tag}</div>".html_safe
  end
end

module ActionView
  module Helpers
    module ActiveModelInstanceTag
      def tag(type, options, *)
        tag_generate_errors?(options) ? error_wrapping(super, options) : super
      end

      def error_wrapping(html_tag, options=nil)
        if object_has_errors?
          Base.field_error_proc.call(html_tag, self, options)
        else
          html_tag
        end
    end
    end
  end
end


