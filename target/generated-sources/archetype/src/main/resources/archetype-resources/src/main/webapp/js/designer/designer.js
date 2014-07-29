var DefaultModelTypeEnum=[
                          draw2d.Start.prototype.type,
                          draw2d.End.prototype.type,
                          draw2d.UserTask.prototype.type,
						  draw2d.ManualTask.prototype.type,
                          draw2d.ServiceTask.prototype.type,
                          draw2d.ScriptTask.prototype.type,
                          draw2d.MailTask.prototype.type,
                          draw2d.ReceiveTask.prototype.type,
                          draw2d.BusinessRuleTask.prototype.type,
                          draw2d.CallActivity.prototype.type,
                          draw2d.SubProcess.prototype.type,
                          draw2d.DecoratedConnection.prototype.type,
                          draw2d.ExclusiveGateway.prototype.type,
                          draw2d.ParallelGateway.prototype.type];
draw2d.Random=function(){};
draw2d.Random.create=function () {
	/*
	var len = 10;
	var seed = new Array 
	( 
	'abcdefghijklmnopqrstuvwxyz', 
	'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 
	'1234567890' 
	); 
	var idd, i; 
	var result = ''; 
	for (i = 0; i < len; i++) { 
		idd = Math.floor(Math.random() * seed.length); 
		result += seed[idd].substr(Math.floor(Math.random() * (seed[idd].length)), 1); 
	} 
	return result;
	*/
	return new Date().getTime();
};
//Sequence=draw2d.UUID;
Sequence=draw2d.Random;
//designer base objects definition


/**
 * designer UI objects definition
 */
draw2d.ContextMenu=function(w,h){
	draw2d.Menu.call(this);
	this.setDimension(w,h);
	this.item = null;
	this.width = w;
	this.height = h;
};
draw2d.ContextMenu.prototype = new draw2d.Menu();
draw2d.ContextMenu.prototype.type = "draw2d.ContextMenu";
draw2d.ContextMenu.prototype.setDimension=function(w,h){
	//draw2d.Menu.prototype.setDimension.call(this,w,h);
	this.item.style.width = w+"px";
	this.item.style.height = h+"px";
	/*
	this.shadow.css( {
		display : "block",
		zIndex : this.getZOrder()-1,
		left : this.menu.css("left"),
		top : this.menu.css("top"),
		width : w+3,
		height : h+3
	});
	*/
};
draw2d.ContextMenu.prototype.createHTMLElement = function() {
	this.item = document.createElement("div");
	this.item.style.left = this.x + "px";
	this.item.style.top = this.y + "px";
	this.item.style.cursor = "pointer";
	this.item.style.width = this.width+"px";
	this.item.style.height = this.height+"px";
	this.item.className = "context-menu";
	return this.item;
};
draw2d.ContextMenu.prototype.createList = function() {
	this.dirty = false;
	this.html.innerHTML = "";
	var oThis = this;
	for ( var i = 0; i < this.menuItems.getSize(); i++) {
		var item = this.menuItems.get(i);
		var li = document.createElement("div");
		li.className = "context-menu-item";
		var mtext = document.createElement("div");
		mtext.innerHTML = item.getLabel();
		mtext.className="context-menu-text";
		li.appendChild(mtext);
		var micon = document.createElement("div");
		micon.className = "context-menu-icon "+item.iconCls;
		li.appendChild(micon);
		li.menuItem = item;
		this.html.appendChild(li);
		if (li.addEventListener) {
			li.addEventListener("click", function(event) {
				var _508f = arguments[0] || window.event;
				_508f.cancelBubble = true;
				_508f.returnValue = false;
				var diffX = _508f.clientX;
				var diffY = _508f.clientY;
				var _5092 = document.body.parentNode.scrollLeft;
				var _5093 = document.body.parentNode.scrollTop;
				var target=event.srcElement ? event.srcElement : event.target;
				if(target.className.indexOf("context-menu-item")!=-1){
					target.menuItem.execute(diffX + _5092, diffY
							+ _5093);
				}else{
					target.parentNode.menuItem.execute(diffX + _5092, diffY
							+ _5093);
				}
			}, false);
			li.addEventListener("mouseup", function(event) {
				//alert("mouseup");
				event.cancelBubble = true;
				event.returnValue = false;
			}, false);
			li.addEventListener("mousedown", function(event) {
				//alert("mousedown");
				event.cancelBubble = true;
				event.returnValue = false;
			}, false);
			li.addEventListener("mouseover", function(event) {
				var target=event.srcElement ? event.srcElement : event.target;
				if(target.className.indexOf("context-menu-item")!=-1)
					target.className="context-menu-item context-menu-active";
				else
					target.parentNode.className="context-menu-item context-menu-active";
			}, false);
			li.addEventListener("mouseout", function(event) {
				var target=event.srcElement ? event.srcElement : event.target;
				if(target.className.indexOf("context-menu-active")!=-1)
					target.className="context-menu-item";
				else
					target.parentNode.className="context-menu-item";
			}, false);
		} else {
			if (li.attachEvent) {
				li.attachEvent("onclick", function(event) {
					var _5099 = arguments[0] || window.event;
					_5099.cancelBubble = true;
					_5099.returnValue = false;
					var diffX = _5099.clientX;
					var diffY = _5099.clientY;
					var _509c = document.body.parentNode.scrollLeft;
					var _509d = document.body.parentNode.scrollTop;
					var target=event.srcElement ? event.srcElement : event.target;
					if(target.className.indexOf("context-menu-item")!=-1)
						target.menuItem.execute(diffX + _509c, diffY
								+ _509d);
					else
						target.parentNode.menuItem.execute(diffX + _509c, diffY
								+ _509d);
				});
				li.attachEvent("onmousedown", function(event) {
					event.cancelBubble = true;
					event.returnValue = false;
				});
				li.attachEvent("onmouseup", function(event) {
					event.cancelBubble = true;
					event.returnValue = false;
				});
				li.attachEvent("onmouseover", function(event) {
					var target=event.srcElement ? event.srcElement : event.target;
					if(target.className.indexOf("context-menu-item")!=-1)
						target.className="context-menu-item context-menu-active";
					else
						target.parentNode.className="context-menu-item context-menu-active";
				});
				li.attachEvent("onmouseout", function(event) {
					var target=event.srcElement ? event.srcElement : event.target;
					if(target.className.indexOf("context-menu-active")!=-1)
						target.className="context-menu-item";
					else
						target.parentNode.className="context-menu-item";
				});
			}
		}
	}
};
draw2d.ContextMenuItem=function(label, iconCls, data ,action){
	draw2d.MenuItem.call(this,label,"",action);
	this.data = data;
	this.iconCls = iconCls;
};
draw2d.ContextMenuItem.prototype = new draw2d.MenuItem();
draw2d.ContextMenuItem.prototype.type = "draw2d.ContextMenuItem";
draw2d.ContextMenuItem.prototype.setIconCls=function(iconCls){
	this.iconCls = iconCls;
};
draw2d.ContextMenuItem.prototype.setData=function(data){
	this.data = data;
};
draw2d.ContextMenuItem.prototype.getData=function(){
	return this.data;
};
draw2d.ContextMenuItem.prototype.execute = function(x, y,f) {
	this.parentMenu.workflow.showMenu(null);
	this.action(x, y,f);
};
String.prototype.removeLineEnd = function()
{
    return this.replace(/(<.+?\s+?)(?:\n\s*?(.+?=".*?"))/g,'$1 $2')
};
function formatXml(text)
{
    //去掉多余的空格
    text = '\n' + text.replace(/(<\w+)(\s.*?>)/g,function($0, name, props)
    {
        return name + ' ' + props.replace(/\s+(\w+=)/g," $1");
    }).replace(/>\s*?</g,">\n<");
    
    //把注释编码
    text = text.replace(/\n/g,'\r').replace(/<!--(.+?)-->/g,function($0, text)
    {
        var ret = '<!--' + escape(text) + '-->';
        //alert(ret);
        return ret;
    }).replace(/\r/g,'\n');
    
    //调整格式
    var rgx = /\n(<(([^\?]).+?)(?:\s|\s*?>|\s*?(\/)>)(?:.*?(?:(?:(\/)>)|(?:<(\/)\2>)))?)/mg;
    var nodeStack = [];
    var output = text.replace(rgx,function($0,all,name,isBegin,isCloseFull1,isCloseFull2 ,isFull1,isFull2){
        var isClosed = (isCloseFull1 == '/') || (isCloseFull2 == '/' ) || (isFull1 == '/') || (isFull2 == '/');
        //alert([all,isClosed].join('='));
        var prefix = '';
        if(isBegin == '!')
        {
            prefix = getPrefix(nodeStack.length);
        }
        else 
        {
            if(isBegin != '/')
            {
                prefix = getPrefix(nodeStack.length);
                if(!isClosed)
                {
                    nodeStack.push(name);
                }
            }
            else
            {
                nodeStack.pop();
                prefix = getPrefix(nodeStack.length);
            }

        
        }
            var ret =  '\n' + prefix + all;
            return ret;
    });
    
    var prefixSpace = -1;
    var outputText = output.substring(1);
    
    //把注释还原并解码，调格式
    outputText = outputText.replace(/\n/g,'\r').replace(/(\s*)<!--(.+?)-->/g,function($0, prefix,  text)
    {
        //alert(['[',prefix,']=',prefix.length].join(''));
        if(prefix.charAt(0) == '\r')
            prefix = prefix.substring(1);
        text = unescape(text).replace(/\r/g,'\n');
        var ret = '\n' + prefix + '<!--' + text.replace(/^\s*/mg, prefix ) + '-->';
        //alert(ret);
        return ret;
    });
    
    return outputText.replace(/\s+$/g,'').replace(/\r/g,'\r\n');
}

function getPrefix(prefixIndex)
{
    var span = '    ';
    var output = [];
    for(var i = 0 ; i < prefixIndex; ++i)
    {
        output.push(span);
    }
    
    return output.join('');
}