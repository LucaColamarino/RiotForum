json.extract! notifica, :id, :from, :to, :content, :read, :created_at, :updated_at
json.url notifica_url(notifica, format: :json)
