# frozen_string_literal: true

require_relative "payunit/version"
require 'json/pure'
require "base64"
require "launchy"
require "byebug"
require 'securerandom'
require "faraday"
require "faraday/net_http"
Faraday.default_adapter = :net_http

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
    auth_data = Base64.strict_encode64(auth)
    transaction_id = SecureRandom.uuid

    test_url = "https://app.payunit.net/api/gateway/initialize"

    headers = {
      "x-api-key": to_str(@api_key),
      "content-type": "application/json",
      "Authorization": "Basic #{to_str(auth_data)}",
      "mode": to_str(environment.downcase)
    }

    test_body = {
      "notify_url": to_str(@notify_url),
      "total_amount": to_str(amount),
      "return_url": to_str(@return_url),
      "currency": to_str(@currency),
      "transaction_id": to_str(transaction_id)
    }

    # You can uncomment the below parameters and add it to your test_body above

    # "purchaseRef": to_str(purchaseRef),
    #   "description": to_str(description),
    #   "name": to_str(name),

    begin
      conn = Faraday.new(
        url: "https://app.payunit.net/api/gateway/initialize",
        params: { param: "1" },
        headers: headers
      )
      response = conn.post(test_url, test_body.to_json, headers)
      
      # response = to_json(response.body)
      response = JSON.parse(response&.body || "{}")
      
      raise response["message"] unless response["statusCode"] == 200
      
      Launchy.open(response["data"]["transaction_url"])
      { "message": "Successfylly initated Transaction", "statusCode": response["statusCode"] }
      byebug
    rescue StandardError => e
      abort(response["message"])
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

api_key = "3456656ff1207e61b49fd1026739831d365022f1"
api_password = "bf871f50-3cc9-42df-a7d5-eac2536c7130"
api_username = "payunit_uWNwsqbl9"
return_url = "https://aproplat.com"
notify_url = "https://aproplat.com"
currency = "XAF"
mode = "live"

# api_key = ENV['API_KEY']
# api_password = ENV['API_PASSWORD']
# api_username = ENV['API_USERNAME']
# return_url = ENV['RETURN_URL']
# notify_url = ENV['NOTIFY_URL']
# currency = ENV['CURRENCY']
# mode = ENV['MODE']
# byebug
payment = PayUnit.new(api_key, api_username, api_password, return_url, notify_url, mode, currency)
payment.make_payment(500)