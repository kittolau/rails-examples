class ExampleController < ApplicationController
  #turn off CSRF token checking for web api
  skip_before_action :verify_authenticity_token

  #Variable in Controller
  #action_name
    #get the current action name
    action_name

  #request
    #request 各種關於此request的詳細資訊
      request_method
      method
      delete?, get?, head?, post?, put?
      xml_http_request? 或 xhr?
      url
      protocol, host, port, path 和 query_string
      domain
      host_with_port
      port_string
      ssl?
      remote_ip?
      path_without_extension, path_without_format_and_extension, format_and_extension, relative_path
      env
      accepts
      format
      mime_type
      content_type
      headers
      body
      content_length

end
