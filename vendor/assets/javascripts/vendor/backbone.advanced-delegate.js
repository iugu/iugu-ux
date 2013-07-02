_.each(["View"], function(name) {
  // Cache Backbone constructor.
  var ctor = Backbone[name];
  // Cache original fetch.
  var delegateEvents = ctor.prototype.delegateEvents;

  var delegateEventSplitter = /^(\S+)\s*(.*)$/;

  // Override the fetch method to emit a fetch event.
  ctor.prototype.delegateEvents = function(events) {
      if (!(events || (events = _.result(this, 'events')))) return;
      this.undelegateEvents();
      for (var key in events) {
        var method = events[key];
        if (!_.isFunction(method)) method = this[events[key]];
        if (!method) throw new Error('Method "' + events[key] + '" does not exist');
        var match = key.match(delegateEventSplitter);
        var eventName = match[1], selector = match[2];
        method = _.bind(method, this);
        originalEvent = eventName;
        eventName = '.delegateEvents' + this.cid;
        if ((originalEvent == "click") && (selector !== '')) {
          if (window.TOUCH_SUPPORT) {
            this.$el.on( "touchstart" + eventName, selector, function(event) { $(this).addClass('active'); } );
            this.$el.on( "touchend" + eventName, selector, function(event) { $(this).removeClass('active'); } );
            this.$el.on( "touchcancel" + eventName, selector, function(event) { $(this).removeClass('active'); } );
          }
          else {
            this.$el.on( "mousedown" + eventName, selector, function(event) { $(this).addClass('active'); } );
            this.$el.on( "mouseup" + eventName, selector, function(event) { $(this).removeClass('active'); } );
          }
        }
        if (selector === '') {
          this.$el.on(originalEvent + eventName, method);
        } else {
          this.$el.on(originalEvent + eventName, selector, method);
        }
      }
  };
});
