<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
		<meta content="text/html; charset=UTF-8" http-equiv="content-type">
		  <title>Process Diagram</title>
		  <%@ include file="/common/header.jsp" %>
		  <link href="${ctx}/js/designer/designer.css" type="text/css" rel="stylesheet"/>
  			
        <!-- common, all times required, imports -->
        <SCRIPT src='${ctx}/js/draw2d/wz_jsgraphics.js'></SCRIPT>          
        <SCRIPT src='${ctx}/js/draw2d/mootools.js'></SCRIPT>          
        <SCRIPT src='${ctx}/js/draw2d/moocanvas.js'></SCRIPT>                        
        <SCRIPT src='${ctx}/js/draw2d/draw2d.js'></SCRIPT>


        <!-- example specific imports -->
        <SCRIPT src="${ctx}/js/designer/MyCanvas.js"></SCRIPT>
        <SCRIPT src="${ctx}/js/designer/ResizeImage.js"></SCRIPT>
		<SCRIPT src="${ctx}/js/designer/event/Start.js"></SCRIPT>
		<SCRIPT src="${ctx}/js/designer/event/End.js"></SCRIPT>
		<SCRIPT src="${ctx}/js/designer/connection/MyInputPort.js"></SCRIPT>
		<SCRIPT src="${ctx}/js/designer/connection/MyOutputPort.js"></SCRIPT>
		<SCRIPT src="${ctx}/js/designer/connection/DecoratedConnection.js"></SCRIPT>
		<SCRIPT src="${ctx}/js/designer/task/Task.js"></SCRIPT>
		<SCRIPT src="${ctx}/js/designer/task/UserTask.js"></SCRIPT>
		<SCRIPT src="${ctx}/js/designer/task/ManualTask.js"></SCRIPT>
		<SCRIPT src="${ctx}/js/designer/gateway/ExclusiveGateway.js"></SCRIPT>
		<SCRIPT src="${ctx}/js/designer/gateway/ParallelGateway.js"></SCRIPT>
		<SCRIPT src="${ctx}/js/designer/designer.js"></SCRIPT>	
</head>
<script type="text/javascript">
<!--
var processDefinitionId="<%=request.getParameter("id")%>";
var processDefinitionVariables=<%=request.getAttribute("_process_def_variables")%>;
jq(function(){
	
});
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