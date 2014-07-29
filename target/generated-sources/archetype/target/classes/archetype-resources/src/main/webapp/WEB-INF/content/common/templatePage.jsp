#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<%
	LogonUser logonUser= SpringSecurityUtils.getCurrentUser();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML ${version} Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>Home Page</title>
	<%@ include file="/common/header.jsp" %>
</head>
<script type="text/javascript">
<!--
${symbol_dollar}(function(){
	_pw_window=${symbol_dollar}('${symbol_pound}setPwWindow').window({   
	    closed:true,
	    collapsible:false,
	    minimizable:false,
	    maximizable:false,
	    modal:true,
	    shadow:true,
	    onClose:closePwForm
	});
	_pw_frame=${symbol_dollar}('${symbol_pound}setPwFrame');
});
function setPassword(){
	_pw_window.window('open');
	_pw_frame.attr({
		src:"${symbol_dollar}{ctx}/pm/user/user!forUpdatePassword.action?userId=<%=logonUser.getUserId()%>"
	});
}
function closePwForm(){
	_pw_frame.attr({
		src:"about:blank"
	});
}
function closePwWindow(){
	_pw_window.window('close');
}
//-->
</script>
<body class="easyui-layout">
	<div region="west" split="true" iconCls="homepage-user-welcome" title="<s:text name='label.common.welcome'></s:text> <%=logonUser.getName() %>!" style="width:250px;">
		<div class="easyui-layout" fit="true">
			<div region="north" border="false" style="height:80px;">
				<%@ include file="userInfo.jsp" %>
			</div>
			<div region="center" iconCls="homepage-menu-header" title="<s:text name='menu.text.root'></s:text>" split="true">
				<div class="homepage-menu" style="height: 100%;">
					<%@ include file="menu.jsp" %>
				</div>
			</div>
		</div>
	</div>
	<div region="center" split="true" style="overflow:no;">
		<div class="easyui-layout" fit="true">
			<div region="north" border="false" style="height:36px;">
				<%@ include file="banner.jsp" %>
			</div>
			<div region="center" split="true" title="" style="overflow:auto;padding:5px;">
				<%@ include file="function.jsp" %>
			</div>
		</div>
	</div>
	<div id="setPwWindow" title="<s:text name='button.login.update.password'></s:text>" style="width:400px;height:300px;">
		<iframe id="setPwFrame" name="setPwFrame" frameborder="0" width="100%" height="100%"></iframe>  
	</div> 
</body>
</html>