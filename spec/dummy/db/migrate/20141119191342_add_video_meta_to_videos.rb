class AddVideoMetaToVideos < ActiveRecord::Migration
  def change
    add_attachment :videos, :portraitClip
    add_attachment :videos, :landscapeClip
  	add_column :videos, :portraitClip_meta, :hstore
  	add_column :videos, :landscapeClip_meta, :hstore
  end
end