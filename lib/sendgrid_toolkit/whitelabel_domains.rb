module SendgridToolkit
  module WhitelabelDomains
    def initialize(api_user = nil, api_key = nil)
      super
      @base_uri = BASE_URI_V3
    end

    def retrieve_whitelabel_domains(options = {})
      api_get('whitelabel', 'domains', options)
    end
    
    def create_whitelabel_domain(domain, subdomain, options = {})
      options = options.merge(:domain => domain, :subdomain => subdomain)
      api_post('whitelabel', 'domains', options)
    end

    def update_whitelabel_domain(id, options = {})
      api_patch('whitelabel', "domains/#{id}", options)
    end

    def delete_whitelabel_domain(id)
      api_delete('whitelabel', "domains/#{id}")
    end

    def retrieve_whitelabel_domain(id)
      api_get('whitelabel', "domains/#{id}")
    end

    def retrieve_default_whitelabel_domain(domain)
      api_get('whitelabel', "domains/default", {:domain => domain})
    end

    def add_ip_to_whitelabel_domain(domain_id, ip)
      api_post('whitelabel', "domains/#{domain_id}/ips", {:ip => ip})
    end

    def remove_ip_to_whitelabel_domain(domain_id, ip)
      api_delete('whitelabel', "domains/#{domain_id}/ips", {:ip => ip})
    end

    def validate_whitelabel_domain(domain_id)
      api_post('whitelabel', "domains/#{domain_id}/validate")
    end

    def retrieve_whitelabel_domain_associations(subuser_username)
      api_get('whitelabel', "domains/subuser", {:username => subuser_username})
    end

    def add_whitelabel_domain_association(domain_id, subuser_username)
      api_post('whitelabel', "domains/#{domain_id}/subuser", {:username => subuser_username})
    end

    def remove_whitelabel_domain_association(subuser_username)
      api_delete('whitelabel', "domains/subuser", {:username => subuser_username})
    end
  end
end
