module Start
  class BaseResource
    class << self
      attr_accessor :path

      def create(params = {})
        handle_response Start.post(path, body: params)
      end

      def get(id)
        handle_response Start.get("#{path}/#{id}")
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

        exception_class = if ['banking', 'authentication', 'processing', 'request'].include?(body['error']['type'])
                            Object.const_get "Start::#{body['error']['type'].capitalize}Error"
                          else
                            StartError
                          end

        raise exception_class.new(body['error']['message'], body['error']['code'], response.code, body['error']['extras'])
      end
    end
  end
end
