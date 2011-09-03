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
        require 'coderay/helpers/file_type'
        def highlight_by_filename(text, filename)
          language = CodeRay::FileType.fetch(filename, :plaintext)
          language = :plaintext if [:yaml, :scheme, :debug].include?(language) 
          "<pre class=\"brush: #{language};\">#{ERB::Util.h(text)}</pre>"
        end
        
        def highlight_by_language(text, language)
          language = :plaintext if [:yaml, :scheme, :debug].include?(language) 
          "<pre class=\"brush: #{language};\">#{ERB::Util.h(text)}</pre>"
        end
        
        def theme
            ## User selection of highlighter Theme
            User.current.custom_value_for(CustomField.first(:conditions => {:name => 'JSHighter Theme'})) || JSHighter::DEFAULT_THEME
        end
      end
      
      class Assets < Redmine::Hook::ViewListener
        def view_layouts_base_html_head(context)
          if context[:controller]
            js_path = Engines::RailsExtensions::AssetHelpers.plugin_asset_path('redmine_js_syntax_highlighter', 'javascripts', '')
            stylesheet_link_tag('shCore.css', :plugin => 'redmine_js_syntax_highlighter') +
            stylesheet_link_tag("shTheme#{Redmine::SyntaxHighlighting::JSHighter.theme}.css", :plugin => "redmine_js_syntax_highlighter") +
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
