Rails.application.config.middleware.use OmniAuth::Builder do
    provider :google_oauth2,
      '257923061099.apps.googleusercontent.com',
      'avGwP5aNDnrlVUK7U1OWaG4m',
      {}
end
