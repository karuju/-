json.extract! user, :id, :name, :email, :image, :introduction, :sex, :birthday, :created_at, :updated_at
json.url user_url(user, format: :json)
