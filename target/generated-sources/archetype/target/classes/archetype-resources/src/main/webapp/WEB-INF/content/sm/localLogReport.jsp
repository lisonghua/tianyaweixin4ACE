#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	_log_report_tabs_obj=${symbol_dollar}('${symbol_pound}_log_report_tabs').tabs({
			width:1000,
			height:440
	});
});
//-->
</script>
<body>
<div id="_log_report_tabs" style="padding:5px">
	<div title="<s:text name='label.sm.ds.report.everydayUserCount.tab'></s:text>"  
	closable="false" style="overflow:auto;padding:5px" cache="false" 
	href="${symbol_dollar}{ctx}/sm/appserver/appserver!forExportAccessNum4App.action?serverId=${symbol_dollar}{serverId}">
</div>
</body>
</html>