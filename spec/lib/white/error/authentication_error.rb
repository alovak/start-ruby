require_relative '../../../spec_helper'

describe Start::AuthenticationError do
  
  it "must be thown with an invalid key" do
    Start.api_key = "invalid"

    lambda {
      response = Start::Charge.create(
        :amount => 400,
        :currency => "usd",
        :card => {
          :number => "4242424242424242",
          :exp_month => 11,
          :exp_year => 2016,
          :cvc => 123
        },
        :description => "Charge for test@example.com"
      )
    }.must_raise Start::AuthenticationError
  end
end
