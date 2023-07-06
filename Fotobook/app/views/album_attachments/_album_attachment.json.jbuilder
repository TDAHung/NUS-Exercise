json.extract! album_attachment, :id, :album_id, :img_url, :created_at, :updated_at
json.url album_attachment_url(album_attachment, format: :json)
