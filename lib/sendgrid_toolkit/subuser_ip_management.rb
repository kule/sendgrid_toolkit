module SendgridToolkit
  module SubuserIpManagement
    def retrieve_all_ips(list_type)
      #list_type => all, free, taken or available
      options = {:list => list_type}
      response = api_post('customer', 'ip', options)
      response
    end

    def retrieve_ips(subuser)
      options = {:user => subuser, :task => 'list'}
      response = api_post('customer', 'sendip', options)
      response
    end    

    def assign_ips(subuser, set_action, ips = [])
      #:set => none, all, specify
      #:ips => ['255.255.255.255', '1.2.3.4']
      options = {:task => 'append', :user => subuser, :set => set_action}
      ips = [ips] unless ips.is_a?(Array)
      options.merge!({ :ip => ips }) unless ips.empty?
      response = api_post('customer', 'sendip', options)
      response
    end
  end
end
