![Cat](http://feedbackloop-assets.s3.amazonaws.com/Screen%20Shot%202014-06-11%20at%204.19.03%20PM.png)

## BROCAT DOESN'T GIVE A SHIT ABOUT YOUR WEB FRAMEWORK


## Installation

Add this line to your application's Gemfile:

    gem 'brocat', github: "thejchap/brocat"

And then execute:

    $ bundle

## Usage

THE MOST BADASS DSL FOR MAKING WEB APPS

IF YOU MAKE A FILE CALLED, FOR EXAMPLE `sup.rb` WITH THIS STUFF IN IT:

```ruby
require 'rubygems'
require 'bundler/setup'
require 'brocat'

root { "Sup" }                                      # http://localhost:1234

get(:wat) do                                        # The only templating engine you'll ever need (localhost:1234/wat)
  title = "Wat"
  sub_title = "SubWat"
  
  <<-EOS
    <html>
      <head><title>#{title}</title></title>
      <body>
        <h1>#{title}</h1>
        <h2>#{sub_title}</h1>
      </body>
    </html>
  EOS
end

api do                                              # Content-Type: application/json

  namespace :v1 do
    get(:sup) { "Whatup" }                          # http://localhost:1234/api/v1/sup
    delete(:sup) { "Damnit" }                       # DELETE http://localhost:1234/api/v1/sup

    namespace :cats do
      get(:all) { "Sup here too" }                  # http://localhost:1234/api/v1/cats/all

      namespace :bro do
        get(:cat) { "Yeah I have my own URL" }      # http://localhost:1234/api/v1/cats/bro/cat
      
        post :wat do                                # POST http://localhost:1234/api/v1/cats/bro/wat
          BroCat = Class.new
        
          BroCat.to_s.split("o")
          .drop(1).reverse.join('_')
          .concat(BroCat.to_s.split("C")[0])
        end
      end
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
