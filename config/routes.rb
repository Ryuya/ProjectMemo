Rails.application.routes.draw do
  get 'main/index'

  root :to => 'main#index'
  get 'main/top'
  get 'main/index', as: :top

  post 'main/create_project_category'
  post 'main/create_question_category'


  #Project
  # get 'projects', to: 'projects#index', as: :projects
  #formを作る時にはnew
  # get 'projects/new', to: 'projects#new', as: :new_project
  # post 'projects', to: 'projects#create'
  # get 'projects/:id', to: 'projects#show', as: :project
  # delete 'projects/:id', to:  'projects#destroy'
  # get 'projects/:id/edit', to: 'projects#edit', as: :edit_project
  # patch 'projects/:id', to: 'projects#update'

  #レストフル restful rails
  #リソースフル  rails
  resources :projects ,except: [:index,:new]

  #Question
  # post 'questions', to: 'questions#create',as: :questions
  # get 'questions/:id', to: 'questions#show', as: :question
  # get 'questions/:id/edit', to: 'questions#edit', as: :edit_question
  # patch 'questions/:id', to: 'questions#update'
  # delete 'questions/:id', to:  'questions#destroy'
  resources :questions ,except: [:index,:new] do
    #単数
    member do
      patch 'resolute'
    end
    #集合体
    # collection do
    #   get 'abc'
    # end
  end

  # get 'main/candidateurl/:id', to:  'main#candidateurl_show', as: :candidateurl
  # get 'main/candidateurl_edit/:id',to: 'main#candidateurl_edit',as: :candidateurl_edit
  # patch 'main/candidateurl_edit/:id',to: 'main#candidateurl_update',as: :candidateurl_update
  # delete 'main/candidateurl/:id', to: 'main#candidateurl_destroy'
  # post 'main/create_candidateurl'
  resources :candidateurls ,except: [:index,:new]

  #既にあるモデルをいじる場合はpostではなくpatchになる
  #patch 'main/resolution_update/:question_id', to: 'main#resolution_update', as: :resolute_question

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
