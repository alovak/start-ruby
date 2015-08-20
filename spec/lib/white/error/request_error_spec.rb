require_relative '../../../spec_helper'

describe Start::RequestError do

  # Negative amounts don't raise an error -- TODO: FIX
  #  
  # it "must be thown with invalid_request_error" do
  #   Start.api_key = "test_sec_k_25dd497d7e657bb761ad6"

  #   lambda {
  #     response = Start::Charge.create(
  #       :amount => -1,
  #       :currency => "usd",
  #       :card => {
  #         :number => "4242424242424242",
  #         :exp_month => 11,
  #         :exp_year => 2016,
  #         :cvc => 123
  #       },
  #       :description => "Charge for test@example.com"
  #     )
  #   }.must_raise Start::RequestError
  # end

  it "must be thrown with invalid_cvc" do
    Start.api_key = "test_sec_k_25dd497d7e657bb761ad6"

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
      e.code.must_equal 'unprocessable_entity'
      e.http_status.must_equal 422
    end
  end

  it "must be thown with expired_card" do
    Start.api_key = "test_sec_k_25dd497d7e657bb761ad6"

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
      e.code.must_equal 'unprocessable_entity'
      e.http_status.must_equal 422
    end
  end

  it "must be thown with invalid_number" do
    Start.api_key = "test_sec_k_25dd497d7e657bb761ad6"

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
      e.code.must_equal 'unprocessable_entity'
      e.http_status.must_equal 422
    end
  end

  it "must be thown with invalid_expiry_month" do
    Start.api_key = "test_sec_k_25dd497d7e657bb761ad6"

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
      e.code.must_equal 'unprocessable_entity'
      e.http_status.must_equal 422
    end
  end

  it "must be thown with invalid_expiry_year" do
    Start.api_key = "test_sec_k_25dd497d7e657bb761ad6"

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
      e.code.must_equal 'unprocessable_entity'
      e.http_status.must_equal 422
    end
  end
end
