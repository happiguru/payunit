# Payunit

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/payunit`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add payunit

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install payunit

## Usage
Follow the instructions below to make payments locally:
- Create an account on `https://app.payunit.net/#/` to obtain your api_key, api_password, api_username 
- Add `gem 'payunit', '~> 0.1.0'` to your gemfile
- Add `gem 'dotenv-rails', '~> 2.8', '>= 2.8.1'` to your gemfile in order to save your secret credentials
- Make payments anywhere in your rails app by running the following
1. payment = PayUnit.new(api_key, api_username, api_password, return_url, notify_url, mode, currency)
2. payment.payment.make_payment(amount) amount is an integer gotten from the user


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/payunit. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/payunit/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Payunit project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/payunit/blob/main/CODE_OF_CONDUCT.md).
