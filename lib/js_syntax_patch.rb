module Redmine
  module SyntaxHighlighting
    module JSHighter
      
      DEFAULT_THEME = "Default"
      THEMES = %w[
          Default
          Django
          Eclipse
          Emacs
          FadeToGrey
          MDUltra
          Midnight
          RDark
      ]   
         
      class << self
        def highlight_by_filename(text, filename, encoding=true)
          require 'coderay/helpers/file_type'
          language = ::CodeRay::FileType.fetch(filename, :plaintext)
          text = ERB::Util.h(text) if encoding
          language = :plaintext if [:yaml, :scheme, :debug].include?(language) 
          "<pre class=\"brush: #{language};\">#{text}</pre>"
        end
        
        def highlight_by_language(text, language, encoding=true)
          language = :plaintext if [:yaml, :scheme, :debug].include?(language) 
          text = ERB::Util.h(text) if encoding
          "<pre class=\"brush: #{language};\">#{text}</pre>"
        end
        
        def theme
            ## User selection of highlighter Theme
            User.current.custom_value_for(CustomField.first(:conditions => {:name => 'JSHighter Theme'})) || JSHighter::DEFAULT_THEME
        end
      end
      
      class Assets < Redmine::Hook::ViewListener
        def view_layouts_base_html_head(context)
          if context[:controller]
            js_path  = Engines::RailsExtensions::AssetHelpers.plugin_asset_path('redmine_js_syntax_highlighter', 'javascripts', '')
            js_theme = Redmine::SyntaxHighlighting::JSHighter.theme != '' ?  "Default" :  Redmine::SyntaxHighlighting::JSHighter.theme
            stylesheet_link_tag('shCore.css', :plugin => 'redmine_js_syntax_highlighter') +
            stylesheet_link_tag("shTheme#{js_theme}.css", :plugin => "redmine_js_syntax_highlighter") +
            javascript_include_tag('shCore.js', :plugin => 'redmine_js_syntax_highlighter') +
            javascript_include_tag('shAutoloader.js', :plugin => 'redmine_js_syntax_highlighter') +
            javascript_include_tag('shAutoLoadAll.js', :plugin => 'redmine_js_syntax_highlighter') +
            javascript_tag("document.observe(\"dom:loaded\", function () {shLoadAllSyntaxHighlighters(\"#{js_path}\");});")
          end
        end
      end
    end
  end
end
