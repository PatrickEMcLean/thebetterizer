Rails.application.config.middleware.use OmniAuth::Builder do
    provider :google_oauth2,
      '702939074249.apps.googleusercontent.com',
      'Srwm5mxiibMsldUo29QiKBav',
      {}
end
