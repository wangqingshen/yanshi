!function(o){"use strict";var t=!1,n=function(o,t){this.extend(this.params,o),this._init(o,t)};n.prototype={params:{listren:!1,distance:100},_init:function(t,n){var e=this;e.params.listen&&(document.body.addEventListener("touchmove",function(o){e.scroll(n)}),document.body.addEventListener("touchend",function(o){e.scroll(n)})),o.onscroll=function(){e.scroll(n)}},scroll:function(n){var e=this,c=(0===document.documentElement.scrollTop?document.body.clientHeight:document.documentElement.clientHeight,0===document.documentElement.scrollTop?document.body.scrollTop:document.documentElement.scrollTop),l=0===document.documentElement.scrollTop?document.body.scrollHeight:document.documentElement.scrollHeight;l-c-e.params.distance<=o.innerHeight?(t=!0,t&&n({scrollTop:c,isToBottom:!0})):(t=!1,n({scrollTop:c,isToBottom:!1}))},extend:function(o,t){for(var n in t)t.hasOwnProperty(n)&&(o[n]=t[n]);return o}},o.auiScroll=n}(window);
//# sourceMappingURL=aui-scroll.js.map