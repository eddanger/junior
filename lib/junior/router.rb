module Junior

  class Router
    
    class << self
      
      def router( app )
        # router = Rack::Mount::RouteSet.new do |set|
        #   app.resources.each do |resource|
        #     set.add_route app, { :path_info => %r{^/#{resource}(\.(?:<format>[a-z]+))?$},                      :request_method => 'GET' },    { :controller => resource, :action => 'index' }
        #     set.add_route app, { :path_info => %r{^/#{resource}(\.(?:<format>[a-z]+))?$},                      :request_method => 'POST' },   { :controller => resource, :action => 'create' }
        #     set.add_route app, { :path_info => %r{^/#{resource}/new(\.(?:<format>[a-z]+))?$},                  :request_method => 'GET' },    { :controller => resource, :action => 'new' }
        #     set.add_route app, { :path_info => %r{^/#{resource}/(?:<id>[^/]+)/edit(\.(?:<format>[a-z]+))?$},   :request_method => 'GET' },    { :controller => resource, :action => 'edit' }
        #     set.add_route app, { :path_info => %r{^/#{resource}/(?:<id>[^/]+)/delete(\.(?:<format>[a-z]+))?$}, :request_method => 'GET' },    { :controller => resource, :action => 'delete' }
        #     set.add_route app, { :path_info => %r{^/#{resource}/(?:<id>[^/]+)(\.(?:<format>[a-z]+))?$},        :request_method => 'GET' },    { :controller => resource, :action => 'show' }
        #     set.add_route app, { :path_info => %r{^/#{resource}/(?:<id>[^/]+)(\.(?:<format>[a-z]+))?$},        :request_method => 'PUT' },    { :controller => resource, :action => 'update' }
        #     set.add_route app, { :path_info => %r{^/#{resource}/(?:<id>[^/]+)(\.(?:<format>[a-z]+))?$},        :request_method => 'DELETE' }, { :controller => resource, :action => 'destroy' }
        #   end
        #   
        #   app.routes.each do |route|
        #     set.add_route app, { :path_info => %r{^#{route[ :path ]}$}, :request_method => route[ :method ] }, route[ :to ]
        #   end
        # 
        #   # default
        #   #set.add_route app, { :path_info => %r{^/$} }, { :controller => app.default_controller, :action => app.default_action }
        #   #set.add_route app, { :path_info => %r{^/(?:<controller>[a-z0-9]+)(/(?:<action>[a-z0-9]+)(/(?:<id>[a-z0-9]+)(\.(?:<format>[a-z]+))?)?)?$} }, { :controller => app.default_controller, :action => app.default_action }
        # end
        # 
        # router

        router = Usher::Interface.for(:rack)
        router.default(app)
        
        app.resources.each do |resource|
          router.add "/#{resource}(.:format)",            :conditions => { :request_method => 'GET' },    :default_values => { :controller => resource, :action => 'index' }
          router.add "/#{resource}(.:format)",            :conditions => { :request_method => 'POST' },   :default_values => { :controller => resource, :action => 'create' }
          router.add "/#{resource}/new(.:format)",        :conditions => { :request_method => 'GET' },    :default_values => { :controller => resource, :action => 'new' }
          router.add "/#{resource}/:id/edit(.:format)",   :conditions => { :request_method => 'GET' },    :default_values => { :controller => resource, :action => 'edit' }
          router.add "/#{resource}/:id/delete(.:format)", :conditions => { :request_method => 'GET' },    :default_values => { :controller => resource, :action => 'delete' }
          router.add "/#{resource}/:id(.:format)",        :conditions => { :request_method => 'GET' },    :default_values => { :controller => resource, :action => 'show' }
          router.add "/#{resource}/:id(.:format)",        :conditions => { :request_method => 'PUT' },    :default_values => { :controller => resource, :action => 'update' }
          router.add "/#{resource}/:id(.:format)",        :conditions => { :request_method => 'DELETE' }, :default_values => { :controller => resource, :action => 'destroy' }
        end
        
        app.routes.each do |route|
          router.add "#{route[ :path ]}", :conditions => { :request_method => route[ :method ] }, :default_values => route[ :to ]
        end
        
        router

      end

    end

  end

end