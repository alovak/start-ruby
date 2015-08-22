require "httparty"
require "start/base_resource"
require "start/customer"
require "start/charge"
require "start/errors/payfort_error"
require "start/errors/authentication_error"
require "start/errors/banking_error"
require "start/errors/request_error"
require "start/errors/processing_error"

module Start
  include HTTParty

  base_uri 'https://api.start.payfort.com'

  ssl_ca_file File.dirname(__FILE__) + '/data/ssl-bundle.crt'

  def self.api_key=(value)
    default_options[:basic_auth] = {username: value, password: ''}
  end
end
