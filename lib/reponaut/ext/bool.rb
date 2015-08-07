class Object
  def bool?
    false
  end
end

class TrueClass
  def bool?
    true
  end
end

class FalseClass
  def bool?
    true
  end
end
