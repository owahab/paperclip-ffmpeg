class AddThumbOptionsToVideo < ActiveRecord::Migration
  def change
  	add_attachment :videos, :clip_thumb_exceed
  	add_attachment :videos, :clip_thumb_normal
  	add_attachment :videos, :clip_thumb_negative
  	add_attachment :videos, :clip_thumb_bad_extension
  end
end
