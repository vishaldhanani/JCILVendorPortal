'use strict';

var keyCodes = {
  
  112 : "f1 "
};

var body = document.querySelector('body');

body.onkeydown = function (e) {
  if ( !e.metaKey ) {
    e.preventDefault();
  }

  document.querySelector('.keycode-display').innerHTML = e.keyCode;
  document.querySelector('.text-display').innerHTML =
    keyCodes[e.keyCode] || `huh? Let me know what browser and key this was. <a href='https://github.com/wesbos/keycodes/issues/new?title=Missing keycode ${e.keyCode}&body=Tell me what key it was or even better, submit a Pull request!'>Submit to Github</a>`;
};

(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','//www.google-analytics.com/analytics.js','ga');

ga('create', 'UA-50371747-1', 'keycode.info');
ga('send', 'pageview');
