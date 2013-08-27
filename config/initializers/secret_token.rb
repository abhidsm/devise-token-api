# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
DeviseTokenApi::Application.config.secret_key_base = '8c4a243738d709d896e1715e2d234f3971986d748cf263b4b2ae4cd7dffbed3bed1f863565cc3711665279bcfe657c383469be2d6c5947c9b2cc5321e3f29af5'
