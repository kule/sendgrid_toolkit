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

    def api_put(module_name, action_name, opts = {})
      make_request(:post, module_name, action_name, opts)
    end

    def api_patch(module_name, action_name, opts = {})
      make_request(:patch, module_name, action_name, opts)
    end

    def api_delete(module_name, action_name, opts = {})
      make_request(:delete, module_name, action_name, opts)
    end

    def get_credentials
      {:api_user => @api_user, :api_key => @api_key}
    end

    private

    def make_request(request_type, module_name, action_name, opts)
      response, url = get_response_and_url(request_type, module_name, action_name, opts)
      if response.code > 401
        raise(SendgridToolkit::SendgridServerError, "The sendgrid server returned an error. #{response.inspect}")
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

    def get_response_and_url(request_type, module_name, action_name, opts)
      if @base_uri == BASE_URI_V3
        make_v3_request(request_type, module_name, action_name, opts)
      else
        make_v2_request(request_type, module_name, action_name, opts)
      end
    end

    def make_v3_request(request_type, module_name, action_name, opts)
      url = "https://#{[@base_uri, module_name, action_name].compact.join('/')}"
      auth_token = Base64.encode64("#{@api_user}:#{@api_key}")
      if request_type == :get
        params = {:query => opts}
      else
        params = {:body => opts}
      end
      response = HTTParty.send(request_type, url, params.merge({ headers: {"Authorization"=>"Basic #{auth_token}" }, :format => :json }))
      return response, url
    end

    def make_v2_request(request_type, module_name, action_name, opts)
      url = "https://#{@base_uri}/#{module_name}.#{action_name}.json?"
      response = HTTParty.send(request_type, url, :query => get_credentials.merge(opts), :format => :json)
      return response, url
    end

    def has_error?(response)
      response.kind_of?(Hash) && response.has_key?('error')
    end
  end
end
