module Junior

  class Request < Rack::Request
    # Make the methodoverride middleware work with rack 1.0.x
    def params
      self.GET.update(self.POST)
    rescue EOFError, Errno::ESPIPE
      self.GET
    end
  end

end
