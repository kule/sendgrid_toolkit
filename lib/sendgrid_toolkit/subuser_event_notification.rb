module SendgridToolkit
  module SubuserEventNotification
    def retrieve_event_notification_url(subuser)
      options = {:task => 'get', :user => subuser}
      response = api_post('customer', 'eventposturl', options)
      response
    end

    def update_event_notification_url(subuser, url)
      options = {:task => 'set', :user => subuser, :url => url}
      response = api_post('customer', 'eventposturl', options)
      response
    end

    def delete_event_notification_url(subuser)
      options = {:task => 'delete', :user => subuser}
      response = api_post('customer', 'eventposturl', options)
      response
    end
  end
end

