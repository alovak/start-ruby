module Payfort
  class Charge

    def self.create(params={})
      Payfort.post(Payfort.api_url('charges/'), params)
    end

    def self.get(id)
      Payfort.get(Payfort.api_url('charges/' + id.to_s))
    end

    def self.all
      Payfort.get(Payfort.api_url('charges/'))
    end

  end
end
