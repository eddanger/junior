module Junior

  class Router

    attr_reader :app, :router

    def initialize(app, router)
      @app, @router = app, router
    end

    def call(env)
      @router.call(env)
      @app.call(env)
    end
    
  end
end


module Junior
  
  class Usher
    
    attr_reader :router
    
    def initialize
      @router = ::Usher::Interface.for(:rack, nil, :use_destinations => false)
    end
        
    class << self
      
      def routes( &block )
        usher = self.new
        
        usher.instance_eval( &block )
        
        usher.router
      end
    end
      
    def resources( resource, &block )
      resource = "#{@parent_resource}/:#{@parent_resource}_id/#{resource}" if @parent_resource
      
      self.router.get(    "/#{resource}(.:format)"            ).to( :controller => resource, :action => 'index'   ).name( :"#{resource}_index" )
      self.router.post(   "/#{resource}(.:format)"            ).to( :controller => resource, :action => 'create'  ).name( :"#{resource}_create" )
      self.router.get(    "/#{resource}/new(.:format)"        ).to( :controller => resource, :action => 'new'     ).name( :"#{resource}_new" )
      self.router.get(    "/#{resource}/:id/edit(.:format)"   ).to( :controller => resource, :action => 'edit'    ).name( :"#{resource}_edit" )
      self.router.get(    "/#{resource}/:id/delete(.:format)" ).to( :controller => resource, :action => 'delete'  ).name( :"#{resource}_delete" )
      self.router.get(    "/#{resource}/:id(.:format)"        ).to( :controller => resource, :action => 'show'    ).name( :"#{resource}_show" )
      self.router.put(    "/#{resource}/:id(.:format)"        ).to( :controller => resource, :action => 'update'  ).name( :"#{resource}_update" )
      self.router.delete( "/#{resource}/:id(.:format)"        ).to( :controller => resource, :action => 'destroy' ).name( :"#{resource}_destroy" )
      
      if block_given?
        @parent_resource = resource
        block.call
      end
      
      @parent_resource = nil
    end
    
    def get( path, route )
      self.router.get( path ).to( route )
    end

    def put( path, route )
      self.router.put( path ).to( route )
    end

    def post( path, route )
      self.router.post( path ).to( route )
    end

    def delete( path, route )
      self.router.delete( path ).to( route )
    end

  end

end