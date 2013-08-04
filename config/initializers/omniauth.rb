Rails.application.config.middleware.use OmniAuth::Builder do
    provider :google_oauth2,
      '960016567704.apps.googleusercontent.com',
      'BcRZQhFqzsKvootw-cH_VECA',
      {}
end
