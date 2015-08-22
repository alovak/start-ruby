require 'spec_helper'

describe Start::BankingError do
  it "must be thown with card_declined" do
    Start.api_key = "test_sec_k_2b99b969196bece8fa7fd"

    begin
      response = Start::Charge.create(
        :amount => 400,
        :currency => "usd",
        :email => "abdullah@msn.com",
        :card => {
          :name => "Abdullah Ahmed",
          :number => "4000000000000002",
          :exp_month => 11,
          :exp_year => 2016,
          :cvc => 123
        },
        :description => "Charge for test@example.com"
      )
    rescue Start::BankingError => e
      expect(e.code).to eq('card_declined')
      expect(e.http_status).to eq(402)
    end
  end
end
