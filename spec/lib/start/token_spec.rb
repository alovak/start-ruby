require 'spec_helper'

describe Start::Token do
  before do
    Start.api_key = "test_open_k_d93727030f5ae0e5ff73"
  end

  it "must create a new token" do
    response = Start::Token.create(
      :number => "4242424242424242",
      :exp_month => 11,
      :exp_year => 2016,
      :cvc => 123
    )

    expect(response['id']).to start_with('tok_')
  end

  context 'when name is passed is passed' do
    it "must create a new token with card object has name" do
      response = Start::Token.create(
        :number => "4242424242424242",
        :exp_month => 11,
        :exp_year => 2016,
        :cvc => 123,
        :name => "Abdullah Mohammed"
      )

      expect(response['card']['name']).to eq('Abdullah Mohammed')
    end
  end
end