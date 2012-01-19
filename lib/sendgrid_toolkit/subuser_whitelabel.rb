module SendgridToolkit
  module SubuserWhitelabel
    def retrieve_whitelabels
      options = { :task => 'list' }
      response = api_post('customer', 'whitelabel', options)
      response
    end
    
    def update_whitelabel(subuser, mail_domain)
      options = { :task => 'append', :user => subuser, :mail_domain => mail_domain }
      response = api_post('customer', 'whitelabel', options)
      response
    end
  end
end
