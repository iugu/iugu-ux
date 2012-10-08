var BrowserDetect = {
  init: function () {
    this.browser = this.searchString(this.dataBrowser) || "unknow";
    this.version = this.searchVersion(navigator.userAgent)
      || this.searchVersion(navigator.appVersion)
      || "unknown_version";
    this.OS = this.searchString(this.dataOS) || "unknow_os";
  },
  searchString: function (data) {
    for (var i=0;i<data.length;i++) {
      var dataString = data[i].string;
      var dataProp = data[i].prop;
      this.versionSearchString = data[i].versionSearch || data[i].identity;
      if (dataString) {
        if (dataString.indexOf(data[i].subString) != -1)
          return data[i].identity;
      }
      else if (dataProp)
        return data[i].identity;
    }
  },
  searchVersion: function (dataString) {
    var index = dataString.indexOf(this.versionSearchString);
    if (index == -1) return;
    return parseFloat(dataString.substring(index+this.versionSearchString.length+1));
  },
  dataBrowser: [
    {
      string: navigator.userAgent,
      subString: "Chrome",
      identity: "Chrome"
    },
    { string: navigator.userAgent,
      subString: "OmniWeb",
      versionSearch: "OmniWeb/",
      identity: "OmniWeb"
    },
    {
      string: navigator.vendor,
      subString: "Apple",
      identity: "Safari",
      versionSearch: "Version"
    },
    {
      prop: window.opera,
      identity: "Opera",
      versionSearch: "Version"
    },
    {
      string: navigator.vendor,
      subString: "iCab",
      identity: "iCab"
    },
    {
      string: navigator.vendor,
      subString: "KDE",
      identity: "Konqueror"
    },
    {
      string: navigator.userAgent,
      subString: "Firefox",
      identity: "Firefox"
    },
    {
      string: navigator.vendor,
      subString: "Camino",
      identity: "Camino"
    },
    {
      string: navigator.userAgent,
      subString: "Android",
      identity: "Webkit"
    },
    { // for newer Netscapes (6+)
      string: navigator.userAgent,
      subString: "Netscape",
      identity: "Netscape"
    },
    {
      string: navigator.userAgent,
      subString: "MSIE",
      identity: "Explorer",
      versionSearch: "MSIE"
    },
    {
      string: navigator.userAgent,
      subString: "Gecko",
      identity: "Mozilla",
      versionSearch: "rv"
    },
    { // for older Netscapes (4-)
      string: navigator.userAgent,
      subString: "Mozilla",
      identity: "Netscape",
      versionSearch: "Mozilla"
    }
  ],
  dataOS : [
    {
      string: navigator.platform,
      subString: "Win",
      identity: "Windows"
    },
    {
      string: navigator.platform,
      subString: "Mac",
      identity: "Mac"
    },
    {
         string: navigator.userAgent,
         subString: "iPhone",
         identity: "iPhone"
    },
    {
      string: navigator.userAgent,
      subString: "Android",
      identity: "Android"
    },
    {
      string: navigator.platform,
      subString: "Linux",
      identity: "Linux"
    }
  ]

};
BrowserDetect.init();

$( function() {

  window.IS_MOBILE = false;
  window.IS_DESKTOP = false;
  window.IS_IOS = false;
  window.IS_ANDROID = false;

  $("html").removeClass("no-js").addClass("js");
  $("html").removeClass("not-ready").addClass("ready");
  if (navigator.userAgent.match(/Android/i)) { $("html").addClass("android mobile"); window.IS_MOBILE=true; window.IS_ANDROID=true; }
  else if (navigator.userAgent.match(/iPhone/i) || navigator.userAgent.match(/iPad/i) || navigator.userAgent.match(/iPod/i)) { $("html").addClass("ios mobile"); window.IS_MOBILE=true; window.IS_IOS=true }
  else { $("html").addClass("desktop"); window.IS_DESKTOP=true }

  $("html").addClass( BrowserDetect.browser.toLowerCase() )
  $("html").addClass( BrowserDetect.browser.toLowerCase() + '_' + BrowserDetect.version )
  $("html").addClass( 'os_' + BrowserDetect.OS.toLowerCase() )

  var ua = navigator.userAgent;
  if( ua.indexOf("Android") >= 0 )
  {
    var androidversion = parseFloat(ua.slice(ua.indexOf("Android")+8)); 
    if (androidversion < 3)
    {
      $("html").addClass( 'deprecated_android' );
    }
  }

  window.TOUCH_SUPPORT = jQuery.support.touch;

  window.matchMedia = window.matchMedia || (function(doc, undefined){
    
    var bool,
        docElem = doc.documentElement,
        refNode = docElem.firstElementChild || docElem.firstChild,
        // fakeBody required for <FF4 when executed in <head>
        fakeBody = doc.createElement('body'),
        div = doc.createElement('div');
    
    div.id = 'mq-test-1';
    div.style.cssText = "position:absolute;top:-100em";
    fakeBody.style.background = "none";
    fakeBody.appendChild(div);
    
    return function(q){
      
      div.innerHTML = '&shy;<style media="'+q+'"> #mq-test-1 { width: 42px; }</style>';
      
      docElem.insertBefore(fakeBody, refNode);
      bool = div.offsetWidth == 42;
      docElem.removeChild(fakeBody);
      
      return { matches: bool, media: q };
    };
    
  })(document);

  window.HAS_MEDIAQUERY = window.matchMedia && window.matchMedia( "only all" ).matches;

  function configureMediaQuery() {
      $("body").removeClass("mq-mp"); // Mobile Portrait
      $("body").removeClass("mq-ml"); // Mobile Landscape
      $("body").removeClass("mq-tb"); // For Tablets
      $("body").removeClass("mq-ls"); // For Large Screens
      $("body").removeClass("mq-sm"); // For Small Screens
      var queryWidth = $(window).width();
      if (queryWidth < 480) $("body").addClass("mq-mp");
      else if (queryWidth < 768 && queryWidth > 479) $("body").addClass("mq-mp");
      else if (queryWidth < 1023 && queryWidth > 767) $("body").addClass("mq-tb");
      else if (queryWidth > 1024) $("body").addClass("mq-ls");
      else if (queryWidth < 769) $("body").addClass("mq-sm");
  }
  
  if (window.HAS_MEDIAQUERY) {
    $("html").addClass("mediaquery");
  } else {
    configureMediaQuery();
    $(window).resize(configureMediaQuery);
  }

});

