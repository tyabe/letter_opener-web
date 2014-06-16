require 'yaml'
module LetterOpener
  module Web
    class Message

      class << self

        def location
          LetterOpener.location
        end

        def load_all
          Dir.glob("#{location}/*").map { |f|
            new :id => File.basename(f), :sent_at => File.mtime(f)
          }.sort_by(&:sent_at).reverse
        end

        def find(id)
          new :id => id
        end

        def bulk_delete(ids)
          ids.to_a.each do |id|
            message_path = File.join(location, id)
            FileUtils.rm_rf(message_path) if File.exist?(message_path)
          end
        end

      end

      attr_reader :id, :sent_at, :info

      def initialize(args={})
        @id       = args.fetch(:id)
        @sent_at  = args[:sent_at] # optional
        info = File.join(base_dir, 'info.yml')
        @info     = File.exist?(info) ?  YAML.load_file(info) : {}
      end

      def render(format=nil)
        type = :plain if format.nil?
        type = :rich  if format.to_s == 'html'
        raise ArgumentError if type.nil?
        message_file = File.join(base_dir, "#{type}.html")
        raise ArgumentError unless File.exist?(message_file)
        File.read(message_file)
      end

      def attachments
        @attachments ||= Dir["#{base_dir}/attachments/*"].each_with_object({}) do |file, hash|
          hash[File.basename(file)] = File.expand_path(file)
        end
      end

      private

      def base_dir
        "#{self.class.location}/#{id}"
      end

    end
  end
end
