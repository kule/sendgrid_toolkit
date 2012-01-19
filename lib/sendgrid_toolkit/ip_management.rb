module SendgridToolkit
  class IpManagement < AbstractSendgridClient
    
    def initialize(api_user = nil, api_key = nil)
      super
      @base_uri = BASE_URI_V2
    end
    
    def retrieve(list_type)
      #list_type => all, free, taken or available
      options = {:list => list_type}
      response = api_post('customer', 'ip', options)
      response
    end

    def retrieve_for_subuser(subuser)
      options = {:user => subuser, :task => 'list'}
      response = api_post('customer', 'sendip', options)
      response
    end    

    def assign_to_subuser(subuser, set_action, ips = [])
      #:set => none, all, specify
      #:ips => ['255.255.255.255', '1.2.3.4']
      options = {:task => 'append', :user => subuser, :set => set_action}
      options.merge!({ :"ip" => ips }) unless ips.empty?
      response = api_post('customer', 'sendip', options)
      response
    end
  end
end
