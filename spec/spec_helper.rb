Dir["./support/**/*.rb"].each { |f| require f }

unless defined?(Rails)
  module Rails
    class Application
      def self.parent_name; "urchin_tracking_module" end
    end
    def self.application; Application.new end
  end
end

RSpec.configure do |config|
  config.order = "random"
end
