Dir["./support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.order = "random"
end
