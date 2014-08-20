Rails.application.routes.draw do
  root to: 'site#index'
  get '/:slug' => 'site#play'
end
