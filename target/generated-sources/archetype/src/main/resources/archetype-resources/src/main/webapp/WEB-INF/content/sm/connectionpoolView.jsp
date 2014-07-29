#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Map" %>
<%@page import="${package}.framework.tools.database.ConnectPoolMonitor.JbossConnectionPoolProperty" %>
<%@ include file="/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML ${version} Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title></title>
	<%@ include file="/common/header.jsp" %>
</head>
<script type="text/javascript">
<!--
${symbol_dollar}(function(){
	_editor_panel_obj=${symbol_dollar}('${symbol_pound}_editor_panel').panel({
			height:370
		});
});

function closeWin(){
	parent.closeWin();
}
function refresh(){
	window.location.reload();
}
//-->
</script>
<body>
<div id="_editor_panel" style="background:${symbol_pound}fafafa;padding:10px;" >
		<table>
			<tr>
				<td><s:text name='label.sm.server.ip'></s:text>：</td>
				<td>${symbol_dollar}{server.ip}</td>
			</tr>
			<tr>
				<td><s:text name='label.sm.connectionpool.jndiName'></s:text>：</td>
				<td>${symbol_dollar}{jndiName}</td>
			</tr>
			<%
				Map<String,String> connInfo = (Map<String,String>)request.getAttribute("_connectionpool_info");
				for(JbossConnectionPoolProperty property : JbossConnectionPoolProperty.values()){
					String key = property.toString();
					String value = connInfo.get(key);
					%>
						<tr>
							<td><%=key %>：</td>
							<td><%=value %></td>
						</tr>
					<%
				}
			%>
		</table>
		<br />
		<div style="text-align: center;">
			<a href="${symbol_pound}${symbol_pound}" onclick="refresh()" class="easyui-linkbutton" id="btn-save" icon="icon-save"><s:text name='button.sm.connectionpool.refresh'></s:text></a>
			<a href="${symbol_pound}${symbol_pound}" onclick="closeWin()" class="easyui-linkbutton" id="btn-cancel" icon="icon-cancel"><s:text name='button.common.return'></s:text></a>
		</div>
</div>
</body>
</html>