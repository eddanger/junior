module Junior

  class Controller

    include Junior::Helpers

    attr_accessor :env, :response, :request, :params, :layout_path
    
    def initialize(app = nil, id = nil)
      @env = app.env
      @response = app.response
      @request = app.request
      @params = @request.params

      @resource_id = id
    end

    def render(path)
      begin
        template = Tilt.new(path)
        
        output = template.render(self)
        
        if self.class.layout_path
          layout_template = Tilt.new(self.class.layout_path)
          output = layout_template.render(self) { output }
        end
        
        response.body = output
        response.status = 200
      rescue Exception => exception
        error(500, "#{exception}")
      end
      
      output
    end

    class << self
      
      attr_reader :layout_path
      
      def layout(layout_path = nil)
        @layout_path = layout_path
      end
      
      private
    
      def inherited(subclass)
        super
      end
    end

  end

end
