module Junior
  VERSION = '0.0.0'

  require 'rack'
  require 'rack/builder'
  require 'rack/mount'
  require 'tilt'

  require 'junior/helpers'
  require 'junior/router'
  require 'junior/request'
  require 'junior/dispatcher'
  require 'junior/controller'
  require 'junior/application'
  require 'junior/support'
end
