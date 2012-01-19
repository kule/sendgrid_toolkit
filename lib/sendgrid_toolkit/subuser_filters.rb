module SendgridToolkit
  module SubuserFilters
    def retrieve_filters(subuser)
      options = { :task => 'getavailable', :user => subuser }
      response = api_post('customer', 'apps', options)
      response
    end
    
    def enable_filter(subuser, filter_name)
      options = { :task => 'activate', :name => filter_name, :user => subuser }
      response = api_post('customer', 'apps', options)
      response
    end
    
    def disable_filter(subuser, filter_name)
      options = { :task => 'deactivate', :name => filter_name, :user => subuser }
      response = api_post('customer', 'apps', options)
      response
    end
    
    def update_filter_settings(subuser, filter_name, options = {})
      options.merge! :task => 'setup', :user => subuser, :name => filter_name
      response = api_post('customer', 'apps', options)
      response
    end
    
    def retrieve_filter_settings(subuser, filter_name)
      options = { :task => 'getsettings', :user => subuser, :name => filter_name }
      response = api_post('customer', 'apps', options)
      response
    end
  end
end
