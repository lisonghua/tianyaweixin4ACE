<script>
function parseProcessDescriptor(data){
	var descriptor = jq(data);

	var startEvent = descriptor.find('startEvent');
	var endEvent = descriptor.find('endEvent');
	var userTasks = descriptor.find('userTask');
	var manualTasks = descriptor.find('task');
	var serviceTasks = descriptor.find('serviceTask');
	var receiveTasks=descriptor.find('receiveTask');
	var scriptTasks=descriptor.find('scriptTask');
	var businessRuleTasks=descriptor.find('businessRuleTask');
	var callActivities=descriptor.find('callActivity');
	var exclusiveGateway = descriptor.find('exclusiveGateway');
	var parallelGateway = descriptor.find('parallelGateway');
	var lines = descriptor.find('sequenceFlow');
	var shapes = descriptor.find('[nodeName="bpmndi:BPMNShape"]');//descriptor.find('bpmndi\\:BPMNShape');
	var edges = descriptor.find('[nodeName="bpmndi:BPMNEdge"]');
	
	workflow.process.toObject(descriptor);

	startEvent.each(function(i){
			var start = new draw2d.Start("../../js/designer/icons/type.startevent.none.png");
			start.toObject(this);
			shapes.each(function(i){
				var id = jq(this).attr('bpmnElement');
				if(id==start.id){
					start.parseShapeXML(this,workflow);
					return false;
				}
			});
		});
	endEvent.each(function(i){
			var end = new draw2d.End("../../js/designer/icons/type.endevent.none.png");
			end.toObject(this);
			shapes.each(function(i){
				var id = jq(this).attr('bpmnElement');
				if(id==end.id){
					end.parseShapeXML(this,workflow);
					return false;
				}
			});
		});
	
	userTasks.each(function(i){
			var task = new draw2d.UserTask(openTaskProperties);
			task.toObject(this);
			shapes.each(function(i){
				var id = jq(this).attr('bpmnElement');
				if(id==task.id){
					task.parseShapeXML(this,workflow);
					return false;
				}
			});
		});
	manualTasks.each(function(i){
			var manualTask = new draw2d.ManualTask(openTaskProperties);
			manualTask.toObject(this);
			shapes.each(function(i){
				var id = jq(this).attr('bpmnElement');
				if(id==manualTask.id){
					manualTask.parseShapeXML(this,workflow);
					return false;
				}
			});
	});
	serviceTasks.each(function(i){
			var type=jq(this).attr('activiti:type');
			if("mail"==type){
				var mailTask=new draw2d.MailTask(openTaskProperties);
				mailTask.toObject(this);
				shapes.each(function(i){
					var id = jq(this).attr('bpmnElement');
					if(id==mailTask.id){
						mailTask.parseShapeXML(this,workflow);
						return false;
					}
				});
			}else{
				var serviceTask=new draw2d.ServiceTask(openTaskProperties);
				serviceTask.toObject(this);
				shapes.each(function(i){
					var id = jq(this).attr('bpmnElement');
					if(id==serviceTask.id){
						serviceTask.parseShapeXML(this,workflow);
						return false;
					}
				});
			}
			
		});
	receiveTasks.each(function(i){
		var task = new draw2d.ReceiveTask(openTaskProperties);
		task.toObject(this);
		shapes.each(function(i){
			var id = jq(this).attr('bpmnElement');
			if(id==task.id){
				task.parseShapeXML(this,workflow);
				return false;
			}
		});
	});
	scriptTasks.each(function(i){
		var task = new draw2d.ScriptTask(openTaskProperties);
		task.toObject(this);
		shapes.each(function(i){
			var id = jq(this).attr('bpmnElement');
			if(id==task.id){
				task.parseShapeXML(this,workflow);
				return false;
			}
		});
	});
	businessRuleTasks.each(function(i){
		var task = new draw2d.BusinessRuleTask(openTaskProperties);
		task.toObject(this);
		shapes.each(function(i){
			var id = jq(this).attr('bpmnElement');
			if(id==task.id){
				task.parseShapeXML(this,workflow);
				return false;
			}
		});
	});
	callActivities.each(function(i){
		var task = new draw2d.CallActivity(openTaskProperties);
		task.toObject(this);
		shapes.each(function(i){
			var id = jq(this).attr('bpmnElement');
			if(id==task.id){
				task.parseShapeXML(this,workflow);
				return false;
			}
		});
	});
	exclusiveGateway.each(function(i){
			var gateway = new draw2d.ExclusiveGateway("${ctx}/js/designer/icons/type.gateway.exclusive.png");
			gateway.toObject(this);
			shapes.each(function(i){
				var id = jq(this).attr('bpmnElement');
				if(id==gateway.id){
					gateway.parseShapeXML(this,workflow);
					return false;
				}
			});
		});
	parallelGateway.each(function(i){
		var gateway = new draw2d.ExclusiveGateway("${ctx}/js/designer/icons/type.gateway.parallel.png");
		gateway.toObject(this);
		shapes.each(function(i){
			var id = jq(this).attr('bpmnElement');
			if(id==gateway.id){
				gateway.parseShapeXML(this,workflow);
				return false;
			}
		});
	});
	parseLineXML(lines,edges,workflow);
	if(typeof setHightlight != "undefined"){
		setHightlight();
	}
}
function parseLineXML(lines,edges,workflow){
	lines.each(function(i){
		var lid = jq(this).attr('id');
		var name = jq(this).attr('name');
		var condition=jq(this).find('conditionExpression').text();
		var sourceRef = jq(this).attr('sourceRef');
		var targetRef = jq(this).attr('targetRef');
		var source = workflow.getFigure(sourceRef);
		var target = workflow.getFigure(targetRef);
		for(var i=0;i<edges.length;i++){
			var eid = jq(edges[i]).attr('bpmnElement');
			if(eid==lid){
				var startPort = null;
				var endPort = null;
				var points = jq(edges[i]).find('[nodeName="omgdi:waypoint"]');
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
					var connection = new draw2d.DecoratedConnection();
					connection.toObject(this,workflow,startPort,endPort);
				}
				break;
			}
		}
	});
}
</script>