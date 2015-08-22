module Start
  class BaseResource
    class << self
      attr_accessor :path

      def create(params = {})
        handle_response Start.post(path, body: params)
      end

      def get(id)
        handle_response Start.post("#{path}/#{id}")
      end

      def all
        handle_response Start.get(path)
      end

      private

      def handle_response(response)
        body = JSON.parse(response.body);

        if response.code.between?(200, 299) and !body.key?('error')
          # The request was successful
          return body
        end

        # There was an error .. check the response
        case body['error']['type']
        when 'banking'
          raise Start::BankingError.new(body['error']['message'], body['error']['code'], response.code)

        when 'authentication'
          raise Start::AuthenticationError.new(body['error']['message'], body['error']['code'], response.code)

        when 'processing'
          raise Start::ProcessingError.new(body['error']['message'], body['error']['code'], response.code)

        when 'request'
          raise Start::RequestError.new(body['error']['message'], body['error']['code'], response.code)
        end

        # Otherwise, raise a General error
        raise Start::StartError.new(body['error']['message'], body['error']['code'], response.code)
      end
    end
  end
end
