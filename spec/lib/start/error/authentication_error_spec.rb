require 'spec_helper'

describe Start::AuthenticationError do
  it "must be thown with an invalid key" do
    Start.api_key = "invalid"

    expect {
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
    }.to raise_error Start::AuthenticationError
  end
end
