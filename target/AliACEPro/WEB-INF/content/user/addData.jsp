<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>

<script type="text/javascript">
<!--
$(function(){
	_assignRoleTab=$('#assignRoleTab').tabs({
			width:950,
			height:350
			//fit:true
		});
});
function toBack(){
	window.location="${ctx}/pm/user/user!forQuery.action";
}
//-->
</script>
<body>
<div id="assignRoleTab">
    <div title="<s:text name='label.pm.user.selected'></s:text>"  closable="false" style="overflow:auto;padding:5px;" cache="false" href="${ctx}/pm/user/user!forSelectedData.action?userId=${userId}">
<!--	<iframe src="${ctx}/pm/group/group!forUnselectedUser.action?groupId=${groupId}" frameborder="0" width="900" height="300" marginheight="0" marginwidth="0" scrolling="no"></iframe>-->
    </div>
	
    <div title="<s:text name='label.pm.user.unselected'></s:text>"  closable="false" style="overflow:auto;padding:5px;" cache="false" href="${ctx}/pm/user/user!forUnselectedData.action?userId=${userId}">
<!--    <iframe src="${ctx}/pm/group/group!forSelectedUser.action?groupId=${groupId}" frameborder="0" width="900" height="300" marginheight="0" marginwidth="0" scrolling="no"></iframe>-->

    </div>
</div>


