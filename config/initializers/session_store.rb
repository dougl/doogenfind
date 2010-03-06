# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_doogenfind_session',
  :secret      => 'f75baa6b23e05635f84c751d36d3015a0ae554ffa22f409eb55aaac6613883bd220fc3f1b9b46a6842593829931f366e8f97fcd7b61e5f4e50cc8ea830fb4891'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
