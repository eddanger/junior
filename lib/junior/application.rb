module Junior
  
  class Application
    
    attr_accessor :app, :env, :request, :response

    def initialize(app = nil)
      @app = app
    end
 
    def call(env)
      dup.call!(env)
    end
    
    def call!(env)
      @env        = env
      #@request    = Rack::Request.new(env)
      @request    = Junior::Request.new(env)
      @response   = Rack::Response.new
      
      Dispatcher.dispatch!(self)
      
      status, header, body = @response.finish
      
      [status, header, body]
    end

    class << self

      def reset!
        @middleware = []
        @resources = []
        @routes = []
        @prototype  = nil
      end
      
      def router
        Router.router(self)
      end

      def prototype
        @prototype ||= new
      end

      def new(*args, &bk)
        builder = Rack::Builder.new

        middleware.each { |middleware, args, block| builder.use(middleware, *args, &block) }

        builder.run super
        builder.to_app
      end
      
      def call(env)
        prototype.call(env)
      end

      def development?; environment == :development end
      def production?;  environment == :production  end
      def test?;        environment == :test        end

      def middleware
        if superclass.respond_to?(:middleware)
          superclass.middleware + ( @middleware || [] )
        else
          @middleware || []
        end
      end
    
      def resources
        @resources || []
      end
    
      def routes
        @routes || []
      end
    
      def use(middleware, *args, &block)
        @middleware << [ middleware, args, block ]
      end

      def resource(resource)
        @resources << resource
      end

      def route(path, to = {}, method = 'GET')
        @routes << { :path => path, :to => to, :method => method }
      end

      def set(option, value=self)
        if value.kind_of?(Proc)
          metadef(option, &value)
          metadef("#{option}?") { !!__send__(option) }
          metadef("#{option}=") { |val| set(option, Proc.new{val}) }
        elsif value == self && option.respond_to?(:to_hash)
          option.to_hash.each { |k,v| set(k, v) }
        elsif respond_to?("#{option}=")
          __send__ "#{option}=", value
        else
          set option, Proc.new{value}
        end
        self
      end
      
    private
    
      def inherited(subclass)
        subclass.reset!
        super
      end

      def metadef(message, &block)
        (class << self; self; end).
          send :define_method, message, &block
      end
    end

    set :environment, (ENV['RACK_ENV'] || :development).to_sym
  end

end
