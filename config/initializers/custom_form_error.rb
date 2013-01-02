module ActionView
  class Base
    @@field_error_proc = Proc.new do |html_tag, instance, options|

      if options['show_error_msg'].present?
        error_type = instance.method_name.to_sym
        errors     = instance.object.errors

        "<div class=\"field_with_errors\">#{html_tag}<ul>#{
        errors.messages[error_type].map do |error|
          "<li class=\"help-inline\">#{errors.full_message(error_type, error)}</li>"
        end.join
        }</ul></div>".html_safe
      else
        "<div class=\"field_with_errors\">#{html_tag}</div>".html_safe
      end
    end
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

