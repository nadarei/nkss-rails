Nkss::Engine.routes.draw do
   root :to => 'styleguides#index'
   get 'all' => 'styleguides#all'
   get '/:section' => 'styleguides#show'
   get '/plain_file::file' => 'styleguides#plain_file', file: /.*/
   get '/compiled_file::file' => 'styleguides#compiled_file', file: /.*/
end
