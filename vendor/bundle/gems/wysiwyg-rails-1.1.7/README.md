# wysiwyg-rails [![Gem Version](https://badge.fury.io/rb/wysiwyg-rails.png)](http://badge.fury.io/rb/wysiwyg-rails) [![Build Status](https://secure.travis-ci.org/froala/wysiwyg-rails.png)](http://travis-ci.org/froala/wysiwyg-rails)

wysiwyg-rails provides the [Froala WYWIWYG Editor](http://editor.froala.com) javascript and stylesheets as a Rails engine for use with the asset pipeline.

## Installation

Add this to your Gemfile:

```ruby
gem "wysiwyg-rails"
```

and run `bundle install`.

## Usage

In your `application.css`, include the css file:

```css
/*
 *= require froala_editor.min.css
 */
```

If you want to use the dark theme, then you have to include `themes/dark.min.css` file too.

In your `application.js`, include the js file:

```javascript
//
//= require froala_editor.min.js
//
// Include Beautify lib if needed.
//= require libs/beautify/beautify-html.js
//
```

If you need to use any of the [Available Plugins][http://editor.froala.com/plugins], then you should include those too in your `application.js`.
```javascript
// Include other plugins.
//= require plugins/block_styles.min.js
//= require plugins/colors.min.js
//= require plugins/media_manager.min.js
//= require plugins/tables.min.js
//= require plugins/video.min.js
//= require plugins/fonts/fonts.min.js
//= require plugins/fonts/font_family.min.js
//= require plugins/fonts/font_size.min.js
```

Similar, if you want to use language translation you have to include the translation file.
```javascript
// Include Language if needed
//= require langs/ro.js
```

Then restart your webserver if it was previously running.

Congrats all is done!

## License

The `wysiwyg-rails` project is under MIT license.

You may use the editor for non-commercial websites for free under the [Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License](http://creativecommons.org/licenses/by-nc-nd/4.0/).

Froala Editor has [3 different licenses](http://editor.froala.com/download/) for commercial use.
For details please see [License Agreement](http://editor.froala.com/license).
