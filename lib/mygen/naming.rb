module Mygen
  module Naming

    # Camel case name
    def cc_name
      camel_case(@name)
    end

    def camel_case(str)
      str.gsub(/(-|_)/, '_').split('_').collect(&:capitalize).join
    end

    # Snake case name
    def s_name
      snake_case(@name)
    end

    def snake_case(str)
      str.gsub(/::/, '/').
        gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
        gsub(/([a-z\d])([A-Z])/,'\1_\2').
        tr("-", "_").
        split('/').last.
        downcase
    end

    # Dash name, will transform underscores into dash
    # E.g UserDevice will turn into user-device
    def d_name
      dash_case(@name)
    end

    def dash_case(str)
      snake_case(str).tr('_','-')
    end
  end
end
