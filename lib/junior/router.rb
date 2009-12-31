module Junior

  class Router

    class << self
      
      def router( app )
        router = Rack::Mount::RouteSet.new do |set|
          app.resources.each do |resource|
            set.add_route app, { :path_info => %r{^/#{resource}(\.(?:<format>[a-z]+))?$},                      :request_method => 'GET' },    { :controller => resource, :action => 'index' }
            set.add_route app, { :path_info => %r{^/#{resource}(\.(?:<format>[a-z]+))?$},                      :request_method => 'POST' },   { :controller => resource, :action => 'create' }
            set.add_route app, { :path_info => %r{^/#{resource}/new(\.(?:<format>[a-z]+))?$},                  :request_method => 'GET' },    { :controller => resource, :action => 'new' }
            set.add_route app, { :path_info => %r{^/#{resource}/(?:<id>[^/]+)/edit(\.(?:<format>[a-z]+))?$},   :request_method => 'GET' },    { :controller => resource, :action => 'edit' }
            set.add_route app, { :path_info => %r{^/#{resource}/(?:<id>[^/]+)/delete(\.(?:<format>[a-z]+))?$}, :request_method => 'GET' },    { :controller => resource, :action => 'delete' }
            set.add_route app, { :path_info => %r{^/#{resource}/(?:<id>[^/]+)(\.(?:<format>[a-z]+))?$},        :request_method => 'GET' },    { :controller => resource, :action => 'show' }
            set.add_route app, { :path_info => %r{^/#{resource}/(?:<id>[^/]+)(\.(?:<format>[a-z]+))?$},        :request_method => 'PUT' },    { :controller => resource, :action => 'update' }
            set.add_route app, { :path_info => %r{^/#{resource}/(?:<id>[^/]+)(\.(?:<format>[a-z]+))?$},        :request_method => 'DELETE' }, { :controller => resource, :action => 'destroy' }
          end
          
          app.routes.each do |route|
            set.add_route app, { :path_info => %r{^#{route[ :path ]}$}, :request_method => route[ :method ] }, route[ :to ]
          end

          # default
          #set.add_route app, { :path_info => %r{^/$} }, { :controller => app.default_controller, :action => app.default_action }
          #set.add_route app, { :path_info => %r{^/(?:<controller>[a-z0-9]+)(/(?:<action>[a-z0-9]+)(/(?:<id>[a-z0-9]+)(\.(?:<format>[a-z]+))?)?)?$} }, { :controller => app.default_controller, :action => app.default_action }
        end

        router
      end
      
    end

  end

end