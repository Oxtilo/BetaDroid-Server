require 'dotenv'
Dotenv.load

CarrierWave.root = File.join(Padrino.root, "public")

Padrino.configure_apps do
  # enable :sessions
  set :session_secret, 'b397492754b9bee95eab89b7768fd5bce61f1fbaf33f7279683562ab89644c68'
  set :protection, true
  set :protect_from_csrf, true
end

# Mounts the core application for this project
Padrino.mount('BetaDroid::App', :app_file => Padrino.root('app/app.rb')).to('/')
