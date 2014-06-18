class Video < ActiveRecord::Base

	has_attached_file :clip, :styles => {
    :medium => { :geometry => "640x480", :format => 'flv', :convert_options => {:output => {:ar => 44100}} },
    :large => { :geometry => "1024x576", :format => 'flv', :convert_options => {:output => {:ar => 44100}} }
  }, :processors => [:ffmpeg]
  validates_attachment_content_type :clip, content_type:['video/mp4','video/mpeg']

  has_attached_file :wrongClip, :styles => {
    :large => { :geometry => "1024x576", :format => 'flv', :convert_options => {:output => {:ar => 3000}} }
  }, :processors => [:ffmpeg]
  validates_attachment_content_type :wrongClip, content_type:['video/mp4','video/mpeg']

  has_attached_file :clip_thumb_exceed, :styles => {
    :large => { :geometry => "1024x576", :format => 'flv', :convert_options => {:output => {:ar => 44100}} },
    :thumb => { :geometry => "100x100#", :format => 'jpg', :time => 10}
  }, :processors => [:ffmpeg]
  validates_attachment_content_type :clip_thumb_exceed, content_type:['video/mp4','video/mpeg']

  has_attached_file :clip_thumb_normal, :styles => {
    :large => { :geometry => "1024x576", :format => 'flv', :convert_options => {:output => {:ar => 44100}} },
    :thumb => { :geometry => "100x100#", :format => 'jpg', :time => 0}
  }, :processors => [:ffmpeg]
  validates_attachment_content_type :clip_thumb_normal, content_type:['video/mp4','video/mpeg']

  has_attached_file :clip_thumb_negative, :styles => {
  	:large => { :geometry => "1024x576", :format => 'flv', :convert_options => {:output => {:ar => 44100}} },
    :thumb => { :geometry => "100x100#", :format => 'jpg', :time => -10}
  }, :processors => [:ffmpeg]
  validates_attachment_content_type :clip_thumb_negative, content_type:['video/mp4','video/mpeg']
  
  has_attached_file :clip_thumb_bad_extension, :styles => {
  	:large => { :geometry => "1024x576", :format => 'flv', :convert_options => {:output => {:ar => 44100}} },
    :thumb => { :geometry => "100x100#", :format => 'foo', :time => 0}
  }, :processors => [:ffmpeg]
  validates_attachment_content_type :clip_thumb_bad_extension, content_type:['video/mp4','video/mpeg']
end

