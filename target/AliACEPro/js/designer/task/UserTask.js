draw2d.UserTask=function(configPropCallback){
	draw2d.Task.call(this,configPropCallback);
	this.performerType=null;
	this.dueDate=null;
	this.priority=null;
	this.formKey = null;
	this.expression=null;
	this.isUseExpression=null;
	this.assignee=null;
	this.candidateUsers=new draw2d.ArrayList();
	this.candidateGroups=new draw2d.ArrayList();
	this.formProperties=new draw2d.ArrayList();
	this.taskListeners=new draw2d.ArrayList();
	this.setTitle("User Task");
	//this.setIcon();
	//var borderColor = new draw2d.Color(126,148,177);
	//this.setColor(borderColor)
	//this.setLineWidth(2);
};
draw2d.UserTask.prototype=new draw2d.Task();
draw2d.UserTask.prototype.type="draw2d.UserTask";
draw2d.UserTask.newInstance=function(userTaskXMLNode){
	var task = new draw2d.UserTask();
	task.id=userTaskXMLNode.attr('id');
	task.taskId=userTaskXMLNode.attr('id');
	task.taskName=userTaskXMLNode.attr('name');
	task.setContent(userTaskXMLNode.attr('name'));
	return task;
};
/*draw2d.UserTask.prototype.setWorkflow=function(_5019){
	draw2d.Task.prototype.setWorkflow.call(this,_5019);
};
draw2d.UserTask.prototype.getContextMenu=function(){
	var menu = draw2d.Task.prototype.getContextMenu.call(this);
  return menu;
};
draw2d.UserTask.prototype.setIcon = function(){
	var icon=draw2d.Task.prototype.setIcon.call(this);
	icon.className="user-task-icon";
};*/
draw2d.UserTask.prototype.getIconClassName = function(){
	return "user-task-icon";
};
draw2d.UserTask.prototype.getStartElementXML=function(){
	var xml='<userTask '+this.getGeneralXML();
	if(this.isUseExpression=='true'){
		if(this.performerType=='assignee'){
			xml=xml+'activiti:assignee="'+this.expression+'" ';
		}else if(this.performerType=='candidateUsers'){
			xml=xml+'activiti:candidateUsers="'+this.expression+'" ';
		}else if(this.performerType=='candidateGroups'){
			xml=xml+'activiti:candidateGroups="'+this.expression+'" ';
		}
	}else{
		if(this.performerType=='assignee'){
			xml=xml+'activiti:assignee="'+this.assignee+'" ';
		}else if(this.performerType=='candidateUsers'){
			xml=xml+'activiti:candidateUsers="';
			//alert(this.candidateUsers.getSize());
			for(var i=0;i<this.candidateUsers.getSize();i++){
				var user = this.candidateUsers.get(i);
				if(i==this.candidateUsers.getSize()-1)
					xml=xml+user.sso;
				else
					xml=xml+user.sso+',';
			}
			xml=xml+'" ';
		}else if(this.performerType=='candidateGroups'){
			xml=xml+'activiti:candidateGroups="';
			for(var i=0;i<this.candidateGroups.getSize();i++){
				var group = this.candidateGroups.get(i);
				if(i==this.candidateGroups.getSize()-1)
					xml=xml+group;
				else
					xml=xml+group+',';
			}
			xml=xml+'" ';
		}
	}
	if(this.dueDate!=null&&this.dueDate!=''){
		xml=xml+'activiti:dueDate="'+this.dueDate+'" '
	}
	if(this.priority!=null&&this.priority!=''){
		xml=xml+'activiti:priority="'+this.priority+'" '
	}
	if(this.formKey != null && this.formKey != ""){
		xml=xml+'activiti:formKey="'+this.formKey+'" ';
	}
	xml=xml+'>\n';
	return xml;
};
draw2d.UserTask.prototype.getEndElementXML=function(){
	var xml = '</userTask>\n';
	return xml;
};
draw2d.UserTask.prototype.getDocumentationXML=function(){
	if(this.documentation==null||this.documentation=='')return '';
	var xml='<documentation>';
	xml=xml+this.documentation;
	xml=xml+'</documentation>';
	return xml;
};
/*
draw2d.UserTask.prototype.getPerformersXML=function(){
	var xml='';
	if(this.isUseExpression){
		if(this.expression!=null&&this.expression!=''){
			if(this.performerType=='assignee'){
				xml=xml+'activiti:assignee="'+this.expression+'" ';
			}else if(this.performerType=='candidateUsers'){
				xml=xml+'activiti:candidateUsers="'+this.expression+'" ';
			}else if(this.performerType=='candidateGroups'){
				xml=xml+'activiti:candidateGroups="'+this.expression+'" ';
			}
		}
	}else{
		if(this.performerType=='assignee'){
			if(this.assignee!=null&&this.assignee!='')
				xml=xml+this.assignee;
		}else if(this.performerType=='candidateUsers'){
			for(var i=0;i<this.candidateUsers.getSize();i++){
				var user = this.candidateUsers.get(i);
				xml=xml+user.sso+',';
			}
		}else if(this.performerType=='candidateGroups'){
			for(var i=0;i<this.candidateGroups.getSize();i++){
				var group = this.candidateGroups.get(i);
				xml=xml+group+',';
			}
		}
	}
	if(this.dueDate!=null&&this.dueDate!=''){
		xml=xml+'activiti:dueDate="'+this.dueDate+'" '
	}
	if(this.formKey != null && this.formKey != ""){
		xml=xml+'activiti:formKey="'+this.formKey+'" ';
	}
	if(this.priority!=null&&this.priority!=''){
		xml=xml+'activiti:priority="'+this.priority+'" '
	}
	
	return xml;
};
*/
draw2d.UserTask.prototype.getExtensionElementsXML=function(){
	if(this.taskListeners.getSize()==0&&this.listeners.getSize()==0&&this.formProperties.getSize()==0)return '';
	var xml = '<extensionElements>\n';
	xml=xml+this.getFormPropertiesXML();
	xml=xml+this.getListenersXML();
	xml=xml+'</extensionElements>\n';
	return xml;
};
draw2d.UserTask.prototype.getListenersXML=function(){
	var xml = draw2d.Task.prototype.getListenersXML.call(this);
	for(var i=0;i<this.taskListeners.getSize();i++){
		var listener = this.taskListeners.get(i);
		xml=xml+listener.toXML();
	}
	return xml;
};
/*draw2d.UserTask.prototype.getPerformersBPMNXML=function(){
	var xml = '';
	if(this.performerType=='candidateUsers'){
		if(this.candidateUsers.getSize()!=0){
			xml=xml+'<potentialOwner>\n';
			xml=xml+'<resourceAssignmentExpression>\n';
			xml=xml+'<formalExpression>\n';
			xml=xml+'<![CDATA[';
			for(var i=0;i<this.candidateUsers.getSize();i++){
				var user = this.candidateUsers.get(i);
				xml=xml+'user('+user.sso+'),';
			}
			xml=xml.substring(0, xml.length-1);
			xml=xml+']]>\n';
			xml=xml+'</formalExpression>\n';
			xml=xml+'</resourceAssignmentExpression>\n';
			xml=xml+'</potentialOwner>\n';
		}
	}else if(this.performerType=='candidateGroups'){
		if(this.candidateGroups.getSize()!=0){
			xml=xml+'<potentialOwner>\n';
			xml=xml+'<resourceAssignmentExpression>\n';
			xml=xml+'<formalExpression>\n';
			xml=xml+'<![CDATA[';
			for(var i=0;i<this.candidateGroups.getSize();i++){
				var group = this.candidateGroups.get(i);
				xml=xml+'group('+group+'),';
			}
			xml=xml.substring(0, xml.length-1);
			xml=xml+']]>\n';
			xml=xml+'</formalExpression>\n';
			xml=xml+'</resourceAssignmentExpression>\n';
			xml=xml+'</potentialOwner>\n';
		}
	}
	return xml;
};*/
draw2d.UserTask.prototype.getFormPropertiesXML=function(){
	var xml = '';
	for(var i=0;i<this.formProperties.getSize();i++){
		var formProperty = this.formProperties.get(i);
		xml=xml+formProperty.toXML();
	}
	return xml;
};
draw2d.UserTask.prototype.toXML=function(){
	var xml=this.getStartElementXML();
	xml=xml+this.getDocumentationXML();
	xml=xml+this.getExtensionElementsXML();
	xml=xml+this.getMultiInstanceXML();
	xml=xml+this.getEndElementXML();
	return xml;
};
draw2d.UserTask.prototype.getCandidateUser=function(sso){
	for(var i=0;i<this.candidateUsers.getSize();i++){
		var candidate = this.candidateUsers.get(i);
		if(candidate.sso===sso){
			return candidate;
		}
	}
	return null;
};
draw2d.UserTask.prototype.deleteCandidateUser=function(sso){
	var candidate = this.getCandidateUser(sso);
	this.candidateUsers.remove(candidate);
};
draw2d.UserTask.prototype.addCandidateUser=function(user){
	if(this.getCandidateUser(user.sso)==null)
		this.candidateUsers.add(user);
};
draw2d.UserTask.prototype.getCandidateGroup=function(name){
	for(var i=0;i<this.candidateGroups.getSize();i++){

		var candidate = this.candidateGroups.get(i);
		if(candidate===name){
			return candidate;
		}
	}
	return null;
};
draw2d.UserTask.prototype.deleteCandidateGroup=function(name){
	var candidate = this.getCandidateGroup(name);
	this.candidateGroups.remove(candidate);
};
draw2d.UserTask.prototype.addCandidateGroup=function(name){
	if(!this.candidateGroups.contains(name))
		this.candidateGroups.add(name);
};
draw2d.UserTask.prototype.getTaskListener=function(id){
	for(var i=0;i<this.taskListeners.getSize();i++){
		var listener = this.taskListeners.get(i);
		if(listener.getId()=== id){
			return listener;
		}
	}
};
draw2d.UserTask.prototype.deleteTaskListener=function(id){
	var listener = this.getTaskListener(id);
	this.taskListeners.remove(listener);
};
draw2d.UserTask.prototype.addTaskListener=function(listener){
	this.taskListeners.add(listener);
};
draw2d.UserTask.prototype.setTaskListeners=function(listeners){
	this.taskListeners = listeners;
};
draw2d.UserTask.prototype.getFormProperties=function(id){
	for(var i=0;i<this.formProperties.getSize();i++){
		var prop = this.formProperties.get(i);
		if(prop.id== id){
			return prop;
		}
	}
};
draw2d.UserTask.prototype.deleteFormProperties=function(id){
	var prop = this.getFormProperties(id);
	this.formProperties.remove(prop);
};
draw2d.UserTask.prototype.addFormProperties=function(prop){
	this.formProperties.add(prop);
};
draw2d.UserTask.prototype.setFormProperties=function(props){
	this.formProperties = props;
};
draw2d.UserTask.prototype.toObject=function(jqObject){
	this.parseTaskGeneralXML(jqObject);
	var assignee=jq(jqObject).attr('activiti:assignee');
	var candidataUsers=jq(jqObject).attr('activiti:candidateUsers');
	var candidataGroups=jq(jqObject).attr('activiti:candidateGroups');
	var formKey=jq(jqObject).attr('activiti:formKey');
	this.dueDate=jq(jqObject).attr('activiti:dueDate');
	this.priority=jq(jqObject).attr('activiti:priority');
	if(assignee!=null&&assignee!=""){
		this.isUseExpression=true;
		this.performerType="assignee";
		this.expression=assignee;
	}
	else if(candidataUsers!=null&&candidataUsers!=""){
		this.performerType="candidateUsers";
		if(candidataUsers.indexOf("${")<0){
			this.isUseExpression=false;
			var performers = candidataUsers.split(',');
			for(var i=0;i<performers.length;i++){
				this.addCandidateUser({
					sso:performers[i]
				});
			}
		}
		else{
			this.isUseExpression=true;
			this.expression=candidataUsers;
		}
		
	}
	else if(candidataGroups!=null&&candidataGroups!=""){
		this.performerType="candidateGroups";
		if(candidataGroups.indexOf("${")<0){
			this.isUseExpression=false;
			var performers = candidataGroups.split(',');
			for(var i=0;i<performers.length;i++){
				this.addCandidateGroup(performers[i]);
			}
		}else{
			this.isUseExpression=true;
			this.expression=candidataGroups;
		}
	}
	if(formKey!=null&&formKey!=""){
		this.formKey=formKey;
	}
	this.parseDocumentationXML(jqObject);
	
	
	var tasklisteners = jq(jqObject).find('extensionElements').find('[nodeName="activiti:taskListener"]');
	for(var i=0;i<tasklisteners.length;i++){
		var listener = new draw2d.UserTask.TaskListener();
		listener.toObject(tasklisteners[i]);
		this.addTaskListener(listener);
	}
	this.parseExecutionListenerXML(jqObject);
	var forms = jq(jqObject).find('extensionElements').find('[nodeName="activiti:formProperty"]');
	for(var i=0;i<forms.length;i++){
		var form = new draw2d.UserTask.FormProperty();
		form.toObject(forms[i]);
		this.addFormProperties(form);
	}
	this.parseMultiInstanceXML(jqObject);
};

draw2d.UserTask.TaskListener=function(){
	draw2d.Task.Listener.call(this);
};
draw2d.UserTask.TaskListener.prototype=new draw2d.Task.Listener();
draw2d.UserTask.TaskListener.prototype.toXML=function(){
	var xml = '<activiti:taskListener event="'+this.event+'" ';
	if(this.serviceType=='javaClass'){
		xml=xml+'class="'+this.serviceClass+'" ';
	}else if(this.serviceType=='expression'){
		xml=xml+'expression="'+this.serviceExpression+'" ';
	}
	xml=xml+'>\n';
	xml=xml+this.getFieldsXML();
	xml=xml+'</activiti:taskListener>\n'
	return xml;
};


//form porperties object
draw2d.UserTask.FormProperty=function(){
	this.id=null;
	this.name=null;
	this.type=null;
	this.expression=null;
	this.variable=null;
	this.defaultValue=null;
	this.datePattern=null;
	this.readable=null;
	this.writeable=null;
	this.required=null;
	this.values=new draw2d.ArrayList();
};
draw2d.UserTask.FormProperty.prototype.getPropValuesXML=function(){
	var xml = "";
	for(var i=0;i<this.values.getSize();i++){
		var val = this.values.get(i);
		xml=xml+val.toXML();
	}
	return xml;
};
draw2d.UserTask.FormProperty.prototype.toXML=function(){
	var xml = '<activiti:formProperty id="'+this.id+'" name="'+this.name+'" ';
	if(this.type!=null){
		xml=xml+'type="'+this.type+'" ';
	}
	if(this.expression!=null&&this.expression!=''){
		xml=xml+'expression="'+this.expression+'" ';
	}
	if(this.variable!=null&&this.variable!=''){
		xml=xml+'variable="'+this.variable+'" ';
	}
	if(this.defaultValue!=null&&this.defaultValue!=''){
		xml=xml+'default="'+this.defaultValue+'" ';
	}
	if(this.datePattern!=null&&this.datePattern!=''){
		xml=xml+'datePattern="'+this.datePattern+'" ';
	}
	if(this.readable!=null&&this.readable!=''){
		xml=xml+'readable="'+this.readable+'" ';
	}
	if(this.writeable!=null&&this.writeable!=''){
		xml=xml+'writeable="'+this.writeable+'" ';
	}
	if(this.required!=null&&this.required!=''){
		xml=xml+'required="'+this.required+'" ';
	}
	xml=xml+'>\n';
	xml=xml+this.getPropValuesXML();
	xml=xml+'</activiti:formProperty>\n'
	return xml;
};
draw2d.UserTask.FormProperty.prototype.toObject=function(jqObject){
	this.id=jq(jqObject).attr('id');
	this.name=jq(jqObject).attr('name');
	this.datePattern=jq(jqObject).attr('datePattern');
	this.variable=jq(jqObject).attr('variable');
	this.defaultValue=jq(jqObject).attr('default');
	this.expression=jq(jqObject).attr('expression');
	this.type=jq(jqObject).attr('type');
	this.readable=jq(jqObject).attr('readable');
	this.writeable=jq(jqObject).attr('writeable');
	this.required=jq(jqObject).attr('required');
};
draw2d.UserTask.FormProperty.prototype.getFormValue=function(id){
	for(var i=0;i<this.values.getSize();i++ ){
		var v = this.values.get(i);
		if(v.id == id){
			return v;
		}
	}
};
draw2d.UserTask.FormProperty.prototype.deleteFormValue=function(id){
	var field = this.getFormValue(id);
	this.values.remove(field);
};
draw2d.UserTask.FormProperty.prototype.getValuesString=function(){
	var f = '';
	for(var i=0;i<this.values.getSize();i++){
		var v = this.values.get(i);
		f=f+v.id+":"+v.name+",";
	}
	return f;
};
draw2d.UserTask.FormProperty.FormValue=function(){
	this.id=null;
	this.name=null;
}
draw2d.UserTask.FormProperty.FormValue.prototype.toXML=function(){
	var xml = '<activiti:value id="'+this.id+'" name="'+this.name+'"></activiti:value>\n';
	return xml
};
draw2d.UserTask.FormProperty.FormValue.prototype.toObject=function(jqObject){
	this.id=jq(jqObject).attr('id');
	this.name=jq(jqObject).attr('name');
};