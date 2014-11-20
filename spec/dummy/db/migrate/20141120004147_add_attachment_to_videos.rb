class AddAttachmentToVideos < ActiveRecord::Migration
  def change
    add_attachment :videos, :exiftoolClip
    add_attachment :videos, :exiftoolClipRotate
  	add_column :videos, :exiftoolClip_meta, :hstore
  	add_column :videos, :exiftoolClipRotate_meta, :hstore
  end
end
