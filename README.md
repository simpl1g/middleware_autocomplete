[![Build Status](https://travis-ci.org/simpl1g/middleware_autocomplete.svg)](https://travis-ci.org/simpl1g/middleware_autocomplete)
[![Code Climate](https://codeclimate.com/github/simpl1g/middleware_autocomplete.png)](https://codeclimate.com/github/simpl1g/middleware_autocomplete)
[![Coverage Status](https://coveralls.io/repos/simpl1g/middleware_autocomplete/badge.png)](https://coveralls.io/r/simpl1g/middleware_autocomplete)

# MiddlewareAutocomplete

Generates autocomplete response straight from your middleware, currently works only for Rails

Main advantage of using middleware, is that it doesn't hit your application controller and request time can be up to 2 times faster
Here are some results that I had for 1000 requests in a row

Ruby 2.1.1

    Elapsed time for controller autocomplete: 5.695448048
    Elapsed time for rack app autocomplete: 3.419353762
    Elapsed time for rack middleware autocomplete: 2.720414571

## Installation

Add this line to your application's Gemfile:

    gem 'middleware_autocomplete'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install middleware_autocomplete

Add to ```application.rb``` config file line

    config.middleware.use 'MiddlewareAutocomplete::Router'

If you don't need any of middlewares provided by Rails, you can shave some time by placing MiddlewareAutocomplete on top of your middleware list

    config.middleware.insert_before 0, 'MiddlewareAutocomplete::Router'

## Usage

Create file ```app/autocompletes/posts_autocomplete.rb```

    class PostsAutocomplete < MiddlewareAutocomplete::Base
      # self.namespace = '/autocomplete'

      # self.content_type = :json

      # self.path = nil # By default it takes class name without Autocomplete part,
      # e.g. PostsAutocomplete => 'posts'

      # self.route_name = nil # UrlHelper that will be generated for this class,
      # Default #{self.namespace}_#{self.path}_path

      # Returns search results for autocompletition
      # Result should be in the same format that your content_type
      #
      # ==== Attributes
      #
      # * +params+ - Params hash passed to request
      def self.search(params)
        Post.your_method_to_search(params['q']).to_json
      end

    end

By default this will create ```autocomplete_posts_path``` url helper, so you can use it in views

Now you can send requests to this path


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
