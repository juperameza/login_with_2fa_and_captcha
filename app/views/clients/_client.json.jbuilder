json.extract! client, :id, :name, :birthdate, :membership, :emergency_cname, :emergency_cphone, :created_at, :updated_at
json.url client_url(client, format: :json)
