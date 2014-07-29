#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<table border="0" width="100%" height="100%" class="homepage-banner">
	<tr>
		<td align="left">
		<embed
			title="Online clocks for your website, blog, myspace"
			src="http://www.respectsoft.com/onlineclock/onlineclock.swf?ccolor=blue"
			quality="high" wmode="transparent" bgcolor="${symbol_pound}ffffff" width="100"
			height="25" align="middle" allowScriptAccess="sameDomain"
			type="application/x-shockwave-flash"
			pluginspage="http://www.macromedia.com/go/getflashplayer" />
		</td>
		<td align="right" width="20%">
			<div id="style-swithch-button" class="blue-style">
				<a class="styleswitch a1" style="CURSOR: pointer" title="<s:text name='label.common.color.orange'></s:text>" rel="orange"></a>
				<a class="styleswitch a2" style="CURSOR: pointer" title="<s:text name='label.common.color.green'></s:text>" rel="green"></a> 
				<a class="styleswitch a3" style="CURSOR: pointer" title="<s:text name='label.common.color.blue'></s:text>" rel="blue"></a>	
				<a class="styleswitch a4" style="CURSOR: pointer" title="<s:text name='label.common.color.gray'></s:text>" rel="gray"></a>	
				<a class="styleswitch a5" style="CURSOR: pointer" title="<s:text name='label.common.color.pink'></s:text>" rel="pink"></a>		
			</div>
		</td>
		<td align="right" class="homepage-banner-bt">
		<a href="${symbol_pound}${symbol_pound}"
			class="easyui-linkbutton" plain="true"
			iconCls="homepage-banner-bt-home" onclick="goHome()">
			<s:text name='button.login.home'></s:text></a> 
		<a href="${symbol_pound}${symbol_pound}"
			class="easyui-linkbutton" plain="true"
			iconCls="homepage-banner-bt-password" onclick="setPassword()">
			<s:text name='button.login.update.password'></s:text></a> 
		<a href="${symbol_pound}${symbol_pound}"
			class="easyui-linkbutton" iconCls="homepage-banner-bt-help"
			plain="true"><s:text name='button.login.help'></s:text></a>
		<%
			Object sso_token = session.getAttribute(SsoAuthenticationProcessingFilter.SPRING_SECURITY_SSO_TOKEN_KEY);
			if(sso_token == null){
		%>
		<a
			href="${symbol_dollar}{ctx}/j_spring_security_logout" class="easyui-linkbutton"
			iconCls="homepage-banner-bt-logout" plain="true"><s:text
			name='button.login.logout'></s:text></a>
		</td>
		<%} %>
	</tr>
</table>