module SendgridToolkit
  module Subusers
    def initialize(api_user = nil, api_key = nil)
      super
      @base_uri = BASE_URI_V3
    end

    def retrieve_subusers(options = {})
      api_get('subusers', nil, options)
    end
    
    def create_subuser(username, email, password, ips = [])
      api_post('subusers', 'domains', {:username => username, :email => email, :password => password, :ips => ips})
    end

    def enable_subuser(username)
      api_patch('subusers', username, {:disabled => false})
    end

    def disable_subuser(username)
      api_patch('subusers', username, {:disabled => true})
    end

    def delete_subuser(username)
      api_delete('subusers', username)
    end

    def retrieve_subuser_moniter_settings(username)
      api_get('subusers', "#{username}/monitor")
    end

    def create_subuser_monitor_settings(username, email, frequency)
      api_post('subusers', "#{username}/monitor", {:email => email, :frequency => frequency})
    end

    def update_subuser_monitor_settings(username, email, frequency)
      api_patch('subusers', "#{username}/monitor", {:email => email, :frequency => frequency})
    end

    def remove_subuser_monitor_settings(username)
      api_delete('subusers', "#{username}/monitor")
    end

    def retrieve_subuser_reputations(usernames)
      api_get('subusers', 'reputations', {:usernames => usernames})
    end

    def update_subuser_assigned_ips(username, ips)
      api_put('subusers', "#{username}/ips", ips)
    end
  end
end
