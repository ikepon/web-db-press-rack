require 'rack'
require 'pp'

class SimpleApp
  def call(env)
    request = Rack::Request.new(env)
    body = <<-EOB
<DOCTYPE html>
<html>
  <body>
    <h1>Hello, rack world!</h1>
  </body>
</html>
    EOB
    return [200, {'Content-Type' => 'text/html'}, [body]]
  end
end

run SimpleApp.new
