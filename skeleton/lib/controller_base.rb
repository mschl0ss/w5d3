require 'active_support'
require 'active_support/core_ext'
require 'erb'
require_relative './session'

class ControllerBase
  attr_reader :req, :res, :params

  # Setup the controller
  def initialize(req, res)
    @req = req
    @res = res
  end

  # Helper method to alias @already_built_response
  def already_built_response?
    @already_built_response
  end

  # Set the response status code and header
  def redirect_to(url)
    raise "well shit partner" if already_built_response?
    @res.header['location'] = url
    @res.status = 302
    @already_built_response = true
  end

  # Populate the response with content.
  # Set the response's content type to the given type.
  # Raise an error if the developer tries to double render.
  def render_content(content, content_type)
    # @already_built_response ||= false
    
    raise "well shit partner" if already_built_response?

    @res['Content-Type'] = content_type
    @res.write(content)
    @already_built_response = true
    
  end

  # use ERB and binding to evaluate templates
  # pass the rendered html to render_content
  def render(template_name)
    first_path = File.dirname(__FILE__)
    dir_path = File.dirname(first_path)
    template_path = File.join(dir_path,"views","cats_controller", "#{template_name}.html.erb")

    returned_code = File.read(template_path)

    rendered_html = (ERB.new(returned_code).result(binding))



    render_content(rendered_html,"text/html")
  end

  # method exposing a `Session` object
  def session
  end

  # use this with the router to call action_name (:index, :show, :create...)
  def invoke_action(name)
  end
end

