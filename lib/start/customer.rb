module Start
  class Customer

    def self.create(params={})
      Start.post(Start.api_url('customers/'), params)
    end

    def self.get(id)
      Start.get(Start.api_url('customers/' + id.to_s))
    end

    def self.all
      Start.get(Start.api_url('customers/'))
    end

  end
end
