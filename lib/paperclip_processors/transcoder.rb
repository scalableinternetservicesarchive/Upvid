module Paperclip
  class Transcoder < Processor

    attr_accessor :whiny
    def initialize(file, options = {}, attachment = nil)
      super
      @whiny = options[:whiny].nil? ? true : options[:whiny]
      @basename = File.basename(file.path, File.extname(file.path))
    end

    def make
      dst = Tempfile.new([ @basename, 'flv' ].compact.join("."))
      dst.binmode
      cmd = %Q[-i #{File.expand_path(file.path)} -ar 22050 -crf 28 #{File.expand_path(dst.path) + ".flv"} ]
      puts cmd
      begin
        success = Paperclip.run('ffmpeg', cmd)
      rescue PaperclipCommandLineError
        raise PaperclipError, "There was an error processing the thumbnail for #{@basename}" if whiny
      end
      dst
    end
  end
end