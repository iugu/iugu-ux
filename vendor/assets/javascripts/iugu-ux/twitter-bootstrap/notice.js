/* ==========================================================
 * bootstrap-notice.js v2.0.4
 * http://twitter.github.com/bootstrap/javascript.html#notices
 * ==========================================================
 * Copyright 2012 Twitter, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * ========================================================== */


!function ($) {

  "use strict"; // jshint ;_;


 /* notice CLASS DEFINITION
  * ====================== */

  var dismiss = '[data-dismiss="notice"]'
    , Notice = function (el) {
        $(el).on('click', dismiss, this.close)
      }

  Notice.prototype.close = function (e) {
    var $this = $(this)
      , selector = $this.attr('data-target')
      , $parent

    if (!selector) {
      selector = $this.attr('href')
      selector = selector && selector.replace(/.*(?=#[^\s]*$)/, '') //strip for ie7
    }

    $parent = $(selector)

    e && e.preventDefault()

    $parent.length || ($parent = $this.hasClass('notice') ? $this : $this.parent())

    $parent.trigger(e = $.Event('close'))

    if (e.isDefaultPrevented()) return

    $parent.removeClass('in')

    function removeElement() {
      $parent
        .trigger('closed')
        .remove()
    }

    $.support.transition && $parent.hasClass('fade') ?
      $parent.on($.support.transition.end, removeElement) :
      removeElement()
  }


 /* notice PLUGIN DEFINITION
  * ======================= */

  $.fn.notice = function (option) {
    return this.each(function () {
      var $this = $(this)
        , data = $this.data('notice')
      if (!data) $this.data('notice', (data = new Notice(this)))
      if (typeof option == 'string') data[option].call($this)
    })
  }

  $.fn.notice.Constructor = Notice


 /* notice DATA-API
  * ============== */

  $(function () {
    $('body').on('click.notice.data-api', dismiss, Notice.prototype.close)
  })

}(window.jQuery);
