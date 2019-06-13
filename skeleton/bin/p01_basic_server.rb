require 'rack'

weirdfruitobsession = Proc.new do |env|
  req = Rack::Request.new(env)
  res = Rack::Response.new
  res['Content-Type'] = 'text/html'
  res.write(req.path)
  # p env
  res.finish
end


# Rack::Server.start(
#   app: <whatever is here is going to be the receiver for this:>.call(allthatdatathatrackcallsenvironment)
# )

Rack::Server.start(
  app: weirdfruitobsession,
  Port: 3000
)
