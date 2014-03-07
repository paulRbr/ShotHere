# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
Shothere::Application.config.secret_token = ENV['SECRET_TOKEN'] || 'eb80e1d571f1ac4fbd002095f93dd000959685529285cf967afd34b28f487e02de71533a06435422538a5cebdbdb278af8965c66f1a9c2ad7c87f2cf5c9e2a65'
Shothere::Application.config.secret_key_base = ENV['SECRET_KEY_BASE'] || '9525f51f1b25fcd54727870fbb86abc761105f4699b91713f1bd29890398489c6ff36569254ee3197f82b68cd3c7ceafd3bce49955eac7da467176d6f4edc7d9'
