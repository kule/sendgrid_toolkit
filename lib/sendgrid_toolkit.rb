require 'httparty'

require 'sendgrid_toolkit/abstract_sendgrid_client'
require 'sendgrid_toolkit/common'
require 'sendgrid_toolkit/sendgrid_error'
require 'sendgrid_toolkit/statistics'
require 'sendgrid_toolkit/unsubscribes'
require 'sendgrid_toolkit/spam_reports'
require 'sendgrid_toolkit/bounces'
require 'sendgrid_toolkit/invalid_emails'
require 'sendgrid_toolkit/mail'
require 'sendgrid_toolkit/subuser_event_notification'
require 'sendgrid_toolkit/subuser_filters'
require 'sendgrid_toolkit/subuser_ip_management'
require 'sendgrid_toolkit/subuser_whitelabel'
require 'sendgrid_toolkit/subuser_management'
require 'sendgrid_toolkit/filters'
require 'sendgrid_toolkit/whitelabel_domains'
require 'sendgrid_toolkit/whitelabel_ips'
require 'sendgrid_toolkit/whitelabel_links'

module SendgridToolkit
  BASE_URI = "sendgrid.com/api"
  BASE_URI_V2 = "sendgrid.com/apiv2"
  BASE_URI_V3 = "api.sendgrid.com/v3"
end
