module FlightStats
  class API
    require 'flightstats/api/errors'
    require 'flightstats/resource'

    @@base_uri = "https://api.flightstats.com"

    class << self
      # Additional HTTP headers sent with each API call
      # @return [Hash{String => String}]
      def headers
        @headers ||= { 'Accept' => accept, 'User-Agent' => user_agent }
      end

      # @return [String, nil] Accept-Language header value
      def accept_language
        headers['Accept-Language']
      end

      # @param [String] language Accept-Language header value
      def accept_language=(language)
        headers['Accept-Language'] = language
      end

      # @return [Net::HTTPOK, Net::HTTPResponse]
      # @raise [ResponseError] With a non-2xx status code.
      def head uri, params = {}, options = {}
        request :head, uri, { :params => params }.merge(options)
      end

      # @return [Net::HTTPOK, Net::HTTPResponse]
      # @raise [ResponseError] With a non-2xx status code.
      def get uri, params = {}, options = {}
        request :get, uri, { :params => params }.merge(options)
      end

      # @return [Net::HTTPCreated, Net::HTTPResponse]
      # @raise [ResponseError] With a non-2xx status code.
      def post uri, body = nil, options = {}
        request :post, uri, { :body => body.to_s }.merge(options)
      end

      # @return [Net::HTTPOK, Net::HTTPResponse]
      # @raise [ResponseError] With a non-2xx status code.
      def put uri, body = nil, options = {}
        request :put, uri, { :body => body.to_s }.merge(options)
      end

      # @return [Net::HTTPNoContent, Net::HTTPResponse]
      # @raise [ResponseError] With a non-2xx status code.
      def delete uri, options = {}
        request :delete, uri, options
      end

      # @return [URI::Generic]
      def base_uri
        URI.parse @@base_uri
      end

      # @return [String]
      def user_agent
        "FlightStats/#{FlightStats::Version}; #{RUBY_DESCRIPTION}"
      end

      private

      def accept
        'application/json'
      end
      alias content_type accept
    end
  end
end
