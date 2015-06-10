require 'execjs'
require 'react/jsx/template'
require 'react/jsx/transformer'
require 'rails'

module React
  module JSX
    mattr_accessor :transform_options, :transformer_class

    # You can assign `React::JSX.transformer_class = `
    # to provide your own transformer. It must implement:
    # - #initialize(options)
    # - #transform(code) => new code
    self.transformer_class = Transformer

    def self.transform(code)
      # slim = code.match( /<slim>(.*)<\/slim>/m )

      code = code.gsub( /<slim>(.*)<\/slim>/m ) {|slim| 
        Slim::Template.new { slim }.render
      }

      
      
      transformer.transform(code)
    end

    def self.transformer
      # lazily loaded during first request and reloaded every time when in dev or test
      if @transformer.nil? || !::Rails.env.production?
        @transformer = transformer_class.new(transform_options)
      end
      @transformer
    end
  end
end
