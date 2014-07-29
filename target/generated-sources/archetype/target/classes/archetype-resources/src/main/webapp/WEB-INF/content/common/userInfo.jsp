#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<table border="0" height="100%" width="100%" class="homepage-user-info">
	<tr>
		<td align="left" width="10%"><s:text name='label.pm.user.sso'></s:text>:</td>
		<td><%=logonUser.getSso()%></td>
	</tr>
	<tr>
		<td align="left" width="10%"><s:text name='label.pm.user.title'></s:text>:</td>
		<td></td>
	</tr>
	<tr>
		<td align="left" width="10%"><s:text name='label.pm.user.supervisor'></s:text>:</td>
		<td><%=logonUser.getSupervisor() == null ? " " : logonUser.getSupervisor()%></td>
	</tr>
</table>