module SendgridToolkit
  class SubuserManagement < AbstractSendgridClient
    include SendgridToolkit::SubuserEventNotification
    include SendgridToolkit::SubuserWhitelabel
    include SendgridToolkit::SubuserIpManagement
    include SendgridToolkit::SubuserFilters

    def initialize(api_user = nil, api_key = nil)
      super
      @base_uri = BASE_URI_V2
    end

    def retrieve(options = {})
      options.merge! :task => 'get'
      response = api_post('customer', 'profile', options)
      response
    end

    def create(options = {})
      response = api_post('customer', 'add', options)
      response
    end

    def enable(subuser)
      response = api_post('customer', 'enable', {:user => subuser})
      response
    end

    def disable(subuser)
      response = api_post('customer', 'disable', {:user => subuser})
      response
    end

    def enable_website_access(subuser)
      response = api_post('customer', 'website_enable', {:user => subuser})
      response
    end

    def disable_website_access(subuser)
      response = api_post('customer', 'website_disable', {:user => subuser})
      response
    end

    def update(subuser, options = {})
      options.merge! :task => 'set', :user => subuser
      response = api_post('customer', 'profile', options)
      response
    end

    def update_password(subuser, password)
      options = {:user => subuser, :password => password, :confirm_password => password}
      response = api_post('customer', 'password', options)
      response
    end

    def update_username(subuser, new_username)
      options = {:task => 'setUsername', :user => subuser, :username => new_username}
      response = api_post('customer', 'profile', options)
      response
    end

    def update_email(subuser, new_email)
      options = {:task => 'setEmail', :user => subuser, :email => new_email}
      response = api_post('customer', 'profile', options)
      response
    end
  end
end
