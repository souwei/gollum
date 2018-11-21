=begin
This file can be used to (e.g.):
- alter certain inner parts of Gollum,
- extend it with your stuff.

It is especially useful for customizing supported formats/markups. For more information and examples:
- https://github.com/gollum/gollum#config-file

=end

# enter your Ruby code here ...
require 'omnigollum'
require 'omniauth-azure-oauth2'

options = {
	:providers => Proc.new do
		provider :azure_oauth2, :client_id => ENV['az_client_id'], :client_secret => ENV['az_client_secret'], :tenant_id => ENV['az_tenant_id']
	end,
	:dummy_auth => false,
	:protected_routes => ['/*'],
	:author_format => Proc.new { |user| user.name },
	:author_email => Proc.new { |user| user.email },
	:authorized_users => ENV["wiki_users"].split(","),
}

Precious::App.set(:omnigollum, options)
Precious::App.register Omnigollum::Sinatra
