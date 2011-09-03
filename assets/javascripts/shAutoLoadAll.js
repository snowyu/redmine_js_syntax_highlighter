
function shLoadAllSyntaxHighlighters(aPath) {
    function shApplyPath()
    {
      var args = arguments,
          result = []
          ;
           
      //plugin_assets/redmine_markdown_formatter/javascripts/
      for(var i = 0; i < args.length; i++)
          result.push(args[i].replace('@', aPath));
           
      return result
    };
    
    SyntaxHighlighter.autoloader.apply(null, shApplyPath(
      'applescript            @shBrushAppleScript.js',
      'actionscript3 as3      @shBrushAS3.js',
      'bash shell             @shBrushBash.js',
      'coldfusion cf          @shBrushColdFusion.js',
      'cpp c                  @shBrushCpp.js',
      'c# c-sharp csharp      @shBrushCSharp.js',
      'css                    @shBrushCss.js',
      'delphi pascal pas      @shBrushDelphi.js',
      'diff patch             @shBrushDiff.js',
      'erl erlang             @shBrushErlang.js',
      'groovy                 @shBrushGroovy.js',
      'java                   @shBrushJava.js',
      'jfx javafx             @shBrushJavaFX.js',
      'js jscript javascript java_script json  @shBrushJScript.js',
      'perl pl                @shBrushPerl.js',
      'php                    @shBrushPhp.js',
      'text plain plaintext   @shBrushPlain.js',
      'py python              @shBrushPython.js',
      'ruby rails ror rb rhtml  @shBrushRuby.js',
      'sass scss              @shBrushSass.js',
      'scala                  @shBrushScala.js',
      'sql                    @shBrushSql.js',
      'vb vbnet basic         @shBrushVb.js',
      'yaml yml               @shBrushYaml.js',
      'xml xhtml xslt html    @shBrushXml.js'
    ));
    

  SyntaxHighlighter.all();

}

//document.observe("dom:loaded", function() {});
//Event.observe(window, 'load', );

