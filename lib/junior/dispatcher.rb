module Junior

  class Dispatcher
    
    class << self
      
      def dispatch!(app)
        @env = app.env
        @response = app.response
        @request = app.request
        
        invoke do
          response = app.response
        
          #puts app.env['rack.input'].read
          
          controller = app.env[ 'usher.response' ] ? app.env[ 'usher.response' ].last.destination[ :controller ].to_s : nil
          if controller
            
            if controller[ '/' ] # a nested route
              controller = controller[(controller.rindex( '/' ) + 1)..controller.length]
              puts controller
            end
          
            action     = app.env[ 'usher.response' ].last.destination[ :action ].to_s
            id         = app.env[ 'usher.params' ][ :id ].to_s
        
            controller_instance = controller.camelize.to_class.new(app, id)

            if controller_instance.respond_to?(action)
              controller_instance.send(action)
            else
              controller_instance.not_found('Not found')
            end
          else
            Junior::Controller.new(app).not_found('Not found')
          end
        end
      end


      # Run the block with 'throw :halt' support and apply result to the response.
      def invoke(&block)
        res = catch(:halt) { instance_eval(&block) }
        return if res.nil?

        case
        when res.respond_to?(:to_str)
          @response.body = [res]
        when res.respond_to?(:to_ary)
          res = res.to_ary
          if Fixnum === res.first
            if res.length == 3
              @response.status, headers, body = res
              @response.body = body if body
              headers.each { |k, v| @response.headers[k] = v } if headers
            elsif res.length == 2
              @response.status = res.first
              @response.body   = res.last
            else
              raise TypeError, "#{res.inspect} not supported"
            end
          else
            @response.body = res
          end
        when res.respond_to?(:each)
          @response.body = res
        when (100...599) === res
          @response.status = res
        end

        res
      end
      

    end

  end

end