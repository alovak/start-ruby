require_relative '../../spec_helper'

describe Start::Charge do
  before do
    Start.api_key = "test_sec_k_2b99b969196bece8fa7fd"
  end

  it "must create a new charge" do
    response = Start::Charge.create(
      :amount => 400,
      :currency => "usd",
      :email => "ahmed@example.com",
      :card => {
        :name => "Abdullah Ahmed",
        :number => "4242424242424242",
        :exp_month => 11,
        :exp_year => 2016,
        :cvc => 123
      },
      :description => "Charge for test@example.com"
    )

    expect(response['captured_amount']).to eq(400)
  end

   it "must list created charges" do
    response = Start::Charge.all()

    expect(response).to_not be_empty
   end
end
