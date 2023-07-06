class AlbumAttachment < ApplicationRecord
  mount_uploader :img_url, AlbumUploader
  belongs_to :album
end
