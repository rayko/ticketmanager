# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_ticket-manager_session',
  :secret      => '041026b56550dcb899a4cc388c84a0200cdd5715f210da861bde45134f1458f1c97d86d25580e87db84ac4bcc9d3faf8955f22cfae2cb719781d79f715e0e02b'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
