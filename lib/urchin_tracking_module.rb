require 'urchin_tracking_module/version'
require 'singleton'
require 'active_support/core_ext/hash/slice'

def UTM(url, params={})
  UrchinTrackingModule.new(url).tracking(params)
end

class UrchinTrackingModule
  TRACKING_PARAMETERS = %i(utm_source utm_medium utm_term utm_content utm_campaign)

  def initialize(url)
    @url = url
  end

  def tracking(params=defaults)
    filtered_params(params).inject(@url) do |url,(name,value)|
      url = add_param(url, "#{name}", value)
      url = add_param(url, "src", value) if name == :utm_source
      url
    end
  end

  def defaults
    Utm::Defaults.config
  end
  private :defaults

  def filtered_params(params)
    defaults.merge(params.slice(*TRACKING_PARAMETERS))
  end
  private :filtered_params

  def add_param(url, param_name, param_value)
    uri = URI(url)
    params = url_params(uri).merge(param_name => param_value)
    uri.query = URI.encode_www_form(params)
    uri.to_s
  end
  private :add_param

  def url_params(uri)
    # conversion to hash e.g. to get rid of duplicate src params
    params = URI.decode_www_form(uri.query || [])
    params.inject(Hash.new) { |h,(k,v)| h.merge(k => v) }
  end
  private :url_params

  def self.configure(&block)
    Defaults.configure(&block)
  end

  def self.source
    Defaults.config[:utm_source]
  end

  def self.medium
    Defaults.config[:utm_medium]
  end

  class Defaults
    include Singleton
    attr_accessor :defaults

    def self.configure(&block)
      instance.configure(&block)
    end

    def self.config
      instance.defaults
    end

    def initialize
      self.defaults = { utm_source: default_source, utm_medium: default_medium  }
    end

    def configure
      yield self.defaults
    end

    def default_source
      Rails.application.class.parent_name
    end
    private :default_source

    def default_medium
      'mail'
    end
    private :default_medium
  end
end
