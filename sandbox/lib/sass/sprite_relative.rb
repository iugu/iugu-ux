module Sass::Script::Functions
  def sprite_relative(string)
    assert_type string, :String
    Sass::Script::String.new(string.value.sub("app/assets/sprites/",""))
  end
  declare :sprite_relative, :args => [:string]
end
