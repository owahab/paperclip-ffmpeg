module Paperclip
  class Qtfaststart < Processor
    attr_accessor :streaming, :format, :whiny

    # Creates a Video object set to work on the +file+ given. It
    # will attempt to reposition the moov atom in the video given
    # if +streaming+ is set.
    def initialize file, options = {}, attachment = nil
      @streaming      = options[:streaming]
      @file            = file
      @whiny           = options[:whiny].nil? ? true : options[:whiny]
      @format          = options[:format]
      @current_format  = File.extname(@file.path)
      @basename        = File.basename(@file.path, @current_format)
      attachment.instance_write(:meta, @meta)
    end

    # Performs the atom repositioning on +file+.
    # Returns the Tempfile that contains the new video or the original
    # file if +streaming+ wasn't set.
    def make
      return @file unless @streaming

      src = @file
      dst = Tempfile.new([@basename, @format ? ".#{@format}" : ''])
      dst.binmode

      parameters = []
      # Add source
      parameters << ":source"
      # Add destination
      parameters << ":dest"

      parameters = parameters.flatten.compact.join(" ").strip.squeeze(" ")

      Paperclip.log("[qtfaststart] #{parameters}")
      begin
        success = Paperclip.run("qtfaststart", parameters, :source => "#{File.expand_path(src.path)}", :dest => File.expand_path(dst.path))
      rescue Cocaine::ExitStatusError => e
        raise PaperclipError, "error while processing video for #{@basename}: #{e}" if @whiny
      end

      dst
    end
  end
end
