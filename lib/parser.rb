class GetParser

  def self.call(env)
    new(env).response
  end

  def initialize(env)
    @request = Rack::Request.new(env)
  end

  def response
    Rack::Response.new(render("parser.html.erb"))
  end

  def parser
    Rack::Utils.parse_nested_query(@request.env["QUERY_STRING"])
  end

  private

  def render(template)
    path = File.expand_path("../views/#{template}", __FILE__)
    ERB.new(File.read(path)).result(binding)
  end
end