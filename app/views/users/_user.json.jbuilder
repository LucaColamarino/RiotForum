json.extract! user, :id, :title, :rating, :description, :release_date, :created_at, :updated_at
json.url user_url(user, format: :json)
