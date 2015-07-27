module SendgridToolkit
  module WhitelabelLinks
    def initialize(api_user = nil, api_key = nil)
      super
      @base_uri = BASE_URI_V3
    end
    
    def retrieve_whitelabel_links(options = {})
      api_get('whitelabel', 'links', options)
    end
    
    def create_whitelabel_link(domain, subdomain, default = false)
      api_post('whitelabel', 'links', {:domain => domain, :subdomain => subdomain, :default => default})
    end

    def update_whitelabel_link(id, default)
      api_patch('whitelabel', "links/#{id}", {:default => default})
    end

    def delete_whitelabel_link(id)
      api_delete('whitelabel', "links/#{id}")
    end

    def retrieve_whitelabel_link(id)
      api_get('whitelabel', "links/#{id}")
    end

    def retrieve_default_whitelabel_link(domain)
      api_get('whitelabel', "links/default", {:domain => domain})
    end

    def validate_whitelabel_link(link_id)
      api_post('whitelabel', "links/#{link_id}/validate")
    end

    def retrieve_whitelabel_link_associations(subuser_username)
      api_get('whitelabel', "links/subuser", {:username => subuser_username})
    end

    def add_whitelabel_link_association(link_id, subuser_username)
      api_post('whitelabel', "links/#{link_id}/subuser", {:username => subuser_username})
    end

    def remove_whitelabel_link_association(subuser_username)
      api_delete('whitelabel', "links/subuser", {:username => subuser_username})
    end
  end
end
