#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>

<script type="text/javascript">
<!--
${symbol_dollar}(function(){
	_assignRoleTab=${symbol_dollar}('${symbol_pound}assignRoleTab').tabs({
			width:950,
			height:350
			//fit:true
		});
});
function toBack(){
	window.location="${symbol_dollar}{ctx}/pm/user/user!forQuery.action";
}
//-->
</script>
<body>
<div id="assignRoleTab">
    <div title="<s:text name='label.pm.user.selected'></s:text>"  closable="false" style="overflow:auto;padding:5px;" cache="false" href="${symbol_dollar}{ctx}/pm/user/user!forSelectedData.action?userId=${symbol_dollar}{userId}">
<!--	<iframe src="${symbol_dollar}{ctx}/pm/group/group!forUnselectedUser.action?groupId=${symbol_dollar}{groupId}" frameborder="0" width="900" height="300" marginheight="0" marginwidth="0" scrolling="no"></iframe>-->
    </div>
	
    <div title="<s:text name='label.pm.user.unselected'></s:text>"  closable="false" style="overflow:auto;padding:5px;" cache="false" href="${symbol_dollar}{ctx}/pm/user/user!forUnselectedData.action?userId=${symbol_dollar}{userId}">
<!--    <iframe src="${symbol_dollar}{ctx}/pm/group/group!forSelectedUser.action?groupId=${symbol_dollar}{groupId}" frameborder="0" width="900" height="300" marginheight="0" marginwidth="0" scrolling="no"></iframe>-->

    </div>
</div>


