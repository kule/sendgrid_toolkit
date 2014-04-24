module SendgridToolkit
  class Filters < AbstractSendgridClient
    def retrieve
      response = api_get('filter', 'getavailable')
      response
    end

    def retrieve_settings(app_name)
      options = {:name => app_name}
      response = api_get('filter', 'getsettings', options)
      response
    end

    def activate(app_name)
      options = {:name => app_name}
      response = api_post('filter', 'activate', options)
      response
    end

    def deactivate(app_name)
      options = {:name => app_name}
      response = api_post('filter', 'deactivate', options)
      response
    end

    def setup(app_name, options = {})
      options = options.merge({:name => app_name})
      response = api_post('filter', 'setup', options)
      response
    end

    def setup_address_whitelist(list = [])
      options = {:name => 'addresswhitelist', :list => list}
      response = api_post('filter', 'setup', options)
      response
    end

    def setup_bcc(bcc)
      options = {:name => 'bcc', :bcc => bcc}
      response = api_post('filter', 'setup', options)
      response
    end

    def setup_click_tracking(enable_text)
      enable_text = convert_bool(enable_text)
      options = {:name => 'clicktrack', :enable_text => enable_text}
      response = api_post('filter', 'setup', options)
      response
    end

    def setup_domain_keys(domain, sender)
      sender = convert_bool(sender)
      options = {:name => 'domainkeys', :domain => domain, :sender => sender}
      response = api_post('filter', 'setup', options)
      response
    end

    def setup_dkim(domain, use_from)
      use_from = convert_bool(use_from)
      options = {:name => 'dkim', :domain => domain, :use_from => use_from}
      response = api_post('filter', 'setup', options)
      response
    end

    def setup_email_template(text_html)
      options = {:name => 'template', :text_html => text_html}
      response = api_post('filter', 'setup', options)
      response
    end

    def setup_event_notification(url, version, events = {})
      options = {:name => 'eventnotify', :url => url, :version => version}

      options[:processed]   = convert_bool(events[:processed])   if event.has_key?(:processed)
      options[:dropped]     = convert_bool(events[:dropped])     if event.has_key?(:dropped)
      options[:deferred]    = convert_bool(events[:deferred])    if event.has_key?(:deferred)
      options[:delivered]   = convert_bool(events[:delivered])   if event.has_key?(:delivered)
      options[:bounce]      = convert_bool(events[:bounce])      if event.has_key?(:bounce)
      options[:click]       = convert_bool(events[:click])       if event.has_key?(:click)
      options[:open]        = convert_bool(events[:open])        if event.has_key?(:open)
      options[:unsubscribe] = convert_bool(events[:unsubscribe]) if event.has_key?(:unsubscribe)
      options[:spamreport]  = convert_bool(events[:spamreport])  if event.has_key?(:spamreport)

      response = api_post('filter', 'setup', options)
      response
    end

    def setup_footer(text_html, text_plain)
      options = {:name => 'footer', :"text/html" => text_html, :"text/plain" => text_plain}
      response = api_post('filter', 'setup', options)
      response
    end

    def setup_google_analytics(options = {})
      # utm_source, utm_medium, utm_campaign, utm_term, utm_content
      options = options.merge({:name => 'ganalytics'})
      response = api_post('filter', 'setup', options)
      response
    end

    def setup_spam_filter(max_score, url)
      options = {:name => 'spamcheck', :maxscore => max_score, :url => url}
      response = api_post('filter', 'setup', options)
      response
    end

    def setup_subscription_tracking(options = {})
      # text/html, text/plain, url, landing, replace
      options = options.merge({:name => 'subscriptiontrack'})
      response = api_post('filter', 'setup', options)
      response
    end

    def setup_new_relic(license_key, enable_subusers)
      options = { 
        :name => 'newrelic', 
        :license_key => license_key, 
        :enable_subusers => convert_bool(enable_subusers)
      }
      response = api_post('filter', 'setup', options)
      response
    end

    protected

    def convert_bool(bool)
      if bool == true || bool.to_i == 1
        bool = 1
      else
        bool = 0
      end
    end
  end
end

