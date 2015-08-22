require 'spec_helper'

describe Start::Customer do
  before do
    Start.api_key = "test_sec_k_2b99b969196bece8fa7fd"
  end

  it "must create a new customer" do
    response = Start::Customer.create(
      :name => "Abdullah Ahmed",
      :email => "abdullah@msn.com",
      :card => {
        :number => "4242424242424242",
        :exp_month => 11,
        :exp_year => 2016,
        :cvc => 123
      },
      :description => "Signed up at the Trade Show in Dec 2014"
    )

    expect(response['name']).to eq("Abdullah Ahmed")
  end

  it "must list created customers" do
    response = Start::Customer.all()

    expect(response).to_not be_empty
  end
end
