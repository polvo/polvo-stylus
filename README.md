# Polvo Stylus

With this plugin, Polvo can handle Stylus source files.

[![Stories in Ready](https://badge.waffle.io/polvo/polvo-stylus.png)](https://waffle.io/polvo/polvo-stylus)

[![Dependency Status](https://gemnasium.com/polvo/polvo-stylus.png)](https://gemnasium.com/polvo/polvo-stylus) [![NPM version](https://badge.fury.io/js/polvo-stylus.png)](http://badge.fury.io/js/polvo-stylus)

# Install

You won't need to install it since it comes built in in Polvo.

# Instructions

Just put your `.styl` files in your `input dirs` and it will be ready for use.

# Partials

There's a built in support for partials in Stylus, Polvo will handle them in a 
particular conventioned way.

Every file starting with `_` won't be compiled alone. Instead, if some other
file that doesn't start with `_` imports it, it will be compiled within it.

The import tag follows the Stylus include's default syntax.

To include a partial in your `stylus`, just:

 1. Name your patial accordingly so it starts with `_`
 1. Include it in any of your html files by using the syntax

 ````html
 @import "./path/to/your/_partial-name-here"
 ````

 Partials are referenced relatively.