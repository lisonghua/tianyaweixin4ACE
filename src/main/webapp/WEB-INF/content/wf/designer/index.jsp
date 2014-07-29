<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
  <meta content="text/html; charset=UTF-8" http-equiv="content-type">
  <title></title>
  <%@ include file="/common/header.jsp" %>
  <link href="${ctx}/js/designer/designer.css" type="text/css" rel="stylesheet"/>
  			
        <!-- common, all times required, imports -->
        <SCRIPT src='${ctx}/js/draw2d/wz_jsgraphics.js'></SCRIPT>          
        <SCRIPT src='${ctx}/js/draw2d/mootools.js'></SCRIPT>          
        <SCRIPT src='${ctx}/js/draw2d/moocanvas.js'></SCRIPT>                        
        <SCRIPT src='${ctx}/js/draw2d/draw2d.js'></SCRIPT>

<script type="text/javascript">
<!--
var jq = jQuery.noConflict();
//-->
</script>
        <!-- example specific imports -->
        <SCRIPT src="${ctx}/js/designer/MyCanvas.js"></SCRIPT>
        <SCRIPT src="${ctx}/js/designer/ResizeImage.js"></SCRIPT>
        <SCRIPT src="${ctx}/js/designer/Process.js"></SCRIPT>
		<SCRIPT src="${ctx}/js/designer/event/Start.js"></SCRIPT>
		<SCRIPT src="${ctx}/js/designer/event/End.js"></SCRIPT>
		<SCRIPT src="${ctx}/js/designer/connection/MyInputPort.js"></SCRIPT>
		<SCRIPT src="${ctx}/js/designer/connection/MyOutputPort.js"></SCRIPT>
		<SCRIPT src="${ctx}/js/designer/connection/DecoratedConnection.js"></SCRIPT>
		<SCRIPT src="${ctx}/js/designer/task/Task.js"></SCRIPT>
		<SCRIPT src="${ctx}/js/designer/task/UserTask.js"></SCRIPT>
		<SCRIPT src="${ctx}/js/designer/task/ManualTask.js"></SCRIPT>
		<SCRIPT src="${ctx}/js/designer/task/ServiceTask.js"></SCRIPT>
		<SCRIPT src="${ctx}/js/designer/task/ScriptTask.js"></SCRIPT>
		<SCRIPT src="${ctx}/js/designer/task/MailTask.js"></SCRIPT>
		<SCRIPT src="${ctx}/js/designer/task/ReceiveTask.js"></SCRIPT>
		<SCRIPT src="${ctx}/js/designer/task/BusinessRuleTask.js"></SCRIPT>
		<SCRIPT src="${ctx}/js/designer/task/CallActivity.js"></SCRIPT>
		<SCRIPT src="${ctx}/js/designer/container/SubProcess.js"></SCRIPT>
		<SCRIPT src="${ctx}/js/designer/gateway/ExclusiveGateway.js"></SCRIPT>
		<SCRIPT src="${ctx}/js/designer/gateway/ParallelGateway.js"></SCRIPT>
		<SCRIPT src="${ctx}/js/designer/designer.js"></SCRIPT>	

</head>
<script type="text/javascript">
<!--
var processDefinitionId="<%=request.getParameter("procDefId")%>";
var processDefinitionName="<%=request.getParameter("procDefName")%>";
var processDefinitionVariables=<%=request.getAttribute("_process_def_variables")%>;
var _process_def_provided_listeners=<%=request.getAttribute("_process_def_provided_listeners")%>;
var is_open_properties_panel = false;
var task;
var line;
var formPropertyId;
var listenerId;
var executionListenerId;
jq(function(){
	try{
		_task_obj = jq('#task');
		_designer = jq('#designer');
		_properties_panel_obj = _designer.layout('panel','east');
		_properties_panel_obj.panel({
			onOpen:function(){
				is_open_properties_panel = true;
			},
			onClose:function(){
				is_open_properties_panel = false;
			}
		});
		_process_panel_obj = _designer.layout('panel','center');
		_task_context_menu = jq('#task-context-menu').menu({});
		_designer.layout('collapse','east');
		
		jq('.easyui-linkbutton').draggable({
					proxy:function(source){
						var n = jq('<div class="draggable-model-proxy"></div>');
						n.html(jq(source).html()).appendTo('body');
						return n;
					},
					deltaX:0,
					deltaY:0,
					revert:true,
					cursor:'auto',
					onStartDrag:function(){
						jq(this).draggable('options').cursor='not-allowed';
					},
					onStopDrag:function(){
						jq(this).draggable('options').cursor='auto';
					}	
		});
		jq('#paintarea').droppable({
					accept:'.easyui-linkbutton',
					onDragEnter:function(e,source){
						jq(source).draggable('options').cursor='auto';
					},
					onDragLeave:function(e,source){
						jq(source).draggable('options').cursor='not-allowed';
					},
					onDrop:function(e,source){
						//jq(this).append(source)
						//jq(this).removeClass('over');
						var wfModel = jq(source).attr('wfModel');
						var shape = jq(source).attr('iconImg');
						var modelType=jq(source).attr('modelType');
						if(wfModel){
							var x=jq(source).draggable('proxy').offset().left;
							var y=jq(source).draggable('proxy').offset().top;
							var xOffset    = workflow.getAbsoluteX();
		                    var yOffset    = workflow.getAbsoluteY();
		                    var scrollLeft = workflow.getScrollLeft();
		                    var scrollTop  = workflow.getScrollTop();
		                  //alert(xOffset+"|"+yOffset+"|"+scrollLeft+"|"+scrollTop);
		                    addModel(wfModel,x-xOffset+scrollLeft,y-yOffset+scrollTop,shape,modelType);
						}
					}
				});
		//jq('#paintarea').bind('contextmenu',function(e){
			//alert(e.target.tagName);
		//});
	}catch(e){
		alert(e.message);
	};
	jq(window).unload( function () { 
		window.opener._list_grid_obj.datagrid('reload');
	} );
});
function addModel(name,x,y,icon,type){
	var model = null;
	if(icon!=null&&icon!=undefined){
		model = eval("new draw2d."+name+"('"+icon+"')");
		model.generateId();
		workflow.addModel(model,x,y);
	}else{
		if(type=='container'){
			//model = new draw2d.MyCanvas("subProcessPainArea"); 
			//workflow.getCommandStack().execute(new draw2d.CommandAdd(workflow,model,x,y,workflow));
			model = eval("new draw2d."+name+"(openTaskProperties,openSubProcess)");
			model.generateId();
			workflow.addModel(model,x,y);
		}else{
			model = eval("new draw2d."+name+"(openTaskProperties)");
			model.generateId();
			workflow.addModel(model,x,y);
		}
	}
	//userTask.setContent("DM Approve");
	//model.generateId();
	//var id= task.getId();
	//task.id=id;
	//task.setId(id);
	//task.taskId=id;
	//task.taskName=id;
	//var parent = workflow.getBestCompartmentFigure(x,y);
	//workflow.getCommandStack().execute(new draw2d.CommandAdd(workflow,task,x,y,parent));
	//workflow.addModel(model,x,y);
}
function openSubProcess(t){
	alert('view subprocess');
	task=t;
}
function openTaskProperties(id){
	if(!is_open_properties_panel)
		_designer.layout('expand','east');
	
	_properties_panel_obj.panel('refresh','${ctx}/wf/procdef/procdef!forTaskProperties.action?taskId='+id);
}
function openProcessProperties(id){
	//alert(id);
	if(!is_open_properties_panel)
		_designer.layout('expand','east');
	_properties_panel_obj.panel('refresh','${ctx}/wf/procdef/procdef!forProcessProperties.action?processId='+id);
}
function openFlowProperties(id){
	//alert(id);
	if(!is_open_properties_panel)
		_designer.layout('expand','east');
	_properties_panel_obj.panel('refresh','${ctx}/wf/procdef/procdef!forLineProperties.action?flowId='+id);
}
function deleteModel(id){
	var task = workflow.getFigure(id);
	workflow.removeFigure(task);
}
function redo(){
	workflow.getCommandStack().redo();
}
function undo(){
	workflow.getCommandStack().undo();
}
function saveProcessDef(){
	var xml = workflow.toXML();
	//alert(workflow.process.getVariablesJSONObject());
	//alert(workflow.process.getVariablesJSONObject());
	//return;
	jq.ajax({
		url:"${ctx}/wf/procdef/procdef!saveProcessDescriptor.action",
		type: 'POST',
		data:{
			processDescriptor:xml,
			processName:workflow.process.name,
			processVariables:workflow.process.getVariablesJSONObject()
		},
		dataType:'json',
		error:function(){
			//$.messager.alert("<s:text name='label.common.error'></s:text>","<s:text name='message.common.save.failure'></s:text>","error");
			return "";
		},
		success:function(data){
			if(data.result){
				jq.messager.alert('Info','Save Successfully!','info');
			}else{
				jq.messager.alert('Error',data.message,'error');
			}
		}	
	}); 
	
}
function exportProcessDef(obj){
	obj.href="${ctx}/wf/procdef/procdef!exportProcessDef.action?procdefId="+processDefinitionId+"&processName="+processDefinitionName;
}
//-->
</script>

<body id="designer" class="easyui-layout">
	<div region="west" split="true" iconCls="palette-icon" title="Palette" style="width:150px;">
		<div class="easyui-accordion" fit="true" border="false">
<!--				<div id="connection" title="Connection" iconCls="palette-menu-icon" class="palette-menu">-->
<!--					<a href="##" class="easyui-linkbutton" plain="true" iconCls="sequence-flow-icon">SequenceFlow</a><br>-->
<!--				</div>-->
				<div id="event" title="Event" iconCls="palette-menu-icon" class="palette-menu">
					<a href="##" class="easyui-linkbutton" plain="true" iconCls="start-event-icon">Start</a><br>
					<a href="##" class="easyui-linkbutton" plain="true" iconCls="end-event-icon">End</a><br>
				</div>
				<div id="task" title="Task" iconCls="palette-menu-icon" selected="true" class="palette-menu">
					<a href="##" class="easyui-linkbutton" plain="true" iconCls="user-task-icon" wfModel="UserTask">User Task</a><br>
					<a href="##" class="easyui-linkbutton" plain="true" iconCls="manual-task-icon" wfModel="ManualTask">Manual Task</a><br>
					<a href="##" class="easyui-linkbutton" plain="true" iconCls="service-task-icon" wfModel="ServiceTask">Service Task</a><br>
					<a href="##" class="easyui-linkbutton" plain="true" iconCls="script-task-icon" wfModel="ScriptTask">Script Task</a><br>
					<a href="##" class="easyui-linkbutton" plain="true" iconCls="mail-task-icon" wfModel="MailTask">Mail Task</a><br>
					<a href="##" class="easyui-linkbutton" plain="true" iconCls="receive-task-icon" wfModel="ReceiveTask">Receive Task</a><br>
					<a href="##" class="easyui-linkbutton" plain="true" iconCls="business-rule-task-icon" wfModel="BusinessRuleTask">Business Rule Task</a><br>
					<a href="##" class="easyui-linkbutton" plain="true" iconCls="subprocess-icon" wfModel="SubProcess" modelType="container">SubProcess</a><br>
					<a href="##" class="easyui-linkbutton" plain="true" iconCls="callactivity-icon" wfModel="CallActivity">CallActivity</a><br>
				</div>
				<div id="gateway" title="Gateway" iconCls="palette-menu-icon" class="palette-menu">
					<a href="##" class="easyui-linkbutton" plain="true" iconCls="parallel-gateway-icon" wfModel="ParallelGateway" iconImg="${ctx}/js/designer/icons/type.gateway.parallel.png">ParallelGateway</a><br>
					<a href="##" class="easyui-linkbutton" plain="true" iconCls="exclusive-gateway-icon" wfModel="ExclusiveGateway" iconImg="${ctx}/js/designer/icons/type.gateway.exclusive.png">ExclusiveGateway</a><br>
				</div>
				<div id="boundary-event" title="Boundary event" iconCls="palette-menu-icon" class="palette-menu">
					<a href="##" class="easyui-linkbutton" plain="true" iconCls="timer-boundary-event-icon">TimerBoundaryEvent</a><br>
					<a href="##" class="easyui-linkbutton" plain="true" iconCls="error-boundary-event-icon">ErrorBoundaryEvent</a><br>
				</div>
		</div>
	</div>
	<div id="process-panel" region="center" split="true"  iconCls="process-icon" title="Process">
		<%@ include file="diagram.jsp" %>
	</div>
	<div id="properties-panel" region="east" split="true" iconCls="properties-icon" title="Properties" style="width:500px;">
		
	</div>
	
	<!-- toolbar -->
	<div id="toolbar-panel" region="north" border="false" style="height:36px;background:#E1F0F2;">
		<div style="background:#E1F0F2;padding:5px;">
			<a href="javascript:void(0)" id="sb1" class="easyui-splitbutton" menu="#edit-menu" iconCls="icon-edit">Edit</a>
<!--			<a href="javascript:void(0)" id="sb2" class="easyui-splitbutton" menu="#mm2" iconCls="icon-ok" onclick="javascript:alert(workflow.toXML())">Ok</a>-->
<!--			<a href="javascript:void(0)" id="mb2" class="easyui-menubutton" menu="#xml/diagram" onclick="viewXMLOrDiagram()">XML/Diagram</a>-->
			<a href="javascript:void(0)" id="mb3" class="easyui-menubutton" menu="#mm3" iconCls="icon-help">Help</a>
		</div>
		<div id="edit-menu" style="width:150px;">
		<div iconCls="icon-undo" onclick="undo()">Undo</div>
		<div iconCls="icon-redo" onclick="redo()">Redo</div>
		<div class="menu-sep"></div>
<!--		<div onclick="openProcessDef()">Open</div>-->
		<div iconCls="icon-save" onclick="saveProcessDef()">Save</div>
		<div><a href="#" onclick="exportProcessDef(this)">Export</a></div>
<!--		<div class="menu-sep"></div>-->
<!--		<div>-->
<!--			<span>Toolbar</span>-->
<!--			<div style="width:150px;">-->
<!--				<div>Address</div>-->
<!--				<div>Link</div>-->
<!--				<div>Navigation Toolbar</div>-->
<!--				<div>Bookmark Toolbar</div>-->
<!--				<div class="menu-sep"></div>-->
<!--				<div>New Toolbar...</div>-->
<!--			</div>-->
<!--		</div>-->
<!--		<div iconCls="icon-remove">Delete</div>-->
<!--		<div>Select All</div>-->
		</div>
		<div id="mm3" style="width:150px;">
			<div>Help</div>
			<div class="menu-sep"></div>
			<div>About</div>
		</div>
	</div>
	<!-- task context menu -->
	<div id="task-context-menu" class="easyui-menu" style="width:120px;">
		<div id="properties-task-context-menu" iconCls="properties-icon">Properties</div>
		<div id="delete-task-context-menu" iconCls="icon-remove">Delete</div>
	</div>
	<!-- form configuration window -->
	<div id="form-win" title="Form Configuration" style="width:750px;height:600px;">
	</div>
	<!-- listener configuration window -->
	<div id="listener-win" title="Listener Configuration" style="width:750px;height:500px;">
	</div>
	<!-- candidate configuration window -->
	<div id="task-candidate-win" title="" style="width:750px;height:500px;">
	</div>
</body>
</html>
<script type="text/javascript">
<!--
	createCanvas(false);
//-->
</script>