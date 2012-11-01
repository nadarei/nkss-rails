Nkss::Engine.routes.draw do
   root :to => 'styleguides#index'
   get 'all' => 'styleguides#all'
   get ':section' => 'styleguides#show'
end
