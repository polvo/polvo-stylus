# Polvo Stylus

With this plugin, Polvo can handle Stylus source files.

[![Stories in Ready](https://badge.waffle.io/polvo/polvo-stylus.png)](https://waffle.io/polvo/polvo-stylus)

[![Build Status](https://secure.travis-ci.org/polvo/polvo-stylus.png)](http://travis-ci.org/polvo/polvo-stylus) [![Coverage Status](https://coveralls.io/repos/polvo/polvo-stylus/badge.png)](https://coveralls.io/r/polvo/polvo-stylus)

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
 1. Include it in any of your `styl` files by using the syntax

 ````css
 @import "./path/to/your/_partial-name-here"
 ````

 Partials are referenced relatively.

 # Nib

 Nib is play be default, don';'t need to import it in order to use.