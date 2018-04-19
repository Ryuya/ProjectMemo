Rails.application.routes.draw do
  get 'main/index'

  root :to => 'main#index'
  get 'main/top'
  get 'main/index', as: :top
  get 'main/index/project/:id', to: 'main#project_show', as: :project
  get 'main/index/question/:id', to:  'main#question_show', as: :question


  delete 'main/index/project/:id', to:  'main#project_destroy'
  delete 'main/index/question/:id', to:  'main#question_destroy'
  delete 'main/candidateurl/:id', to: 'main#candidateurl_destroy'

  post 'main/create_project'
  post 'main/create_project_category'
  post 'main/create_question_category'
  post 'main/create_question'
  post 'main/create_candidateurl'


  get 'main/project_edit/:id', to: 'main#project_edit', as: :project_edit
  post 'main/project_edit/:id', to: 'main#project_update'

  get 'main/question_edit/:id', to: 'main#question_edit', as: :question_edit
  post 'main/question_edit/:id', to: 'main#question_update'



  get 'main/candidateurl/:id', to:  'main#candidateurl_show', as: :candidateurl
  get 'main/candidateurl_edit/:id',to: 'main#candidateurl_edit',as: :candidateurl_edit
  patch 'main/candidateurl_edit/:id',to: 'main#candidateurl_update',as: :candidateurl_update



  #既にあるモデルをいじる場合はpostではなくpatchになる
  patch 'main/resolution_update'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
