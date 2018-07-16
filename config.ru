require 'rack'
require 'pp'

class SimpleApp
  def call(env)
    request = Rack::Request.new(env)
    body = <<-EOB
Name: #{request.params['name']}
Your Client: #{request.user_agent}
    EOB
    return [200, {'Content-Type' => 'text/plain'}, [body]]
  end
end

run SimpleApp.new
