module SendgridToolkit
  class Subusers < AbstractSendgridClient
    
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
    
    def enable(options = {})
      response = api_post('customer', 'enable', options)
      response
    end
    
    def disable(options = {})
      response = api_post('customer', 'disable', options)
      response
    end
    
    def update(options = {})
      options.merge! :task => 'set'
      response = api_post('customer', 'profile', options)
      response
    end
    
    def update_password(options = {})
      response = api_post('customer', 'password', options)
      response
    end
    
    def update_username(options = {})
      options.merge! :task => 'setUsername'
      response = api_post('customer', 'profile', options)
      response
    end
    
    def update_email(options = {})
      options.merge! :task => 'setEmail'
      response = api_post('customer', 'profile', options)
      response
    end
    
    def recurring_reset(options = {})
      options.merge! :task => 'recurring'
      response = api_post('customer', 'profile', options)
      response
    end
  end
end
