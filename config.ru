require 'rack'
require 'pp'

class SimpleApp
  def call(env)
    body = env.pretty_print_inspect
    return [200, {'Content-Type' => 'text/plain'}, [body]]
  end
end

run SimpleApp.new
