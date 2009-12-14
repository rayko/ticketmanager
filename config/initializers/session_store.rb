# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_ticketmanager_session',
  :secret      => '0c3095901be7b532d7ec242c46670c9cfae4e2fc5dadfed50ec6e4a9cf1d518f0e15ddd7a8ad5dd35827473a235571989bab9ba4c3f63780b910684722650c6c'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
