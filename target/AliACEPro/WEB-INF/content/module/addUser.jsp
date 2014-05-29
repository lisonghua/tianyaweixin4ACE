<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>

<script type="text/javascript">
<!--
$(function(){
	_assignUserTab=$('#assignUserTab').tabs({
			//width:950,
			//height:350
			//fit:true
		});
});
function toBack(){
	window.location="${ctx}/pm/module/module!forQuery.action";
	return false;
}
//-->
</script>
<body>
<div id="assignUserTab">
    <div title="<s:text name='label.pm.common.selected'></s:text>"  closable="false" style="overflow:hidden;padding:5px;" cache="false" href="${ctx}/pm/module/module!forSelectedUser.action?moduleId=${moduleId}">
<!--	<iframe src="${ctx}/pm/group/group!forUnselectedUser.action?groupId=${groupId}" frameborder="0" width="900" height="300" marginheight="0" marginwidth="0" scrolling="no"></iframe>-->
    </div>
	
    <div title="<s:text name='label.pm.common.unselected'></s:text>"  closable="false" style="overflow:hidden;padding:5px;" cache="false" href="${ctx}/pm/module/module!forUnselectedUser.action?moduleId=${moduleId}">
<!--    <iframe src="${ctx}/pm/group/group!forSelectedUser.action?groupId=${groupId}" frameborder="0" width="900" height="300" marginheight="0" marginwidth="0" scrolling="no"></iframe>-->

    </div>
</div>



