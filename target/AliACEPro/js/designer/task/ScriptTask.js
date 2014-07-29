draw2d.ScriptTask=function(configPropCallback){
	draw2d.Task.call(this,configPropCallback);
	this.setTitle("Script Task");
	this.scriptLanguage=null;
	this.script=null;
};
draw2d.ScriptTask.prototype=new draw2d.Task();
draw2d.ScriptTask.prototype.type="draw2d.ScriptTask";
draw2d.ScriptTask.prototype.getIconClassName = function(){
	return "script-task-icon";
};
draw2d.ScriptTask.prototype.getTaskTopLeftClassName=function(){
	return 'script-task-top-left';
}
draw2d.ScriptTask.prototype.getTaskTopRightClassName=function(){
	return 'script-task-top-right';
}
draw2d.ScriptTask.prototype.getTaskHeaderClassName=function(){
	return 'script-task-header';
}
draw2d.ScriptTask.prototype.getStartElementXML=function(){
	var xml='<scriptTask ';
	xml=xml+this.getGeneralXML();
	xml=xml+this.getScriptLanguageXML();
	xml=xml+'>\n';
	return xml;
};
draw2d.ScriptTask.prototype.getScriptLanguageXML=function(){
	var xml=''
	if(this.scriptLanguage!=null&&this.scriptLanguage!='')
		xml=xml+' scriptFormat="'+this.scriptLanguage+'" activiti:autoStoreVariables="true" '
	return xml;
}
draw2d.ScriptTask.prototype.parseScriptLanguageXML=function(jqObject){
	var scriptLanguage=jq(jqObject).attr("scriptFormat");
	if(scriptLanguage!=null&&scriptLanguage!=""){
		this.scriptLanguage=scriptLanguage;
	}
};
draw2d.ScriptTask.prototype.getScriptXML=function(){
	var xml=''
	if(this.script!=null&&this.script!='')
		xml=xml+'<script>'+this.script+'</script>\n'
	return xml;
}
draw2d.ScriptTask.prototype.parseScriptXML=function(jqObject){
	this.script=jq(jqObject).find("script").text();
};
draw2d.ScriptTask.prototype.getEndElementXML=function(){
	var xml = '</scriptTask>\n';
	return xml;
};
draw2d.ScriptTask.prototype.toXML=function(){
	var xml=this.getStartElementXML();
	xml=xml+this.getScriptXML();
	xml=xml+this.getExtensionElementsXML();
	xml=xml+this.getMultiInstanceXML();
	xml=xml+this.getEndElementXML();
	return xml;
};
draw2d.ScriptTask.prototype.toObject=function(jqObject){
	this.parseTaskGeneralXML(jqObject);
	this.parseScriptLanguageXML(jqObject);
	this.parseScriptXML(jqObject);
	this.parseExecutionListenerXML(jqObject);
	this.parseMultiInstanceXML(jqObject);
};