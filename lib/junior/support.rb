class String
  # http://stackoverflow.com/questions/1448293/cast-between-string-and-classname
  def to_class
    chain = self.split "::"
    klass = Kernel
    chain.each do |klass_string|
      klass = klass.const_get klass_string
    end
    klass.is_a?(Class) ? klass : nil
  rescue NameError
    nil
  end

  # http://rails.rubyonrails.org/classes/Inflector.html#M001629
  def camelize(first_letter_in_uppercase = true)
    if first_letter_in_uppercase
      self.to_s.gsub(/\/(.?)/) { "::" + $1.upcase }.gsub(/(^|_)(.)/) { $2.upcase }
    else
      self.first + camelize(self)[1..-1]
    end
  end

end