<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>Home Page</title>
	<%@ include file="/common/header.jsp" %>
</head>
<script type="text/javascript">
<!--
$(function(){
	_assignUserTab=$('#assignRoleTab').tabs({
			//width:1020,
			//height:430
		});
});
function toBack(){
	window.location="${ctx}/pm/user/user!forQuery.action";
	return false;
}
//-->
</script>
<body>
<div id="assignRoleTab" style="padding:5px;">
    <div title="<s:text name='label.pm.common.selected'></s:text>"  closable="false" style="overflow:hidden;padding:5px;" cache="false" href="${ctx}/pm/user/user!forSelectedRole.action?userId=${userId}">
<!--	<iframe src="${ctx}/pm/group/group!forUnselectedUser.action?groupId=${groupId}" frameborder="0" width="900" height="300" marginheight="0" marginwidth="0" scrolling="no"></iframe>-->
    </div>
	
    <div title="<s:text name='label.pm.common.unselected'></s:text>"  closable="false" style="overflow:hidden;padding:5px;" cache="false" href="${ctx}/pm/user/user!forUnselectedRole.action?userId=${userId}">
<!--    <iframe src="${ctx}/pm/group/group!forSelectedUser.action?groupId=${groupId}" frameborder="0" width="900" height="300" marginheight="0" marginwidth="0" scrolling="no"></iframe>-->

    </div>
</div>

</body>
</html>