module Start
  class Charge

    def self.create(params={})
      Start.post(Start.api_url('charges/'), params)
    end

    def self.get(id)
      Start.get(Start.api_url('charges/' + id.to_s))
    end

    def self.all
      Start.get(Start.api_url('charges/'))
    end

  end
end
