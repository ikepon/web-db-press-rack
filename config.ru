require 'rack'
require 'pp'

class SimpleApp
  def call(env)
    request = Rack::Request.new(env)
    text = "Response!\nruby"
    response = Rack::Response.new(
      [text], 200, 'Content-Type' => 'text/plain'
    )
    response['Content-Length'] = '18'
    return response.finish
  end
end

class RubyEmphasizer
  def initialize(app)
    @app = app
  end

  def call(env)
    code, headers, body = @app.call(env)
    body.body.map! { |text| text.gsub /ruby/i, '**RUBY**' }
    return [code, headers, body]
  end
end

set_trace_func(lambda { |event, _f, _l, id, _b, klass|
  if event =~ /call|return/ && id.to_s == 'call' && klass != Proc
    puts "[trace] #{klass}#call is called! as #{event}"
  end
})

use RubyEmphasizer

run SimpleApp.new
