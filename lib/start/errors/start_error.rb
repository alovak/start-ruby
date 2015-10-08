module Start
  class StartError < StandardError
    attr_reader :message, :code, :http_status, :extras

    def initialize(message = nil, code = nil, http_status = nil, extras = {})
      @message = message
      @code = code
      @http_status = http_status
      @extras = extras
    end

    def to_s
      status_string = @http_status.nil? ? "" : "(#{@code}Error - Status #{@http_status}) "
      "#{status_string}#{@message}"
    end
  end
end
