Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :auth0,
    'W4qiIkJ8wpr1GAgUBqWLV29I08Pb1cgs',
    'tsT4vjkKJ8iubKH_-kh3tCrZ9CqfpAA3WjRz6GShJdqMqxgBKGLuuloigqtjlO8g',
    'scala.au.auth0.com',
    callback_path: '/auth/oauth2/callback',
    authorize_params: {
      scope: 'openid profile'
    }
  )
end