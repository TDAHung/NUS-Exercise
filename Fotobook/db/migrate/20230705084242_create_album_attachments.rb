class CreateAlbumAttachments < ActiveRecord::Migration[7.0]
  def change
    create_table :album_attachments do |t|
      t.references :album, foreign_key: true
      t.string :img_url

      t.timestamps
    end
  end
end
