class Ohm::Model
  alias to_param id
end

class String
  alias to_param dup
end

class Fixnum
  alias to_param to_s
end

class Symbol
  alias to_param to_s
end

