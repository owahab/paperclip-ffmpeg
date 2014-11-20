class Video < ActiveRecord::Base

  has_attached_file :clip, :styles => {
    :medium => { :geometry => "640x480", :format => 'flv', :whiny => true, :convert_options => {:output => {:ar => 44100}} },
    :large => { :geometry => "1024x576", :format => 'flv', :whiny => true, :convert_options => {:output => {:ar => 44100}} }
  }, :processors => [:ffmpeg]
  validates_attachment_content_type :clip, content_type:['video/mp4','video/mpeg']

  has_attached_file :wrongClip, :styles => {
    :large => { :geometry => "1024x576", :format => 'flv', :whiny => true, :convert_options => {:output => {:ar => 3000}} }
  }, :processors => [:ffmpeg]
  validates_attachment_content_type :wrongClip, content_type:['video/mp4','video/mpeg']

  has_attached_file :portraitClip, :styles => {
    :jpg => { :geometry => "1024x576", :format => 'jpg', :whiny => true, :auto_rotate => 'portrait', :time => 0 },
    :medium => { :geometry => "640x480", :format => 'mp4', :whiny => true, :auto_rotate => 'portrait', :convert_options => {:output => {:ar => 44100}} },
    :large => { :geometry => "1024x576", :format => 'mp4', :whiny => true, :auto_rotate => 'portrait', :convert_options => {:output => {:ar => 44100}} }
  }, :processors => [:ffmpeg]
  validates_attachment_content_type :portraitClip, content_type:['video/mp4','video/mpeg']

  has_attached_file :landscapeClip, :styles => {
    :jpg => { :geometry => "1024x576", :format => 'jpg', :whiny => true, :auto_rotate => 'landscape', :time => 0 },
    :medium => { :geometry => "640x480", :format => 'mp4', :whiny => true, :auto_rotate => 'landscape', :convert_options => {:output => {:ar => 44100}} },
    :large => { :geometry => "1024x576", :format => 'mp4', :whiny => true, :auto_rotate => 'landscape', :convert_options => {:output => {:ar => 44100}} }
  }, :processors => [:ffmpeg]
  validates_attachment_content_type :landscapeClip, content_type:['video/mp4','video/mpeg']

  has_attached_file :exiftoolClip, :styles => {
    :large => { :geometry => "1024x576", :format => 'mp4', :whiny => true, :use_exiftool => true, :convert_options => {:output => {:ar => 44100}} }
  }, :processors => [:ffmpeg]
  validates_attachment_content_type :exiftoolClip, content_type:['video/mp4','video/mpeg']

  has_attached_file :exiftoolClipRotate, :styles => {
    :jpg => { :geometry => "1024x576", :format => 'jpg', :whiny => true, :use_exiftool => true, :auto_rotate => 'landscape', :time => 0 },
    :large => { :geometry => "1024x576", :format => 'mp4', :whiny => true, :use_exiftool => true, :auto_rotate => 'landscape', :convert_options => {:output => {:ar => 44100}} }
  }, :processors => [:ffmpeg]
  validates_attachment_content_type :exiftoolClipRotate, content_type:['video/mp4','video/mpeg']

  has_attached_file :clip_thumb_exceed, :styles => {
    :large => { :geometry => "1024x576", :format => 'flv', :whiny => true, :convert_options => {:output => {:ar => 44100}} },
    :thumb => { :geometry => "100x100#", :format => 'jpg', :time => 10}
  }, :processors => [:ffmpeg]
  validates_attachment_content_type :clip_thumb_exceed, content_type:['video/mp4','video/mpeg']

  has_attached_file :clip_thumb_normal, :styles => {
    :large => { :geometry => "1024x576", :format => 'flv', :whiny => true, :convert_options => {:output => {:ar => 44100}} },
    :thumb => { :geometry => "100x100#", :format => 'jpg', :time => 0}
  }, :processors => [:ffmpeg]
  validates_attachment_content_type :clip_thumb_normal, content_type:['video/mp4','video/mpeg']

  has_attached_file :clip_thumb_negative, :styles => {
  	:large => { :geometry => "1024x576", :format => 'flv', :whiny => true, :convert_options => {:output => {:ar => 44100}} },
    :thumb => { :geometry => "100x100#", :format => 'jpg', :time => -10}
  }, :processors => [:ffmpeg]
  validates_attachment_content_type :clip_thumb_negative, content_type:['video/mp4','video/mpeg']
  
  has_attached_file :clip_thumb_bad_extension, :styles => {
  	:large => { :geometry => "1024x576", :format => 'flv', :whiny => true, :convert_options => {:output => {:ar => 44100}} },
    :thumb => { :geometry => "100x100#", :format => 'foo', :time => 0}
  }, :processors => [:ffmpeg]
  validates_attachment_content_type :clip_thumb_bad_extension, content_type:['video/mp4','video/mpeg']

end

