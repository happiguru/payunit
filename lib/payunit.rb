# frozen_string_literal: true

require_relative "payunit/version"
require "base64"
require "httpx"
require "launchy"

class PayUnit
  def initialize(api_key, api_username, api_password, return_url, notify_url, mode, currency)
    @api_key = api_key
    @api_username = api_username
    @api_password = api_password
    @return_url = return_url
    @notify_url = notify_url
    @mode = mode
    @currency = currency

    check
  end

  def make_payment(amount)
    return "Invalid transaction amount" if amount <= 0

    auth = "#{@api_username}:#{@api_password}"
    environment = to_str(@mode)
    auth_data = Base64.encode64(Base64.encode64(auth))
    plain = Base64.decode64(auth_data)

    test_url = "https://app.payunit.net/api/gateway/initialize"

    headers = {
      "x-api-key": to_str(@api_key),
      "content-type": "application/json",
      "Authorization": "Basic #{to_str(plain)}",
      "mode": to_str(environment.downcase)
    }

    test_body = {
      "notify_url": to_str(@notify_url),
      "total_amount": to_str(amount),
      "return_url": to_str(@return_url),
      "purchaseRef": to_str(purchaseRef),
      "description": to_str(description),
      "name": to_str(name),
      "currency": to_str(@currency),
      "transaction_id": to_str(transaction_id)
    }

    begin
      response = HTTPX.post(
        test_url, test_body.to_json, headers: headers
      )
      response = response.to_json

      if response.statusCode == 200
        Launchy.open(response["data"]["transaction_url"])
        { "message": "Successfylly initated Transaction", "statusCode": response["statusCode"] }
      else
        raise response["message"]
      end
    rescue StandardError => e
      abort(response["statusCode"], response["message"])
    end
  end

  private

  def to_str(xata)
    xata.to_s
  end

  def check
    raise "api_key not present" if @api_key.empty?

    raise "apiUsername not present" if @api_username.empty?

    raise "apiPassword not present" if @api_password.empty?

    raise "return url not present" if @return_url.empty?

    raise "notification url not present" if @notify_url.empty?

    raise "Current not yet set." if @currency.empty?

    raise "sdk mode not present" if @mode.empty?

    raise "Invalid sdk mode" if @mode.downcase != "test" && @mode.downcase != "live"
  end
end
api_key = "payunit_uWNwsqbl9"
api_password = "3456656ff1207e61b49fd1026739831d365022f1"
api_username = "apiUser"
return_url = "returnUrl"
notify_url = "notifyUrl"
currency = "currency"
mode = "test"

payment = PayUnit.new(api_key, api_username, api_password, return_url, notify_url, mode, currency)
payment.make_payment(500)
puts payment
