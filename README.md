![alt tag](http://url/to/img.png)
## Brocat doesn't give a shit about your web framework

## Installation

Add this line to your application's Gemfile:

    gem 'brocat'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install brocat

## Usage

THE MOST BADASS DSL FOR MAKING WEB APPS

IF YOU MAKE A FILE CALLED, FOR EXAMPLE `sup.rb` WITH THIS STUFF IN IT:

```ruby
require 'brocat'

root { "Sup" } # http://localhost:1234/

api do
  get(:sup) { "Whatup" }
  delete(:sup) { "Damnit" }

  namespace :cats do
    get { "Sup here too" } # http://localhost:1234/api/cats

    namespace :brocat do
      get { "Yeah I have my own URL" } # http://localhost:1234/api/cats/brocat
    end
  end

end
```

THEN RUN: `ruby sup.rb`

YOU WILL WIN

## Contributing

1. Fork it ( http://github.com/thejchap/brocat/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
