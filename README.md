# Full-stack Rails


- create a Rails app on my Desktop
- $ rails new app_name -d postgresql -T
- $ cd app_name
- accepted the GHCR assignment
- from the front page of the GHCR repo: `git remote add origin https://github.com/learn-academy-2021-echo/full-stack-rails-sarah-and-austin.git`
- checked out main branch
- $ git checkout -b main
- add, initial commit, and push
- $ rails db:create

MVC - model, view, controller  
Display info from the db and present to the user

Herb Garden App
- $ rails g model Herb name:string watered:string
- $ rails db:migrate

Put some data in the db
- $ rails c
- Herb.create name: 'Basil', watered: 'yes'
- Herb.create name: 'Mint', watered: 'no'
- Herb.create name: 'Cilantro', watered: 'yes'
- Herb.all - returned an array of db instances (hashes)

Create a controller
- $ rails g controller Herb


**CRUD: READ**

INDEX
- controller method
```
def index
  # instance variable that holds an active record query to get all the herbs
  @herbs = Herb.all
end
```
- route `get '/herbs' => 'herb#index'`
- view
```
<h1>Herb Garden</h1>
<ul>
  <% @herbs.each do |herb| %>
    <li>
      <%= herb.name %>
    </li>
  <% end %>
</ul>
```

SHOW
- controller method
```
def show
  @herb = Herb.find(params[:id])
end
```
- route `get '/herbs/:id' => 'herb#show'`
- view
```
<h2>Individual Herb</h2>
<p>Name: <%= @herb.name %></p>
<p>Is watered? <%= @herb.watered %></p>
```

Navigation
- route aliases
```
get '/herbs' => 'herb#index', as: 'herbs'
get '/herbs/:id' => 'herb#show', as: 'herb'
```
- nav link in the index
```
<%= link_to herb.name, herb_path(herb) %>
```
- nav link in the show
```
<p><%= link_to 'Back to All Herbs', herbs_path %></p>
```


**CRUD: CREATE**

NEW
- controller method
```
def new
  @herb = Herb.new
end
```
- route `get '/herbs/new' => 'herb#new', as: 'new_herb'`
- view
```
<h2>Create a New Herb</h2>
<%= form_with model: @herb do |form| %>
  <%= form.label :name %>
  <%= form.text_field :name %>
  <br>
  <br>
  <%= form.label :watered %>
  <%= form.text_field :watered %>
  <br>
  <br>
  <%= form.submit 'Add Herb'%>
<% end %>
<br>
<p><%= link_to 'Back to All Herbs', herbs_path %></p>
```
- Form docs: https://guides.rubyonrails.org/form_helpers.html#dealing-with-model-objects

CREATE
- controller method
```
def create
  @herb = Herb.create(herb_params)
  if @herb.valid?
    redirect_to herbs_path
  else
    redirect_to new_herb_path
  end
end
private
def herb_params
  params.require(:herb).permit(:name, :watered)
end
```
- route `post '/herbs' => 'herb#create'`
- view - added redirect in the controller method


**CRUD: UPDATE**

EDIT
- controller method
```
def edit
  @herb = Herb.find(params[:id])
end
```
- route `get '/herbs/:id/edit' => 'herb#edit', as: 'edit_herb'`
- view

UPDATE
- controller method
```
def update
  @herb = Herb.find(params[:id])
  @herb.update(herb_params)
  if @herb.valid?
    redirect_to herb_path(@herb)
  else
    redirect_to edit_herb_path(@herb)
  end
end
```
- route `patch 'herbs/:id' => 'herb#update'`
- view - add redirect in the controller method
