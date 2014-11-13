/*
 * zClip :: jQuery ZeroClipboard v1.1.1
 * http://steamdev.com/zclip
 *
 * Copyright 2011, SteamDev
 * Released under the MIT license.
 * http://www.opensource.org/licenses/mit-license.php
 *
 * Date: Wed Jun 01, 2011
 */
!function(e){e.fn.zclip=function(t){if("object"==typeof t&&!t.length){var i=e.extend({path:"ZeroClipboard.swf",copy:null,beforeCopy:null,afterCopy:null,clickAfter:!0,setHandCursor:!0,setCSSEffects:!0},t);return this.each(function(){var t=e(this);if(t.is(":visible")&&("string"==typeof i.copy||e.isFunction(i.copy))){ZeroClipboard.setMoviePath(i.path);var s=new ZeroClipboard.Client;e.isFunction(i.copy)&&t.bind("zClip_copy",i.copy),e.isFunction(i.beforeCopy)&&t.bind("zClip_beforeCopy",i.beforeCopy),e.isFunction(i.afterCopy)&&t.bind("zClip_afterCopy",i.afterCopy),s.setHandCursor(i.setHandCursor),s.setCSSEffects(i.setCSSEffects),s.addEventListener("mouseOver",function(){t.trigger("mouseenter")}),s.addEventListener("mouseOut",function(){t.trigger("mouseleave")}),s.addEventListener("mouseDown",function(){t.trigger("mousedown"),s.setText(e.isFunction(i.copy)?t.triggerHandler("zClip_copy"):i.copy),e.isFunction(i.beforeCopy)&&t.trigger("zClip_beforeCopy")}),s.addEventListener("complete",function(s,o){e.isFunction(i.afterCopy)?t.trigger("zClip_afterCopy"):(o.length>500&&(o=o.substr(0,500)+"...\n\n("+(o.length-500)+" characters not shown)"),t.removeClass("hover"),alert("Copied text to clipboard:\n\n "+o)),i.clickAfter&&t.trigger("click")}),s.glue(t[0],t.parent()[0]),e(window).bind("load resize",function(){s.reposition()})}})}return"string"==typeof t?this.each(function(){var i=e(this);t=t.toLowerCase();var s=i.data("zclipId"),o=e("#"+s+".zclip");"remove"==t?(o.remove(),i.removeClass("active hover")):"hide"==t?(o.hide(),i.removeClass("active hover")):"show"==t&&o.show()}):void 0}}(jQuery);var ZeroClipboard={version:"1.0.7",clients:{},moviePath:"ZeroClipboard.swf",nextId:1,$:function(e){return"string"==typeof e&&(e=document.getElementById(e)),e.addClass||(e.hide=function(){this.style.display="none"},e.show=function(){this.style.display=""},e.addClass=function(e){this.removeClass(e),this.className+=" "+e},e.removeClass=function(e){for(var t=this.className.split(/\s+/),i=-1,s=0;s<t.length;s++)t[s]==e&&(i=s,s=t.length);return i>-1&&(t.splice(i,1),this.className=t.join(" ")),this},e.hasClass=function(e){return!!this.className.match(new RegExp("\\s*"+e+"\\s*"))}),e},setMoviePath:function(e){this.moviePath=e},dispatch:function(e,t,i){var s=this.clients[e];s&&s.receiveEvent(t,i)},register:function(e,t){this.clients[e]=t},getDOMObjectPosition:function(e,t){var i={left:0,top:0,width:e.width?e.width:e.offsetWidth,height:e.height?e.height:e.offsetHeight};return e&&e!=t&&(i.left+=e.offsetLeft,i.top+=e.offsetTop),i},Client:function(e){this.handlers={},this.id=ZeroClipboard.nextId++,this.movieId="ZeroClipboardMovie_"+this.id,ZeroClipboard.register(this.id,this),e&&this.glue(e)}};ZeroClipboard.Client.prototype={id:0,ready:!1,movie:null,clipText:"",handCursorEnabled:!0,cssEffects:!0,handlers:null,glue:function(e,t,i){this.domElement=ZeroClipboard.$(e);var s=99;this.domElement.style.zIndex&&(s=parseInt(this.domElement.style.zIndex,10)+1),"string"==typeof t?t=ZeroClipboard.$(t):"undefined"==typeof t&&(t=document.getElementsByTagName("body")[0]);var o=ZeroClipboard.getDOMObjectPosition(this.domElement,t);this.div=document.createElement("div"),this.div.className="zclip",this.div.id="zclip-"+this.movieId,$(this.domElement).data("zclipId","zclip-"+this.movieId);var n=this.div.style;if(n.position="absolute",n.left=""+o.left+"px",n.top=""+o.top+"px",n.width=""+o.width+"px",n.height=""+o.height+"px",n.zIndex=s,"object"==typeof i)for(addedStyle in i)n[addedStyle]=i[addedStyle];t.appendChild(this.div),this.div.innerHTML=this.getHTML(o.width,o.height)},getHTML:function(e,t){var i="",s="id="+this.id+"&width="+e+"&height="+t;if(navigator.userAgent.match(/MSIE/)){var o=location.href.match(/^https/i)?"https://":"http://";i+='<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="'+o+'download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,0,0" width="'+e+'" height="'+t+'" id="'+this.movieId+'" align="middle"><param name="allowScriptAccess" value="always" /><param name="allowFullScreen" value="false" /><param name="movie" value="'+ZeroClipboard.moviePath+'" /><param name="loop" value="false" /><param name="menu" value="false" /><param name="quality" value="best" /><param name="bgcolor" value="#ffffff" /><param name="flashvars" value="'+s+'"/><param name="wmode" value="transparent"/></object>'}else i+='<embed id="'+this.movieId+'" src="'+ZeroClipboard.moviePath+'" loop="false" menu="false" quality="best" bgcolor="#ffffff" width="'+e+'" height="'+t+'" name="'+this.movieId+'" align="middle" allowScriptAccess="always" allowFullScreen="false" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" flashvars="'+s+'" wmode="transparent" />';return i},hide:function(){this.div&&(this.div.style.left="-2000px")},show:function(){this.reposition()},destroy:function(){if(this.domElement&&this.div){this.hide(),this.div.innerHTML="";var e=document.getElementsByTagName("body")[0];try{e.removeChild(this.div)}catch(t){}this.domElement=null,this.div=null}},reposition:function(e){if(e&&(this.domElement=ZeroClipboard.$(e),this.domElement||this.hide()),this.domElement&&this.div){var t=ZeroClipboard.getDOMObjectPosition(this.domElement),i=this.div.style;i.left=""+t.left+"px",i.top=""+t.top+"px"}},setText:function(e){this.clipText=e,this.ready&&this.movie.setText(e)},addEventListener:function(e,t){e=e.toString().toLowerCase().replace(/^on/,""),this.handlers[e]||(this.handlers[e]=[]),this.handlers[e].push(t)},setHandCursor:function(e){this.handCursorEnabled=e,this.ready&&this.movie.setHandCursor(e)},setCSSEffects:function(e){this.cssEffects=!!e},receiveEvent:function(e,t){switch(e=e.toString().toLowerCase().replace(/^on/,"")){case"load":if(this.movie=document.getElementById(this.movieId),!this.movie){var i=this;return void setTimeout(function(){i.receiveEvent("load",null)},1)}if(!this.ready&&navigator.userAgent.match(/Firefox/)&&navigator.userAgent.match(/Windows/)){var i=this;return setTimeout(function(){i.receiveEvent("load",null)},100),void(this.ready=!0)}this.ready=!0;try{this.movie.setText(this.clipText)}catch(s){}try{this.movie.setHandCursor(this.handCursorEnabled)}catch(s){}break;case"mouseover":this.domElement&&this.cssEffects&&(this.domElement.addClass("hover"),this.recoverActive&&this.domElement.addClass("active"));break;case"mouseout":this.domElement&&this.cssEffects&&(this.recoverActive=!1,this.domElement.hasClass("active")&&(this.domElement.removeClass("active"),this.recoverActive=!0),this.domElement.removeClass("hover"));break;case"mousedown":this.domElement&&this.cssEffects&&this.domElement.addClass("active");break;case"mouseup":this.domElement&&this.cssEffects&&(this.domElement.removeClass("active"),this.recoverActive=!1)}if(this.handlers[e])for(var o=0,n=this.handlers[e].length;n>o;o++){var a=this.handlers[e][o];"function"==typeof a?a(this,t):"object"==typeof a&&2==a.length?a[0][a[1]](this,t):"string"==typeof a&&window[a](this,t)}}};