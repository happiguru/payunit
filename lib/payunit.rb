# frozen_string_literal: true

# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/AbcSize
require_relative "payunit/version"
require "json/pure"
require "base64"
require "launchy"
require 'net/http'
require 'byebug'
require 'uri'
require "securerandom"
require "faraday"
require "faraday/net_http"
Faraday.default_adapter = :net_http

# Payunit payment class
class PayUnit
  def initialize(api_key, api_username, api_password, return_url, notify_url, mode, currency)
    @api_key = api_key
    @api_username = api_username
    @api_password = api_password
    @return_url = return_url
    @notify_url = notify_url
    @mode = mode
    @currency = currency

    check_api_key
    check_api_username
    check_api_password
    check_api_mode
    check_currency
    check_return_url
    check_notify_url
    check_api_sdk
  end

  def make_payment(amount, purchase_ref = nil, description = nil, name = nil)
    return "Invalid transaction amount" if amount <= 0

    @purchase_ref = purchase_ref
    @description = description
    @name = name
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
      "purchaseRef": to_str(@purchase_ref),
      "description": to_str(@description),
      "name": to_str(@name),
      "currency": to_str(@currency),
      "transaction_id": to_str(transaction_id)
    }

    begin
      conn = Faraday.new(
        url: "https://app.payunit.net/api/gateway/initialize",
        params: { param: "1" },
        headers: headers
      )
      response = conn.post(test_url, test_body.to_json, headers)

      response = JSON.parse(response&.body || "{}")

      raise response["message"] unless response["statusCode"] == 200

      # Launchy.open(response["data"]["transaction_url"])
      # {
      #   "message": "Successfylly initated Transaction",
      #   "statusCode": response["statusCode"]
      # }
      
      # byebug
      # puts response
      return response
    

    rescue StandardError
      abort(response["message"])
    end
  end

  private

  def to_str(xata)
    xata.to_s
  end

  def check_api_key
    raise "api_key not present" if @api_key.empty?
  end

  def check_api_username
    raise "apiUsername not present" if @api_username.empty?
  end

  def check_api_password
    raise "apiPassword not present" if @api_password.empty?
  end

  def check_return_url
    raise "return url not present" if @return_url.empty?
  end

  def check_notify_url
    rraise "notification url not present" if @notify_url.empty?
  end

  def check_currency
    raise "Current not yet set." if @currency.empty?
  end

  def check_api_mode
    raise "sdk mode not present" if @mode.empty?
  end

  def check_api_sdk
    raise "Invalid sdk mode" if @mode.downcase != "test" && @mode.downcase != "live"
  end
end
# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/AbcSize


api_key = "3456656ff1207e61b49fd1026739831d365022f1"
api_password = "bf871f50-3cc9-42df-a7d5-eac2536c7130"
api_username = "payunit_uWNwsqbl9"
return_url = "https://aproplat.com"
notify_url = "https://aproplat.com"
currency = "XAF"
mode = "live"


payment = PayUnit.new(api_key, api_username, api_password, return_url, notify_url, mode, currency)
payment.make_payment(500)

