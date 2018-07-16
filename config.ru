require 'rack'
require 'pp'

class SimpleApp
  def call(env)
    request = Rack::Request.new(env)
    text = "Response!"
    response = Rack::Response.new(
      [text], 200, 'Content-Type' => 'text/plain'
    )
    response['Content-Length'] = text.bytesize.to_s
    return response.finish
  end
end

use Rack::Auth::Basic do |username, password|
  username == 'udzura' && password == 'XXX'
end

run SimpleApp.new
