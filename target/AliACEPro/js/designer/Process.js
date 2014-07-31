/**
 * process object definition
 */
draw2d.Process=function(){
	this.id=null;
	this.name=null;
	this.category=null;
	this.documentation=null;
	this.listeners=new draw2d.ArrayList();
	this.variables=new draw2d.ArrayList();
};
draw2d.Process.prototype.getListener=function(id){
	for(var i=0;i<this.listeners.getSize();i++){
		var listener = this.listeners.get(i);
		if(listener.getId()=== id){
			return listener;
		}
	}
};
draw2d.Process.prototype.deleteListener=function(id){
	var listener = this.getListener(id);
	this.listeners.remove(listener);
};
draw2d.Process.prototype.addListener=function(listener){
	this.listeners.add(listener);
};
draw2d.Process.prototype.setListeners=function(listeners){
	this.listeners = listeners;
};
draw2d.Process.prototype.getVariable=function(id){
	for(var i=0;i<this.variables.getSize();i++){
		var variable = this.variables.get(i);
		if(variable.id=== id){
			return variable;
		}
	}
};
draw2d.Process.prototype.deleteVariable=function(id){
	var variable = this.getVariable(id);
	this.variables.remove(variable);
};
draw2d.Process.prototype.addVariable=function(variable){
	this.variables.add(variable);
};
draw2d.Process.prototype.getVariablesJSONObject=function(){
	return JSON.stringify(this.variables.data);
};
draw2d.Process.prototype.getListenersXML=function(){
	var xml = '';
	for(var i=0;i<this.listeners.getSize();i++){
		var listener = this.listeners.get(i);
		xml=xml+listener.toXML();
	}
	return xml;
};
draw2d.Process.prototype.getExtensionElementsXML=function(){
	if(this.listeners.getSize()==0)return '';
	var xml = '<extensionElements>\n';
	xml=xml+this.getListenersXML();
	xml=xml+'</extensionElements>\n';
	return xml;
};
draw2d.Process.prototype.getDocumentationXML=function(){
	var documentation = trim(this.documentation);
	if(documentation==null||documentation=='')return '';
	var xml='<documentation>';
	xml=xml+this.documentation;
	xml=xml+'</documentation>';
	return xml;
};
draw2d.Process.prototype.toObject=function(jqObject){
	var definitions = jqObject.find('definitions');
	var process = jqObject.find('process');
	this.category=definitions.attr('targetNamespace');
	this.id=process.attr('id');
	this.name=process.attr('name');
	var documentation = trim(jqObject.find('process > documentation').text());
	if(documentation != null && documentation != "")
		this.documentation=documentation;
	var extentsion = jqObject.find('process > extensionElements');
	if(extentsion != null){
		var listeners = extentsion.find('[nodeName="activiti:executionListener"]');
		for(var i=0;i<listeners.length;i++){
			var listener=new draw2d.Process.Listener();
			listener.toObject(this);
			this.addListener(listener);
		}
	}
	for(var i=0;i<processDefinitionVariables.length;i++){
		var variable = new draw2d.Process.variable();
		variable.name=processDefinitionVariables[i].name;
		variable.type=processDefinitionVariables[i].type;
		variable.scope=processDefinitionVariables[i].scope;
		variable.defaultValue=processDefinitionVariables[i].defaultValue;
		variable.remark=processDefinitionVariables[i].remark;
		this.addVariable(variable);
	}
};
draw2d.Process.variable=function(){
	this.id=draw2d.UUID.create();
	this.name=null;
	this.type=null;
	this.scope=null;
	this.defaultValue=null;
	this.remark=null;
};
//excution listener object
draw2d.Process.Listener=function(){
	this.id=draw2d.UUID.create();
	this.event=null;
	this.serviceType=null;
	this.serviceClass=null;
	this.serviceExpression=null;
	this.fields=new draw2d.ArrayList();
};
draw2d.Process.Listener.prototype.setId=function(id){
	this.id=id;
};
draw2d.Process.Listener.prototype.getId=function(){
	return this.id;
};
draw2d.Process.Listener.prototype.setField=function(field){
	this.fields.add(field);
};
draw2d.Process.Listener.prototype.getField=function(id){
	for(var i=0;i<this.fields.getSize();i++ ){
		var field = this.fields.get(i);
		if(field.id == id){
			return field;
		}
	}
};
draw2d.Process.Listener.prototype.deleteField=function(id){
	var field = this.getField(id);
	this.fields.remove(field);
};
draw2d.Process.Listener.prototype.getServiceImplementation=function(){
	if(this.serviceType=='javaClass')
		return this.serviceClass;
	else if(this.serviceType=='expression')
		return this.serviceExpression;
};
draw2d.Process.Listener.prototype.getFieldsString=function(){
	var f = '';
	var v = '';
	for(var i=0;i<this.fields.getSize();i++){
		var field = this.fields.get(i);
		f=f+field.name+":"+field.value+",";
	}
	return f;
};
draw2d.Process.Listener.prototype.toJSON=function(){
	var json={
			id:this.id,
			event:this.event,
			serviceType:this.serviceType,
			serviceClass:this.serviceClass,
			serviceExpression:this.serviceExpression,
			fields:this.fields.data
	};
	return JSON.stringify(json);
};
draw2d.Process.Listener.prototype.parseJSON=function(){
	var jsonString = this.toJSON();
	return JSON.parse(jsonString);
};
draw2d.Process.Listener.prototype.getFieldsXML=function(){
	var xml = "";
	for(var i=0;i<this.fields.getSize();i++){
		var field = this.fields.get(i);
		xml=xml+field.toXML();
	}
	return xml;
};
draw2d.Process.Listener.prototype.toXML=function(){
	var xml = '<activiti:executionListener event="'+this.event+'" ';
	if(this.serviceType=='javaClass'){
		xml=xml+'class="'+this.serviceClass+'" ';
	}else if(this.serviceType=='expression'){
		xml=xml+'expression="'+this.serviceExpression+'" ';
	}
	xml=xml+'>\n';
	xml=xml+this.getFieldsXML();
	xml=xml+'</activiti:executionListener>\n'
	return xml;
};
draw2d.Process.Listener.prototype.toObject=function(jqObject){
	this.event=jq(jqObject).attr('event');
	var expression = jq(jqObject).attr('expression');
	var clazz = jq(jqObject).attr('class');
	if(expression != null && expression!=""){
		this.serviceType='expression';
		this.serviceExpression=expression;
	}else if(clazz != null&& clazz!=""){
		this.serviceType='javaClass';
		this.serviceClass=clazz;
	}
	var fields = jq(jqObject).find('[nodeName="activiti:field"]');
	for(var i=0;i<fields.length;i++){
		var field = new draw2d.Process.Listener.Field();
		field.toObject(fields[i]);
		this.setField(field);
	}
};
/**
 * Process field object
 */
draw2d.Process.Listener.Field=function(){
	this.id=draw2d.UUID.create();
	this.name=null;
	this.type=null;
	this.value=null;
};
draw2d.Process.Listener.Field.prototype.toJSON=function(){
	var json = {
			id:this.id,
			name:this.name,
			type:this.type,
			value:this.value
	};
	return JSON.stringify(json);
};
draw2d.Process.Listener.Field.prototype.toXML=function(){
	var xml = '<activiti:field name="'+this.name+'">\n';
	if(this.type=='string'){
		xml=xml+'<activiti:string>'+this.value+'</activiti:string>\n';
	}else if(this.type='expression'){
		xml=xml+'<activiti:expression>'+this.value+'</activiti:expression>\n';
	}
	xml=xml+'</activiti:field>\n';
  	return xml
};
draw2d.Process.Listener.Field.prototype.toObject=function(jqObject){
	this.name=jq(jqObject).attr('name');
	//alert(field.name);
	var string = jq(jqObject).find('[nodeName="activiti:string"]').text();
	var expression = jq(jqObject).find('[nodeName="activiti:expression"]').text();
	//alert("String="+string.text()+"|"+"expression="+expression.text());
	if(string != null && string != ""){
		this.type='string';
		this.value=string;
	}else if(expression != null && expression!= ""){
		this.type='expression';
		this.value=expression;
	}
};