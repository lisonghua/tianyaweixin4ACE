<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<%@ page
	import="org.springframework.security.web.authentication.AbstractAuthenticationProcessingFilter"%>
<%@ page
	import="org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter"%>
<%@ page
	import="org.springframework.security.core.AuthenticationException"%>
<%@ page
	import="org.springframework.security.authentication.DisabledException"%>
<%@ page
	import="java.util.Locale"%>
<%@ page import="com.dalian.genpact.framework.common.utils.LocalizeUtil" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/common/header.jsp"%>
<title><s:text name='label.logon.page.title'></s:text></title>
<script>
	$(document).ready(function() {
			$("#loginForm").validate({
				rules:{
					j_username:{
						remote:"${ctx}/pm/user/user!checkUserIsExisting.action"
					}
				},
				messages:{
					j_username:{
						remote:'<s:text name="message.login.user.not.existing"></s:text>'
					}
				},
				showErrors:showErrors
			});
			$('#logonPanel').panel({});
			$('#j_password').bind('keyup',function(e){
					var keyCode = e.keyCode || e.charCode;
					if(keyCode==13){
						logon();
					}
				});
			$('#j_username').focus();
		});
	function logon() {
		$('#loginForm').submit();
	}
</script>
</head>
<body id="doc3"  scroll="no" class="loginpage-bg">
		<table width="100%" height="100%" class="loginpage-tab">
			<tr>
			<td colspan="3">&nbsp;</td>
			</tr>
			<tr>
			<td colspan="3">&nbsp;</td>
			</tr>
			<tr>
			<td colspan="3">&nbsp;</td>
			</tr>
			<tr>
			<td colspan="3">&nbsp;</td>
			</tr>
			<tr>
				<td width="40%"></td>
				<td align="center" valign="top" height="400">
					<div id="logonPanel" title="<s:text name='label.login.title'></s:text>" style="width:400px; height: 200px;">
						<form id="loginForm" action="${ctx}/j_spring_security_check"
						method="post">
						<%
							String message = "";
							AuthenticationException exception = (AuthenticationException) session
									.getAttribute(AbstractAuthenticationProcessingFilter.SPRING_SECURITY_LAST_EXCEPTION_KEY);
							if (exception != null) {
								message = exception.getMessage();
								if (message == null || "".equals(message))
									message = LocalizeUtil.getLocalizedText("message.login.logon.unsuccess",session);
						%>
						<div><%=message%></div>
						<%
							}
						%>
						<table>
							<tr>
								<td align="right"><s:text name="label.login.userName"></s:text>:</td>
								<td align="left"><input type='text' id='j_username'
									name='j_username' class="easyui-validatebox" required="true" /></td>
							</tr>
							<tr>
								<td align="right"><s:text name="label.login.password"></s:text>:</td>
								<td align="left"><input type='password' id='j_password'
									name='j_password' class="easyui-validatebox" required="true" /></td>
							</tr>
							<tr>
								<!--<input type="checkbox" name="_spring_security_remember_me"/>两周内记住我-->
								<td colspan='2' align="center"><a id="loginbt" href="###" class="easyui-linkbutton" onclick="logon()"><s:text name="button.login.logon"></s:text></a></td>
							</tr>
							<tr>
								<td colspan='2' align="right">
								<!-- 指定URL为中文的语言设置 -->   
				                  	<s:url id="chinese" action="login.action">   
				                         <s:param name="request_locale">zh_CN</s:param>   
				                  	</s:url>   
				                 	<!-- 中文语言设置的链接定义 -->   
				                  	<s:a href="%{chinese}"><img src="${ctx}/image/zh_CN.gif" border="0" alt="<s:text name="label.lang.zh"></s:text>"/></s:a>  
									<s:url id="english" action="login.action">   
				                         <!-- 参数request_locale设置英文 -->   
				                         <s:param name="request_locale">en_US</s:param>   
				                  	</s:url>   
				                  	<!-- 英文语言设置的链接定义 -->   
				                  	<s:a href="%{english}"><img src="${ctx}/image/en_US.gif" border="0" alt="<s:text name="label.lang.us"></s:text>"/></s:a>    
				                </td>
							</tr>
						</table>
						</form>
					</div>
				</td>
				<td width="40%"></td>
			</tr>
			<tr>
				<td colspan="3">&nbsp;</td>
			</tr>
		</table>
</body>
</html>

