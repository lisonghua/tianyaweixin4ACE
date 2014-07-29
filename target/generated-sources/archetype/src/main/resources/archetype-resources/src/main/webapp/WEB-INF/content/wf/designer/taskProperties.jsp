#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<script type="text/javascript">
<!--
tid = "<%=request.getParameter("taskId")%>";
task = workflow.getFigure(tid);
jq(function(){
	loadTaskPropertyPage();
});
function loadTaskPropertyPage(){
	//alert(task.type);
	if(task.type=="draw2d.UserTask")
		_properties_panel_obj.panel('refresh','${symbol_dollar}{ctx}/wf/procdef/procdef!forUserTaskProperties.action?taskId='+tid);
	else if(task.type=="draw2d.ManualTask")
		_properties_panel_obj.panel('refresh','${symbol_dollar}{ctx}/wf/procdef/procdef!forManualTaskProperties.action?taskId='+tid);
	else if(task.type=="draw2d.ServiceTask")
		_properties_panel_obj.panel('refresh','${symbol_dollar}{ctx}/wf/procdef/procdef!forServiceTaskProperties.action?taskId='+tid);
	else if(task.type=="draw2d.ScriptTask")
		_properties_panel_obj.panel('refresh','${symbol_dollar}{ctx}/wf/procdef/procdef!forScriptTaskProperties.action?taskId='+tid);
	else if(task.type=="draw2d.ReceiveTask")
		_properties_panel_obj.panel('refresh','${symbol_dollar}{ctx}/wf/procdef/procdef!forReceiveTaskProperties.action?taskId='+tid);
	else if(task.type=="draw2d.MailTask")
		_properties_panel_obj.panel('refresh','${symbol_dollar}{ctx}/wf/procdef/procdef!forMailTaskProperties.action?taskId='+tid);
	else if(task.type=="draw2d.BusinessRuleTask")
		_properties_panel_obj.panel('refresh','${symbol_dollar}{ctx}/wf/procdef/procdef!forBusinessRuleTaskProperties.action?taskId='+tid);
	else if(task.type=="draw2d.CallActivity")
		_properties_panel_obj.panel('refresh','${symbol_dollar}{ctx}/wf/procdef/procdef!forCallActivityProperties.action?taskId='+tid);
}
//-->
</script>