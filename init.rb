require 'redmine'

require 'js_syntax_patch'

Redmine::Plugin.register :redmine_js_syntax_highlighter do
  name "Redmine Syntax highlighting Render on Browser plugin"
  author "Riceball LEE"
  description "Uses javascript to highlight files in the source code repository and wiki."
  version "0.1"

  # Create a dropdown list in the UI so the user can pick a theme.
  if UserCustomField.table_exists?
    unless UserCustomField.find_by_name('JSHighter Theme')
      UserCustomField.create(
        :name             => 'JSHighter Theme', 
        :default_value    => Redmine::SyntaxHighlighting::JSHighter::DEFAULT_THEME, 
        :possible_values  => Redmine::SyntaxHighlighting::JSHighter::THEMES,
        :field_format     => 'list',
        :is_required      => true
      )
    end
  end
end

require 'redmine/syntax_highlighting'
Redmine::SyntaxHighlighting.highlighter = Redmine::SyntaxHighlighting::JSHighter
