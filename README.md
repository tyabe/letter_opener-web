# LetterOpener::Web

[![Build Status](https://travis-ci.org/tyabe/letter_opener-web.svg)](https://travis-ci.org/tyabe/letter_opener-web)

A Sinatra-based frontend to the [letter_opener](https://github.com/ryanb/letter_opener).
This provides almost the same feature as the [letter_opener_web](https://github.com/fgrehm/letter_opener_web).
letter_opener_web is Rails based application. It's very useful.
But, I wanted a more simple.

## Installation

First add the gem to your development environment and run the bundle command to install it.

    gem 'letter_opener-web', :group => :development

## Rails Setup

Then set the delivery method in `config/environments/development.rb`

```ruby
  # If you will specify a message file location.
  # LetterOpener.location = Rails.root.join('tmp/letter_opener')
  config.action_mailer.delivery_method = :letter_opener
```

And mount app, add to your routes.rb

```ruby
Sample::Application.routes.draw do
  if Rails.env.development?
    mount LetterOpener::Web::Engine, at: "/inbox"
  end
end
```

## Padrino Setup

Then set the delivery method and mount app in `config/apps.rb`

```ruby
Padrino.configure_apps do
  # If you will specify a message file location.
  # LetterOpener.location = Padrino.root('tmp/letter_opener')
  set :delivery_method, LetterOpener::DeliveryMethod => {}
end

Padrino.mount('LetterOpener::Web::App').to('/inbox')
Padrino.mount('SampleProject::App', :app_file => Padrino.root('app/app.rb')).to('/')
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/letter_opener-web/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
