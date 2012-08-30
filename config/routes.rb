Nkss::Engine.routes.draw do
   root :to => 'styleguides#index'
   get ':section' => 'styleguides#show'
end
