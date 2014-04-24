module SendgridToolkit
  class AbstractSendgridClient

    def initialize(api_user = nil, api_key = nil)
      @base_uri = BASE_URI
      
      @api_user = (api_user.nil?) ? ENV['SMTP_USERNAME'] : api_user
      @api_key = (api_key.nil?) ? ENV['SMTP_PASSWORD'] : api_key

      raise SendgridToolkit::NoAPIUserSpecified if @api_user.nil? || @api_user.length == 0
      raise SendgridToolkit::NoAPIKeySpecified if @api_key.nil? || @api_key.length == 0
    end

    protected

    def api_get(module_name, action_name, opts = {})
      make_request(:get, module_name, action_name, opts)
    end

    def api_post(module_name, action_name, opts = {})
      make_request(:post, module_name, action_name, opts)
    end

    def get_credentials
      {:api_user => @api_user, :api_key => @api_key}
    end

    private

    def make_request(request_type, module_name, action_name, opts)
      url = "https://#{@base_uri}/#{module_name}.#{action_name}.json?"
      if request_type == :get
        response = HTTParty.get(url, :query => get_credentials.merge(opts), :format => :json)
      else
        response = HTTParty.post(url, :query => get_credentials.merge(opts), :format => :json)
      end
      if response.code > 401
        raise(SendgridToolkit::SendgridServerError, "The sengrid server returned an error. #{response.inspect}")
      elsif has_error?(response) and
          response['error'].respond_to?(:has_key?) and
          response['error'].has_key?('code') and
          response['error']['code'].to_i == 401
        raise SendgridToolkit::AuthenticationFailed
      elsif has_error?(response)
        puts url + get_credentials.merge(opts).map{|k,v| "#{k}=#{v}"}.join('&')
        raise(SendgridToolkit::APIError, response['error'])
      end
      response
    end

    def has_error?(response)
      response.kind_of?(Hash) && response.has_key?('error')
    end
  end
end
