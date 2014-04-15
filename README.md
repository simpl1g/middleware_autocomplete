[![Gem Version](https://badge.fury.io/rb/middleware_autocomplete.svg)](http://badge.fury.io/rb/middleware_autocomplete)
[![Build Status](https://travis-ci.org/simpl1g/middleware_autocomplete.svg)](https://travis-ci.org/simpl1g/middleware_autocomplete)
[![Code Climate](https://codeclimate.com/github/simpl1g/middleware_autocomplete.png)](https://codeclimate.com/github/simpl1g/middleware_autocomplete)
[![Coverage Status](https://coveralls.io/repos/simpl1g/middleware_autocomplete/badge.png)](https://coveralls.io/r/simpl1g/middleware_autocomplete)

# MiddlewareAutocomplete

Rails middleware that generates responses for your requests without hitting your ApplicationController

Main advantage of using middleware, is that it doesn't hit your application controller and request time can be up to 2 times faster. Here are some results that I had for 1000 requests in a row:

Ruby 2.1.1

    Elapsed time for controller autocomplete: 5.695448048
    Elapsed time for rack app autocomplete: 3.419353762
    Elapsed time for rack middleware autocomplete: 2.720414571

Important: This gem provides only backend part, for frontend please use any js plugin you prefer

## Installation

Add this line to your application's Gemfile:

    gem 'middleware_autocomplete'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install middleware_autocomplete

## Usage

For example you have Post model in your application and you want to add autocomplete field in your view. Usually you will add ```autocomplete``` method to your PostsController and add route to it

    class PostsController < ApplicationController
      ...
      def autocomplete
        posts = Post.where("title LIKE ?", "#{params[:q]}_%").pluck(:title)
        render json: posts.to_json
      end
      ...
    end

This will work, but each request to this method leads to initializing whole ApplicationController, this isn't really effective to fetch simple json array. With this gem in place you can create simple file ```app/autocompletes/posts_autocomplete.rb```

    class PostsAutocomplete < MiddlewareAutocomplete::Base

      def self.search(params)
        Post.where("title LIKE ?", "#{params['q']}_%").pluck(:title).to_json
      end

    end

This will create ```autocomplete_posts_path``` url helper, so you can use it in views. Requesting this path will render the same response without initializing your Controller, so the time to respond can be reduce up to 2 times.

# Settings

You can pass this options to each Autocomplete class

    class PostsAutocomplete < MiddlewareAutocomplete::Base
      # self.namespace = '/autocomplete'
      # Prepended to all your paths

      # self.content_type = :json
      # Can be any Rails Mime::Type
      # Your search method should return result with same content type

      # self.path = nil
      # Path to resource without namespace
      # By default it takes class name without Autocomplete part,
      # e.g. PostsAutocomplete => 'posts'

      # self.route_name = nil
      # UrlHelper that will be generated for this class.
      # Default #{self.namespace}_#{self.path}_path

      # self.use_with_connection = false
      # Ensures correct handling of database connections.
      # Set it to false only if you are not using database.
      ...
    end

## Setting defaults

You can change default namespace, content_type and use_with_connecton for all classes. Create ```config/initializers/middleware_autocomplete.rb```

    MiddlewareAutocomplete.setup do |config|
      config.namespace = '/search'
      config.content_type = :xml
      config.use_with_connection = false
    end

Now middleware will respond with application/xml content type and all paths will start with /search

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
