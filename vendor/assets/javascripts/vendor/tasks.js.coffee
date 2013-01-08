class Tasks
  @do: ( methods, scope={} ) ->
    that_methods = methods
    new (
      () ->
        for index of scope
          this[index] = scope[index]
        methods_array = []
        original_methods = that_methods
        that = this
        for index of original_methods
          methods_array.push( original_methods[ index ].bind(that) )
        Async.waterfall( methods_array )
    )()

@Tasks = Tasks
