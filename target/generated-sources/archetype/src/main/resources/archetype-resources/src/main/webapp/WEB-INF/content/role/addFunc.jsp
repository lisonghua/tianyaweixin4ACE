#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>

<script type="text/javascript">
<!--
${symbol_dollar}(function(){
	_assignFuncTab=${symbol_dollar}('${symbol_pound}assignFuncTab').tabs({
			//width:950,
			//height:350
			//fit:true
		});
});
function toBack(){
	window.location="${symbol_dollar}{ctx}/pm/role/role!forQuery.action";
	return false;
}
//-->
</script>
<body>
<div id="assignFuncTab">
    <div title="<s:text name='label.pm.common.selected'></s:text>"  closable="false" style="overflow:hidden;padding:5px;" cache="false" href="${symbol_dollar}{ctx}/pm/role/role!forSelectedFunc.action?roleId=${symbol_dollar}{roleId}">
<!--	<iframe src="${symbol_dollar}{ctx}/pm/group/group!forUnselectedUser.action?groupId=${symbol_dollar}{groupId}" frameborder="0" width="900" height="300" marginheight="0" marginwidth="0" scrolling="no"></iframe>-->
    </div>
	
    <div title="<s:text name='label.pm.common.unselected'></s:text>"  closable="false" style="overflow:hidden;padding:5px;" cache="false" href="${symbol_dollar}{ctx}/pm/role/role!forUnselectedFunc.action?roleId=${symbol_dollar}{roleId}">
<!--    <iframe src="${symbol_dollar}{ctx}/pm/group/group!forSelectedUser.action?groupId=${symbol_dollar}{groupId}" frameborder="0" width="900" height="300" marginheight="0" marginwidth="0" scrolling="no"></iframe>-->

    </div>
</div>



