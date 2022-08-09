# Payunit

This gem was developed to aid Cameroon businesses to make both national and international payments using MTN and Orange Mobile Money, Paypal, Credit Card and Express Union.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add payunit

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install payunit

## Usage

- You need to pass in the following parameters to initialize a payment
```
api_key = ENV['API_KEY']
api_password = ENV['API_PASSWORD']
api_username = ENV['API_USERNAME']
return_url = ENV['RETURN_URL']
notify_url = ENV['NOTIFY_URL']
currency = ENV['CURRENCY']
mode = ENV['MODE']

```

- Create a PayUnit Class and call the payment method
```payment = PayUnit.new(api_key, api_username, api_password, return_url, notify_url, mode, currency)```

- Next is ```payment.make_payment(amount)```

- The above code will open a payment url that will be used to make the payment

### ✒️ Authors

👤 **Stanley Enow Lekunze**

- Github: [@happiguru](https://github.com/happiguru)
- LinkedIn:[LinkedIn](https://www.linkedin.com/in/lekunze-nley)

👤 **CHE NSOH BLANCHARD**

- GitHub: [@che30](https://github.com/che30)
- Twitter: [@BlanchardNsoh](https://twitter.com/che55085128 )
- LinkedIn: [Che Blanchard](https://www.linkedin.com/in/che-nsoh-9455271b0/)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[happiguru]/payunit. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[happiguru]/payunit/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Payunit project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/payunit/blob/main/CODE_OF_CONDUCT.md).
