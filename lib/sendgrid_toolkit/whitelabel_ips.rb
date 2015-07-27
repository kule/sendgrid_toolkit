module SendgridToolkit
  class WhitelabelIps < AbstractSendgridClient
    def initialize(api_user = nil, api_key = nil)
      super
      @base_uri = BASE_URI_V3
    end

    def retrieve_whitelabel_ips(options = {})
      api_get('whitelabel', 'ips', options)
    end
    
    def create_whitelabel_ip(ip, domain, subdomain)
      api_post('whitelabel', 'ips', {:ip => ip, :domain => domain, :subdomain => subdomain})
    end

    def delete_whitelabel_ip(id)
      api_delete('whitelabel', "ips/#{id}")
    end

    def retrieve_whitelabel_ip(id)
      api_get('whitelabel', "ips/#{id}")
    end
  end
end
