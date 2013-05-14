module Paperclip
  class Ffmpeg < Processor
    attr_accessor :geometry, :format, :whiny, :convert_options

    # Creates a Video object set to work on the +file+ given. It
    # will attempt to transcode the video into one defined by +target_geometry+
    # which is a "WxH"-style string. +format+ should be specified.
    # Video transcoding will raise no errors unless
    # +whiny+ is true (which it is, by default. If +convert_options+ is
    # set, the options will be appended to the convert command upon video transcoding.
    def initialize file, options = {}, attachment = nil
      @convert_options = {
        :input => {},
        :output => { :y => nil }
      }
      unless options[:convert_options].nil? || options[:convert_options].class != Hash
        unless options[:convert_options][:input].nil? || options[:convert_options][:input].class != Hash
          @convert_options[:input].reverse_merge! options[:convert_options][:input]
        end
        unless options[:convert_options][:output].nil? || options[:convert_options][:output].class != Hash
          @convert_options[:output].reverse_merge! options[:convert_options][:output]
        end
      end
      
      @streaming       = options[:streaming]
      @geometry        = options[:geometry]
      @file            = file
      @keep_aspect     = !@geometry.nil? && @geometry[-1,1] != '!'
      @pad_only        = @keep_aspect    && @geometry[-1,1] == '#'
      @enlarge_only    = @keep_aspect    && @geometry[-1,1] == '<'
      @shrink_only     = @keep_aspect    && @geometry[-1,1] == '>'
      @whiny           = options[:whiny].nil? ? true : options[:whiny]
      @format          = options[:format]
      @time            = options[:time].nil? ? 3 : options[:time]
      @current_format  = File.extname(@file.path)
      @basename        = File.basename(@file.path, @current_format)
      @meta            = identify
      @pad_color       = options[:pad_color].nil? ? "black" : options[:pad_color]
      attachment.instance_write(:meta, @meta)
    end
    # Performs the transcoding of the +file+ into a thumbnail/video. Returns the Tempfile
    # that contains the new image/video.
    def make
      Ffmpeg.log("Making...") if @whiny
      src = @file
      Ffmpeg.log("Building Destination File: '#{@basename}' + '#{@format}'") if @whiny
      dst = Tempfile.new([@basename, @format ? ".#{@format}" : ''])
      Ffmpeg.log("Destination File Built") if @whiny
      dst.binmode
      
      parameters = []

      Ffmpeg.log("Adding Geometry") if @whiny
      # Add geometry
      if @geometry
        Ffmpeg.log("Extracting Target Dimensions") if @whiny
        # Extract target dimensions
        if @geometry =~ /(\d*)x(\d*)/
          target_width = $1
          target_height = $2
        end
        # Only calculate target dimensions if we have current dimensions
        unless @meta[:size].nil?
          Ffmpeg.log("Target Size is Available") if @whiny
          current_width, current_height = @meta[:size].split('x')
          # Current width and height
          if @keep_aspect
            Ffmpeg.log("Keeping Aspect Ratio") if @whiny
            if @enlarge_only
              Ffmpeg.log("Enlarge Only") if @whiny
              if current_width.to_i < target_width.to_i
                # Keep aspect ratio
                width = target_width.to_i
                height = (width.to_f / (@meta[:aspect].to_f)).to_i
                @convert_options[:output][:s] = "#{width.to_i/2*2}x#{height.to_i/2*2}"
                Ffmpeg.log("Convert Options: #{@convert_options[:output][:s]}") if @whiny
              else
                Ffmpeg.log("Source is Larger than Destination, Doing Nothing") if @whiny
                #return nil
              end
            elsif @shrink_only
              Ffmpeg.log("Shrink Only") if @whiny
              if current_width.to_i > target_width.to_i
                # Keep aspect ratio
                width = target_width.to_i
                height = (width.to_f / (@meta[:aspect].to_f)).to_i
                @convert_options[:output][:s] = "#{width.to_i/2*2}x#{height.to_i/2*2}"
                Ffmpeg.log("Convert Options: #{@convert_options[:output][:s]}") if @whiny
              else
                Ffmpeg.log("Source is Smaller than Destination, Doing Nothing") if @whiny
                #return nil
              end
            elsif @pad_only
              Ffmpeg.log("Pad Only") if @whiny
              # Keep aspect ratio
              width = target_width.to_i
              height = (width.to_f / (@meta[:aspect].to_f)).to_i
              # We should add half the delta as a padding offset Y
              pad_y = (target_height.to_f - height.to_f) / 2
              # There could be options already set
              @convert_options[:output][:vf][/\A/] = ',' if @convert_options[:output][:vf]
              @convert_options[:output][:vf] ||= ''
              if pad_y > 0
                @convert_options[:output][:vf][/\A/] = "scale=#{width}:-1,pad=#{width.to_i}:#{target_height.to_i}:0:#{pad_y}:#@pad_color"
              else
                @convert_options[:output][:vf][/\A/] = "scale=#{width}:-1,crop=#{width.to_i}:#{height.to_i}"
              end
              Ffmpeg.log("Convert Options: #{@convert_options[:output][:s]}") if @whiny
            else
              Ffmpeg.log("Resize") if @whiny
              # Keep aspect ratio
              width = target_width.to_i
              height = (width.to_f / (@meta[:aspect].to_f)).to_i
              @convert_options[:output][:s] = "#{width.to_i/2*2}x#{height.to_i/2*2}"
              Ffmpeg.log("Convert Options: #{@convert_options[:output][:s]}") if @whiny
            end
          else
            Ffmpeg.log("Not Keeping Aspect Ratio") if @whiny
            # Do not keep aspect ratio
            @convert_options[:output][:s] = "#{target_width.to_i/2*2}x#{target_height.to_i/2*2}"
            Ffmpeg.log("Convert Options: #{@convert_options[:output][:s]}") if @whiny
          end
        end
      end

      Ffmpeg.log("Adding Format") if @whiny
      # Add format
      case @format
      when 'jpg', 'jpeg', 'png', 'gif' # Images
        @convert_options[:input][:ss] = @time
        @convert_options[:output][:vframes] = 1
        @convert_options[:output][:f] = 'image2'
      when 'webm', 'vp8' # WebM
        @convert_options[:output][:acodec] = 'libvorbis'
        @convert_options[:output][:vcodec] = 'libvpx'
        @convert_options[:output][:f] = 'webm'
      when 'ogv', 'theora' # Ogg Theora
        @convert_options[:output][:acodec] = 'libvorbis'
        @convert_options[:output][:vcodec] = 'libtheora'
        @convert_options[:output][:f] = 'ogg'
      when 'mp4', 'h264' # H-264
        @convert_options[:output][:acodec] = 'libfaac'
        @convert_options[:output][:vcodec] = 'libx264'
        @convert_options[:output][:f] = 'mp4'
      end
      
      if @streaming
        FFmpeg.log("Adding fast start for streaming") if @whiny
        @convert_options[:output][:movflags] = '+faststart'
      end

      Ffmpeg.log("Adding Source") if @whiny
      # Add source
      # Validations on the values. These could be either nil.
      parameters << @convert_options[:input].map { |k,v| "-#{k.to_s} #{v} " if !v.nil? && (v.is_a?(Numeric) || !v.empty?) }
      parameters << "-i :source"
      parameters << @convert_options[:output].map { |k,v| "-#{k.to_s} #{v} " if !v.nil? && (v.is_a?(Numeric) || !v.empty?) }
      parameters << "-y :dest"

      Ffmpeg.log("Building Parameters") if @whiny
      parameters = parameters.flatten.compact.join(" ").strip.squeeze(" ")

      Ffmpeg.log(parameters)
      begin
        success = Paperclip.run("ffmpeg", parameters, :source => "#{File.expand_path(src.path)}", :dest => File.expand_path(dst.path))
      rescue Cocaine::ExitStatusError => e
        raise Paperclip::Error, "error while processing video for #{@basename}: #{e}" if @whiny
      end

      dst
    end
    
    def identify
      meta = {}
      command = "ffmpeg -i \"#{File.expand_path(@file.path)}\" 2>&1"
      Paperclip.log("[ffmpeg] #{command}")
      ffmpeg = IO.popen(command)
      ffmpeg.each("\r") do |line|
        if line =~ /((\d*)\s.?)fps,/
          meta[:fps] = $1.to_i
        end
        # Matching lines like:
        # Video: h264, yuvj420p, 640x480 [PAR 72:72 DAR 4:3], 10301 kb/s, 30 fps, 30 tbr, 600 tbn, 600 tbc
        if line =~ /Video:(.*)/
          v = $1.to_s.split(',')
          size = v[2].strip!.split(' ').first
          meta[:size] = size.to_s
          meta[:aspect] = size.split('x').first.to_f / size.split('x').last.to_f
        end
        # Matching Duration: 00:01:31.66, start: 0.000000, bitrate: 10404 kb/s
        if line =~ /Duration:(\s.?(\d*):(\d*):(\d*\.\d*))/
          meta[:length] = $2.to_s + ":" + $3.to_s + ":" + $4.to_s
        end
      end
      Paperclip.log("[ffmpeg] Command Success") if @whiny
      meta
    end


    def self.log message
      Paperclip.log "[ffmpeg] #{message}"
    end
  end
  
  class Attachment
    def meta
      instance_read(:meta)
    end
  end
end