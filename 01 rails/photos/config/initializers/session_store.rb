# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_awesome_session',
  :secret      => 'c10f8896719806505384077ad789795bbb6d48a0d3d697bb95dd6e49f73e22d7379ab262068999031bf6e71f01c22a22ffb0c03af6fde90fac932e27d14f4f55'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
