Rails.application.routes.draw do

  

  devise_for :student_users, :skip => [:sessions], :controllers => { :registrations => 'student_registrations'}

  as :student_user do
    get 'signin' => 'devise/sessions#new', :as => :new_student_user_session
    post 'signin' => 'devise/sessions#create', :as => :student_user_session
    delete 'signout' => 'devise/sessions#destroy', :as => :destroy_student_user_session
  end

  # get 'studentportal/index'

  # get 'studentportal/show'

  # devise_for :admin_users
  devise_for :admin_users, :controllers => { :registrations => 'registrations'}, :skip => [:sessions]

  as :admin_user do
    get 'adminsignin' => 'devise/sessions#new', :as => :new_admin_user_session
    post 'adminsignin' => 'devise/sessions#create', :as => :admin_user_session
    delete 'adminsignout' => 'devise/sessions#destroy', :as => :destroy_admin_user_session
  end
  
  get 'contact/new'
  get 'contact/create'

  # get 'onboard', :to => "pages#onboard", :as => "onboard"
  # put "onboard", :to => "pages#onboard_send"

  match 'onboard' =>  "pages#onboard", :via => :get
  match 'onboard' => 'pages#onboard_send', :via => :post

  get 'studentportal', :to => "studentportal#index", :as => "portal"
  get 'coming_soon', :to => "studentportal#done", :as => "coming_soon"
  get 'next_page', :to => "studentportal#next_page", :as => "next_page"
  get 'portal/:permalink', :to => "studentportal#show"

  # resources :lessons
  # resources :sections
  #get 'pages/dashboard'
  

  match 'enroll' =>  "pages#enroll", :via => :get, as: "enroll"
  match 'enroll' => 'pages#create', :via => :post
  match 'homee' =>  "pages#home", :via => :get, as: "homee"


  match ":controller(/:action(/:id))", :via => [:get, :post]
  

  
  root "pages#index"

  mount Ckeditor::Engine => '/ckeditor'
  

  #admin Routes
  get 'pages/dashboard'

  get 'admin/content', to: "admmin#content", as: "admin"

  post 'admin/section_sort', to: "admin#section_sort", as: "sort_sections"
  post 'admin/lesson_sort', to: "admin#lesson_sort", as: "sort_lessons"

  get 'admin/settings'
  get 'admin/section_show/:id', to: "admin#section_show", as: "showsection"
  get 'admin/section_edit/:id', to: "admin#section_edit", as: "editsection"
  delete "admin/section_destroy/:id", to: "admin#section_destroy", as: "destroysection"
  delete "admin/lesson_destroy/:id", to: "admin#lesson_destroy", as: "destroylesson"


  
end
