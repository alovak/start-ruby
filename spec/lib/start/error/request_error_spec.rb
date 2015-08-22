require 'spec_helper'

describe Start::RequestError do
  before do
    Start.api_key = "test_sec_k_2b99b969196bece8fa7fd"
  end

  it "must be thrown with invalid_cvc" do
    begin
      response = Start::Charge.create(
        :amount => 400,
        :currency => "usd",
        :card => {
          :number => "4242424242424242",
          :exp_month => 11,
          :exp_year => 2016,
          :cvc => "abc"
        },
        :description => "Charge for test@example.com"
      )
    rescue Start::RequestError => e
      expect(e.code).to eq('unprocessable_entity')
      expect(e.http_status).to eq(422)
    end
  end

  it "must be thown with expired_card" do
    begin
      response = Start::Charge.create(
        :amount => 400,
        :currency => "usd",
        :card => {
          :number => "4242424242424242",
          :exp_month => 11,
          :exp_year => 1999,
          :cvc => 123
        },
        :description => "Charge for test@example.com"
      )
    rescue Start::RequestError => e
      expect(e.code).to eq('unprocessable_entity')
      expect(e.http_status).to eq(422)
    end
  end

  it "must be thown with invalid_number" do
    begin
      response = Start::Charge.create(
        :amount => 400,
        :currency => "usd",
        :card => {
          :number => "1234123412341234",
          :exp_month => 11,
          :exp_year => 2016,
          :cvc => 123
        },
        :description => "Charge for test@example.com"
      )
    rescue Start::RequestError => e
      expect(e.code).to eq('unprocessable_entity')
      expect(e.http_status).to eq(422)
    end
  end

  it "must be thown with invalid_expiry_month" do
    begin
      response = Start::Charge.create(
        :amount => 400,
        :currency => "usd",
        :card => {
          :number => "4242424242424242",
          :exp_month => 15,
          :exp_year => 2016,
          :cvc => 123
        },
        :description => "Charge for test@example.com"
      )
    rescue Start::RequestError => e
      expect(e.code).to eq('unprocessable_entity')
      expect(e.http_status).to eq(422)
    end
  end

  it "must be thown with invalid_expiry_year" do
    begin
      response = Start::Charge.create(
        :amount => 400,
        :currency => "usd",
        :card => {
          :number => "4242424242424242",
          :exp_month => 12,
          :exp_year => "abcd",
          :cvc => 123
        },
        :description => "Charge for test@example.com"
      )
    rescue Start::RequestError => e
      expect(e.code).to eq('unprocessable_entity')
      expect(e.http_status).to eq(422)
    end
  end
end
