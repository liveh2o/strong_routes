[![Build](https://github.com/liveh2o/strong_routes/actions/workflows/main.yml/badge.svg)](https://github.com/liveh2o/strong_routes/actions)
[![Ruby Style Guide](https://img.shields.io/badge/code_style-standard-brightgreen.svg)](https://github.com/standardrb/standard)
[![Gem Version](https://badge.fury.io/rb/strong_routes.svg)](https://badge.fury.io/rb/strong_routes)

# Strong Routes

Strong Routes is a simple Rack middleware to reject requests to unknown routes before allocating connections or any resources.

## Installation

Add this line to your application's Gemfile:

    gem 'strong_routes'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install strong_routes

## Usage

### Rails Apps

In Rails apps, using Strong Routes is as simple as adding it to your Gemfile. The middleware is automatically added to the middleware stack. Any routes defined by the application are automatically allowed by default.

### Rack Apps

In Rack apps, load the `StrongRoutes::Allow` middleware into your middleware stack:

```Ruby
app.insert_before StrongRoutes::Allow, ResourceLoadingMiddleware
```

In (non-Rails) Rack apps, allowed routes are empty default. Allowed routes are specified using the `allowed_routes` config option:

```Ruby
StrongRoutes.config.allowed_routes = [ '/', '/posts' ]
```

Routes can be specified as strings or regular expressions:

```Ruby
StrongRoutes.config.allowed_routes = [ /\A\//i, /\A\/posts/i ]
```

### Response

Any routes that aren't allowed will return a 404 by default. In Rails apps, Strong Routes renders `public/404.html` if it is present. If it is not, Strong Routes renders an empty response:

```
[ 404, {}, [] ]
```

The content that is returned can be specified using the `content` config option:

```Ruby
StrongRoutes.config.content = File.read(Rails.root.join('public/404.html'))
StrongRoutes.config.content_type = "text/html"
```

## Contributing

1. Fork it ( http://github.com/<my-github-username>/strong_routes/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
