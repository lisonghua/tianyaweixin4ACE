<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title></title>
	<%@ include file="/common/header.jsp" %>
</head>
<script type="text/javascript">
<!--
$(function(){
	$('#_list_table_history').datagrid({
		title:'',
		url:'${ctx}/wf/history/history!search.action?procinstId=${id}',//加载表格数据的URL
		singleSelect:true,
		height:400,
		idField:'hid',
		pagination:true,
		pageSize:15,
		pageNumber:1,
		pageList:[10,15],
		rownumbers:true,
		sortName:'endTime',
	    sortOrder:'asc',
	    striped:true
	});
});

//-->
</script>
<body>
<!--***************************表格部分开始*************************************-->
<table id="_list_table_history">
	<thead>
		<tr>
			<th field="taskName" width="100" align="middle"><s:text name='lable.wf.process.history.task.name'></s:text></th>
			<th field="executor" width="100" align="middle" ><s:text name='lable.wf.process.history.task.executor'></s:text></th>
			<th field="wfAction" width="100" align="middle" ><s:text name='lable.wf.process.history.task.action'></s:text></th>
			<th field="startTime" width="100" align="middle" sortable="true"><s:text name='lable.wf.process.history.task.start.time'></s:text></th>
			<th field="endTime" width="100" align="middle" sortable="true"><s:text name='lable.wf.process.history.task.end.time'></s:text></th>
		</tr>
	</thead>
</table>
<!--***************************表格部分结束*************************************-->
</body>
</html>