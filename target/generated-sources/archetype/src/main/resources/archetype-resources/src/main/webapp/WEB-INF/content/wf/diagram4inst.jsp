#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML ${version} Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
			<meta content="text/html; charset=UTF-8" http-equiv="content-type">
		  <title>Process Diagram</title>
		  <%@ include file="/common/header.jsp" %>
		  <link href="${symbol_dollar}{ctx}/js/designer/designer.css" type="text/css" rel="stylesheet"/>
  			
        <!-- common, all times required, imports -->
        <SCRIPT src='${symbol_dollar}{ctx}/js/draw2d/wz_jsgraphics.js'></SCRIPT>          
        <SCRIPT src='${symbol_dollar}{ctx}/js/draw2d/mootools.js'></SCRIPT>          
        <SCRIPT src='${symbol_dollar}{ctx}/js/draw2d/moocanvas.js'></SCRIPT>                        
        <SCRIPT src='${symbol_dollar}{ctx}/js/draw2d/draw2d.js'></SCRIPT>


        <!-- example specific imports -->
        <SCRIPT src="${symbol_dollar}{ctx}/js/designer/MyCanvas.js"></SCRIPT>
        <SCRIPT src="${symbol_dollar}{ctx}/js/designer/ResizeImage.js"></SCRIPT>
		<SCRIPT src="${symbol_dollar}{ctx}/js/designer/event/Start.js"></SCRIPT>
		<SCRIPT src="${symbol_dollar}{ctx}/js/designer/event/End.js"></SCRIPT>
		<SCRIPT src="${symbol_dollar}{ctx}/js/designer/connection/MyInputPort.js"></SCRIPT>
		<SCRIPT src="${symbol_dollar}{ctx}/js/designer/connection/MyOutputPort.js"></SCRIPT>
		<SCRIPT src="${symbol_dollar}{ctx}/js/designer/connection/DecoratedConnection.js"></SCRIPT>
		<SCRIPT src="${symbol_dollar}{ctx}/js/designer/task/Task.js"></SCRIPT>
		<SCRIPT src="${symbol_dollar}{ctx}/js/designer/task/UserTask.js"></SCRIPT>
		<SCRIPT src="${symbol_dollar}{ctx}/js/designer/task/ManualTask.js"></SCRIPT>
		<SCRIPT src="${symbol_dollar}{ctx}/js/designer/gateway/ExclusiveGateway.js"></SCRIPT>
		<SCRIPT src="${symbol_dollar}{ctx}/js/designer/gateway/ParallelGateway.js"></SCRIPT>
		<SCRIPT src="${symbol_dollar}{ctx}/js/designer/designer.js"></SCRIPT>
		
		<link href="${symbol_dollar}{ctx}/js/jQueryBubblePopup/jquery.bubblepopup.v2.3.1.css" type="text/css" rel="stylesheet"/>
		<script src="${symbol_dollar}{ctx}/js/jQueryBubblePopup/jquery.bubblepopup.v2.3.1.min.js" type="text/javascript"></script>	
			
</head>
<script type="text/javascript">
<!--
var activities='<%=request.getAttribute("_wf_activities_list")%>';
var processDefinitionId="<%=request.getAttribute("_wf_process_definition_id")%>";
var processDefinitionVariables=<%=request.getAttribute("_process_def_variables")%>;
function setHightlight(){
	var activityList=jQuery.parseJSON(activities);
	jq.each(activityList,function(index,value){
			var taskId = value.actKey;
			var taskName = value.taskName;
			var taskAssignment = value.taskAssignment;
			var taskStartTime = value.startTime;
			var processName = value.procName;
			//alert(taskId);
			var task = workflow.getFigure(taskId);
			task.setHighlight();
			
			var jqTask = jq(task.getHTMLElement());
			jqTask.CreateBubblePopup();
			jqTask.mouseover(function(event){
				//var targetX = event.clientX;
			    //var targetY = event.clientY-15;
			    
			    jq(this).ShowBubblePopup({
					innerHtml: "<ul><li><s:text name='lable.wf.process.diagram.process'></s:text>:"+processName
						+"</li><li><s:text name='lable.wf.process.diagram.status'></s:text>:"+taskName
						+"</li><li><s:text name='lable.wf.process.diagram.assignment'></s:text>:"+taskAssignment
						+"</li><li><s:text name='lable.wf.process.diagram.start.time'></s:text>:"+taskStartTime
						+"</li></ul>",		
					innerHtmlStyle: { color:'${symbol_pound}333333', 'text-align':'left','font-size':'14px' },							
					themeName: 	'azure',
					themePath: 	'${symbol_dollar}{ctx}/js/jQueryBubblePopup/jquerybubblepopup-theme',
					selectable:true,
					openingSpeed:0,
					closingSpeed:0								 
			  });
				  /*
			    var _wf_acti_info = jq('${symbol_pound}task-tip-'+taskId);
				if(_wf_acti_info.length == 0){
					_wf_acti_info=jq('<div></div>');
					
					_wf_acti_info.addClass("task-tip");
					
					_wf_acti_info.attr({
							id:'task-tip-'+taskId
						});
					_wf_acti_info.appendTo(jq(document.body));
				}
			    _wf_acti_info.html("<ul><li><s:text name='lable.wf.process.diagram.process'></s:text>:"+processName
						+"</li><li><s:text name='lable.wf.process.diagram.status'></s:text>:"+taskName
						+"</li><li><s:text name='lable.wf.process.diagram.assignment'></s:text>:"+taskAssignment
						+"</li><li><s:text name='lable.wf.process.diagram.start.time'></s:text>:"+taskStartTime
						+"</li></ul>");
				_wf_acti_info.offset({
					top:targetY-100,
					left:targetX
					});
				_wf_acti_info.show();
				*/
			}
			/*
			,function(event){
				//var _wf_acti_info = jq('${symbol_pound}task-tip-'+taskId);
				//_wf_acti_info.remove();
			}
			*/
			);
	});	
}
/*
function onTaskMouseEnter(task){
	alert(111);
	_wf_acti_info.offset({
		top:200,
		left:200
	});
	_wf_acti_info.show();
}
function onTaskMouseLeave(task){
	_wf_acti_info.hide();
}
*/
//-->
</script>
<body class="easyui-layout">
	<div id="process-panel" region="center" iconCls="process-icon" title="Process">
			<%@ include file="designer/diagram.jsp" %>
	</div>
	
</body>
</html>
<script type="text/javascript">
<!--
createCanvas(true);
//-->
</script>