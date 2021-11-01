# MLClient : simple predictions with google cloud functions

This gem allows interaction within ruby code with various APIs hosted in google cloud functions. It is primarly designed to predict results of machine learning models and works synchronously (for light predictions) or asynchronously (for heavier predictions).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ml_client'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install ml_client

## Usage

After installing the gem, complete the file in  `config/initializers/ml_client.rb` with required `api_url` and `api_bearer` for authentication.

Here is what the file should look like :

```ruby
MLClient.configure do |config|
  config.api_url = 'https://api.com/'
  config.api_bearer = 'fake_bearer'
end
```

Two methods are available (as of 01/11/2021) :

- `MLClient.predict(model_name, params)` which returns synchronously the result of the model with the corresponding model_name.
- `MLClient.predict_async(model_name, params, webhook_url)` which returns asynchronously the result of the model. It requires a webhook url on which the response will be sent.

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Flatlooker/ml_client.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
