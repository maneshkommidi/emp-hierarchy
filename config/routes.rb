Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
  	namespace :v1 do
  		post "create_employee", to: "employees#create"
  		get "employee_hierarchy", to: "employees#emp_hierarchy"
  		get "top_paid_emps", to: "employees#top_paid_emps"
  		delete "destory_emp", to: "employees#destory"
  	end
  end
end
