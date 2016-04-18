require "httparty"
require "start/base_resource"
require "start/version"
require "start/customer"
require "start/charge"
require "start/token"
require "start/errors/start_error"
require "start/errors/authentication_error"
require "start/errors/banking_error"
require "start/errors/request_error"
require "start/errors/processing_error"

module Start
  include HTTParty

  base_uri 'https://api.start.payfort.com'

  ssl_ca_file File.dirname(__FILE__) + '/data/ssl-bundle.crt'

  headers 'User-Agent' => "Start/Ruby/#{Start::VERSION}"

  def self.api_key=(value)
    default_options[:basic_auth] = {username: value, password: ''}
  end
end
