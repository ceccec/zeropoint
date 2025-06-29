# frozen_string_literal: true

# Zeropoint Extension: Object#to_md
# Adds a universal Markdown representation to all Ruby objects.
class Object
  # Returns a Markdown representation of the object.
  # Override in subclasses for custom output.
  def to_md
    "```
#{inspect}
```"
  end
end

class Array
  def to_md
    if all? { |e| e.is_a?(Hash) }
      keys_array = map(&:keys)
      keys_array.flatten!
      keys_array.uniq!
      keys = keys_array
      header = '| ' + keys.join(' | ') + ' |'
      sep = '|' + ([ ' --- ' ] * keys.size).join('|') + '|'
      rows = map do |h|
        keys.map { |k| h[k].to_s }.join(' | ')
      end
      ([ header, sep ] + rows.map { |r| "| #{r} |" }).join("\n")
    else
      map(&:to_md).join("\n")
    end
  end
end

class Hash
  def to_md
    "| Key | Value |\n| --- | --- |\n" + map { |k, v| "| #{k} | #{v} |" }.join("\n")
  end
end

# Optionally, add custom to_md for ActiveRecord, etc., if Rails is loaded
if defined?(ActiveRecord::Base)
  class ActiveRecord::Base
    def to_md
      "# #{self.class.name}\n" + attributes.to_md
    end
  end
end
