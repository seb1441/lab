ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

require 'bundler/setup' # Set up gems listed in the Gemfile.

# require 'rails/commands/server/server_command'
# require 'rails/commands/server'
# module Rails
#   class Server
#     def default_options
#       super.merge(Host:  '10.0.2.15', Port: 3000)
#     end
#   end
# end
