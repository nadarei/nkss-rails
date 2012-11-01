Nkss::Engine.routes.draw do
   root :to => 'styleguides#all'
   get 'all' => 'styleguides#all'
   get ':section' => 'styleguides#show'
end
