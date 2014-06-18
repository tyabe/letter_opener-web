require 'yaml'
module LetterOpener
  class DeliveryMethod
    class InvalidOption < StandardError; end

    attr_accessor :settings

    def initialize(options = {})
      raise InvalidOption, "A location option is required when using the Letter Opener delivery method" if LetterOpener.location.nil?
      self.settings = options
    end

    def deliver!(mail)
      location = File.join(LetterOpener.location, "#{Time.now.to_i}_#{Digest::SHA1.hexdigest(mail.encoded)[0..6]}")
      messages = Message.rendered_messages(location, mail)
      info = {}
      info[:subject] = mail.subject.to_s
      info[:to]      = mail.to.join(',')
      info[:from]    = mail.from.join(',')
      File.open(File.join(location, 'info.yml'), 'w') {|f| f.write YAML.dump(info) }
      messages
    end
  end
end
