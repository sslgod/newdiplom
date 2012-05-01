KalendarniPlan::Application.routes.draw do

  root :to => 'plan#index'
  match 'cabinet' => 'plan#cabinet'
  match 'title'=> 'plan#kp_titl'
  match 'lib'=> 'plan#kp_lit'
  match 'body'=> 'plan#kp_body'
  match 'print'=> 'plan#kp_print'
  match 'createuser'=> 'plan#createuser',:via => [:post]
  match 'createsession'=> 'plan#createsession',:via => [:post]
  match 'createtitle'=> 'plan#createtitle',:via => [:post]

  #get "plan/whoareyou"
  
end
