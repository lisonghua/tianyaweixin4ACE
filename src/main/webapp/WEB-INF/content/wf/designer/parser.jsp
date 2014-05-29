<script>
function parseProcessDescriptor(data){
	var descriptor = jq(data);
	var definitions = descriptor.find('definitions');
	var process = descriptor.find('process');
	var startEvent = descriptor.find('startEvent');
	var endEvent = descriptor.find('endEvent');
	var userTasks = descriptor.find('userTask');
	var exclusiveGateway = descriptor.find('exclusiveGateway');
	var parallelGateway = descriptor.find('parallelGateway');
	var lines = descriptor.find('sequenceFlow');
	var shapes = descriptor.find('bpmndi\\:BPMNShape');
	var edges = descriptor.find('bpmndi\\:BPMNEdge');
	
	workflow.process.category=definitions.attr('targetNamespace');
	workflow.process.id=process.attr('id');
	workflow.process.name=process.attr('name');
	var documentation = trim(descriptor.find('process > documentation').text());
	if(documentation != null && documentation != "")
		workflow.process.documentation=documentation;
	var extentsion = descriptor.find('process > extensionElements');
	if(extentsion != null){
		var listeners = extentsion.find('activiti\\:executionListener');
		workflow.process.setListeners(parseListeners(listeners,"draw2d.Process.Listener","draw2d.Process.Listener.Field"));
	}
	jq.each(processDefinitionVariables,function(i,n){
			var variable = new draw2d.Process.variable();
			variable.name=n.name;
			variable.type=n.type;
			variable.scope=n.scope;
			variable.defaultValue=n.defaultValue;
			variable.remark=n.remark;
			workflow.process.addVariable(variable);
		});
	startEvent.each(function(i){
			var start = new draw2d.Start("${ctx}/js/designer/icons/type.startevent.none.png");
			start.id=jq(this).attr('id');
			start.eventId=jq(this).attr('id');
			start.eventName=jq(this).attr('name');
			shapes.each(function(i){
				var id = jq(this).attr('bpmnElement');
				if(id==start.id){
					var x=parseInt(jq(this).find('omgdc\\:Bounds').attr('x'));
					var y=parseInt(jq(this).find('omgdc\\:Bounds').attr('y'));
					var width=parseInt(jq(this).find('omgdc\\:Bounds').attr('width'));
					var height=parseInt(jq(this).find('omgdc\\:Bounds').attr('height'));
					start.setDimension(width,height);
					workflow.addFigure(start,x,y);
					return false;
				}
			});
		});
	endEvent.each(function(i){
			var end = new draw2d.End("${ctx}/js/designer/icons/type.endevent.none.png");
			end.id=jq(this).attr('id');
			end.eventId=jq(this).attr('id');
			end.eventName=jq(this).attr('name');
			shapes.each(function(i){
				var id = jq(this).attr('bpmnElement');
				if(id==end.id){
					var x=parseInt(jq(this).find('omgdc\\:Bounds').attr('x'));
					var y=parseInt(jq(this).find('omgdc\\:Bounds').attr('y'));
					var width=parseInt(jq(this).find('omgdc\\:Bounds').attr('width'));
					var height=parseInt(jq(this).find('omgdc\\:Bounds').attr('height'));
					end.setDimension(width,height);
					workflow.addFigure(end,x,y);
					return false;
				}
			});
		});
	
	userTasks.each(function(i){
			var task = new draw2d.UserTask();
			var tid = jq(this).attr('id');
			task.id=tid;
			var tname = jq(this).attr('name');
			var assignee=jq(this).attr('activiti:assignee');
			var candidataUsers=jq(this).attr('activiti:candidateUsers');
			var candidataGroups=jq(this).attr('activiti:candidateGroups');
			var formKey=jq(this).attr('activiti:formKey');
			if(assignee!=null&&assignee!=""){
				task.isUseExpression=true;
				task.performerType="assignee";
				task.expression=assignee;
			}else if(candidataUsers!=null&&candidataUsers!=""){
				task.isUseExpression=true;
				task.performerType="candidateUsers";
				task.expression=candidataUsers;
			}else if(candidataGroups!=null&&candidataGroups!=""){
				task.isUseExpression=true;
				task.performerType="candidateGroups";
				task.expression=candidataGroups;
			}
			if(formKey!=null&&formKey!=""){
				task.formKey=formKey;
			}
			var documentation = trim(jq(this).find('documentation').text());
			if(documentation != null && documentation != "")
				task.documentation=documentation;
			task.taskId=tid;
			task.taskName=tname;
			if(tid!= tname)
				task.setContent(tname);
			var listeners = jq(this).find('extensionElements').find('activiti\\:taskListener');
			task.setListeners(parseListeners(listeners,"draw2d.Task.Listener","draw2d.Task.Listener.Field"));
			var performersExpression = jq(this).find('potentialOwner').find('resourceAssignmentExpression').find('formalExpression').text();
			if(performersExpression.indexOf('user(')!=-1){
				task.performerType="candidateUsers";
			}else if(performersExpression.indexOf('group(')!=-1){
				task.performerType="candidateGroups";
			}
			var performers = performersExpression.split(',');
			jq.each(performers,function(i,n){
				var start = 0;
				var end = n.lastIndexOf(')');
				if(n.indexOf('user(')!=-1){
					start = 'user('.length;
					var performer = n.substring(start,end);
					task.addCandidateUser({
							sso:performer
					});
				}else if(n.indexOf('group(')!=-1){
					start = 'group('.length;
					var performer = n.substring(start,end);
					task.addCandidateGroup(performer);
				}
			});
			shapes.each(function(i){
				var id = jq(this).attr('bpmnElement');
				if(id==task.id){
					var x=parseInt(jq(this).find('omgdc\\:Bounds').attr('x'));
					var y=parseInt(jq(this).find('omgdc\\:Bounds').attr('y'));
					var width=parseInt(jq(this).find('omgdc\\:Bounds').attr('width'));
					var height=parseInt(jq(this).find('omgdc\\:Bounds').attr('height'));
					task.setDimension(width,height);
					workflow.addModel(task,x,y);
					return false;
				}
			});
		});
	exclusiveGateway.each(function(i){
			var gateway = new draw2d.ExclusiveGateway("${ctx}/js/designer/icons/type.gateway.exclusive.png");
			var gtwid = jq(this).attr('id');
			var gtwname = jq(this).attr('name');
			gateway.id=gtwid;
			gateway.gatewayId=gtwid;
			gateway.gatewayName=gtwname;
			shapes.each(function(i){
				var id = jq(this).attr('bpmnElement');
				if(id==gateway.id){
					var x=parseInt(jq(this).find('omgdc\\:Bounds').attr('x'));
					var y=parseInt(jq(this).find('omgdc\\:Bounds').attr('y'));
					var width=parseInt(jq(this).find('omgdc\\:Bounds').attr('width'));
					var height=parseInt(jq(this).find('omgdc\\:Bounds').attr('height'));
					gateway.setDimension(width,height);
					workflow.addModel(gateway,x,y);
					return false;
				}
			});
		});
	parallelGateway.each(function(i){
		var gateway = new draw2d.ExclusiveGateway("${ctx}/js/designer/icons/type.gateway.parallel.png");
		var gtwid = jq(this).attr('id');
		var gtwname = jq(this).attr('name');
		gateway.id=gtwid;
		gateway.gatewayId=gtwid;
		gateway.gatewayName=gtwname;
		shapes.each(function(i){
			var id = jq(this).attr('bpmnElement');
			if(id==gateway.id){
				var x=parseInt(jq(this).find('omgdc\\:Bounds').attr('x'));
				var y=parseInt(jq(this).find('omgdc\\:Bounds').attr('y'));
				var width=parseInt(jq(this).find('omgdc\\:Bounds').attr('width'));
				var height=parseInt(jq(this).find('omgdc\\:Bounds').attr('height'));
				gateway.setDimension(width,height);
				workflow.addModel(gateway,x,y);
				return false;
			}
		});
	});
	lines.each(function(i){
			var lid = jq(this).attr('id');
			var name = jq(this).attr('name');
			var condition=jq(this).find('conditionExpression').text();
			var sourceRef = jq(this).attr('sourceRef');
			var targetRef = jq(this).attr('targetRef');
			var source = workflow.getFigure(sourceRef);
			var target = workflow.getFigure(targetRef);
			edges.each(function(i){
					var eid = jq(this).attr('bpmnElement');
					if(eid==lid){
						var startPort = null;
						var endPort = null;
						var points = jq(this).find('omgdi\\:waypoint');
						var len = points.length;
						var startX = jq(points[0]).attr('x');
						var startY = jq(points[0]).attr('y');
						var endX = jq(points[len-1]).attr('x');
						var endY = jq(points[len-1]).attr('y');
						var sports = source.getPorts();
						for(var i=0;i<sports.getSize();i++){
							var s = sports.get(i);
							var x = s.getAbsoluteX();
							var y = s.getAbsoluteY();
							//alert(x+"|"+y+";"+startX+"|"+startY);
							if(x== startX&&y==startY){
								startPort = s;
								break;
							}
						}
						var tports = target.getPorts();
						for(var i=0;i<tports.getSize();i++){
							var t = tports.get(i);
							var x = t.getAbsoluteX();
							var y = t.getAbsoluteY();
							if(x==endX&&y==endY){
								endPort = t;
								break;
							}
						}
						if(startPort != null&&endPort!=null){
							var cmd=new draw2d.CommandConnect(workflow,startPort,endPort);
							var connection = new draw2d.DecoratedConnection();
							connection.id=lid;
							connection.lineId=lid;
							connection.lineName=name;
							if(lid!=name)
								connection.setLabel(name);
							if(condition != null && condition!=""){
								connection.condition=condition;
							}
							cmd.setConnection(connection);
							workflow.getCommandStack().execute(cmd);
						}
						return false;
					}
				});
		});
	if(typeof setHightlight != "undefined"){
		setHightlight();
	}
}
function parseListeners(listeners,listenerType,fieldType){
	var parsedListeners = new draw2d.ArrayList();
	listeners.each(function(i){
		var listener = eval("new "+listenerType+"()");
		
		listener.event=jq(this).attr('event');
		var expression = jq(this).attr('expression');
		var clazz = jq(this).attr('class');
		if(expression != null && expression!=""){
			listener.serviceType='expression';
			listener.serviceExpression=expression;
		}else if(clazz != null&& clazz!=""){
			listener.serviceType='javaClass';
			listener.serviceExpression=clazz;
		}
		var fields = jq(this).find('activiti\\:field');
		fields.each(function(i){
			var field = eval("new "+fieldType+"()");
			field.name=jq(this).attr('name');
			//alert(field.name);
			var string = jq(this).find('activiti\\:string').text();
			var expression = jq(this).find('activiti\\:expression').text();
			//alert("String="+string.text()+"|"+"expression="+expression.text());
			if(string != null && string != ""){
				field.type='string';
				field.value=string;
			}else if(expression != null && expression!= ""){
				field.type='expression';
				field.value=expression;
			}
			listener.setField(field);
		});
		parsedListeners.add(listener);
	});
	return parsedListeners;
}
</script>