# Hash.to_snake_keys
class Hash
  # Recursively converts CamelCase and camelBack JSON-style hash keys to
  # Rubyish snake_case, suitable for use during instantiation of Ruby
  # model attributes.
  #
  def to_snake_keys(value = self)
    case value
    when Array
      value.map { |v| to_snake_keys(v) }
    when Hash
      snake_hash(value)
    else
      value
    end
  end

  private

  def snake_hash(value)
    Hash[value.map { |k, v| [underscore_key(k).to_sym, to_snake_keys(v)] }]
  end

  def underscore_key(k)
    if k.is_a? Symbol
      underscore(k.to_s).to_sym
    elsif k.is_a? String
      underscore(k)
    else
      k # Plissken can't snakify anything except strings and symbols
    end
  end

  def underscore(string)
    string.gsub(/::/, '/')
      .gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
      .gsub(/([a-z\d])([A-Z])/, '\1_\2')
      .tr('-', '_')
      .downcase
  end
end
