module Junior
  VERSION = '0.0.1'

  require 'rack'
  require 'rack/builder'
  require 'usher'
  require 'tilt'

  require 'junior/helpers'
  require 'junior/router'
  require 'junior/request'
  require 'junior/dispatcher'
  require 'junior/controller'
  require 'junior/application'
  require 'junior/support'
end
