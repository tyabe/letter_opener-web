require 'letter_opener'
require_relative 'delivery_method'
require 'letter_opener/web/app'
module LetterOpener

  class << self
    def location
      @location ||= Rails.root.join('tmp/letter_opener')  if defined? Rails
      @location ||= Padrino.root('tmp/letter_opener')     if defined? Padrino
      @location
    end

    def location=(path)
      @location = path
    end
  end

  module Web
  end
end
