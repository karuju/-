# config/initializers/rest-client.rb
RestClient.log = Object.new.tap do |proxy|
  def proxy.<<(message)
    Rails.logger.info message
  end
end
