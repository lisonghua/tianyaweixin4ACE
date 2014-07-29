#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page
	import="org.springframework.security.web.authentication.AbstractAuthenticationProcessingFilter"%>
<%@ page
	import="org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter"%>
<%@ page
	import="org.springframework.security.core.AuthenticationException"%>
<%@ page
	import="org.springframework.security.authentication.DisabledException"%>
<%@ page import="java.util.Locale"%>
<%@ page import="${package}.framework.common.utils.LocalizeUtil"%>
<%
	AuthenticationException exception = (AuthenticationException) session
			.getAttribute(AbstractAuthenticationProcessingFilter.SPRING_SECURITY_LAST_EXCEPTION_KEY);
	if (exception != null) {
		String message = exception.getMessage();
		if (message == null || "".equals(message))
			message = LocalizeUtil.getLocalizedText("message.login.logon.unsuccess", session);
		out.print(message);
	}
%>