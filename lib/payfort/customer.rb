module Payfort
  class Customer

    def self.create(params={})
      Payfort.post(Payfort.api_url('customers/'), params)
    end

    def self.get(id)
      Payfort.get(Payfort.api_url('customers/' + id.to_s))
    end

    def self.all
      Payfort.get(Payfort.api_url('customers/'))
    end

  end
end
