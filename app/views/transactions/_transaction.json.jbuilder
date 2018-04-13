json.extract! transaction, :id, :date, :user, :description, :price, :category, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
