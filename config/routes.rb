KalendarniPlan::Application.routes.draw do

  root :to => 'plan#index'
      match 'createuser'=> 'plan#createuser',:via => [:post]
      match 'createsession'=> 'plan#createsession',:via => [:post]
      match 'createtitle'=> 'plan#createtitle',:via => [:post]

  match 'cabinet' => 'plan#cabinet'
  match 'view' => 'plan#kp_view'
  match 'print'=> 'plan#kp_print'
    
  match 'title'=> 'plan#kp_titl'
    match 'save_title'=> 'plan#save_title'

  match 'lib'=> 'plan#kp_lit'
    match 'save_lib'=> 'plan#save_lib'

  match 'body'=> 'plan#kp_body'
  

  #get "plan/whoareyou"
  
end
