<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title></title>
	<%@ include file="/common/header.jsp" %>
</head>
<script type="text/javascript">
<!--
$(function(){
	_list_panel_obj=$('#_list_panel').panel({
		//height:600,
		border:false,
		noheader:true,
		top:0,
		left:0
	});
	_my_task_list_grid=$('#_my_task_list').datagrid({
		url:'${ctx}/wf/taskinst/taskinst!search.action',//加载表格数据的URL
		title:'My Tasks',
		singleSelect:true,
		height:500,
		//fit:true,
		idField:'id',
		pagination:true,
		pageSize:10,
		pageNumber:1,
		pageList:[10,15],
		rownumbers:true,
		sortName:'pi.start_time_',
	    sortOrder:'desc',
	    striped:true
	});
	_filter_start_date=$('#startDate').datebox({
		formatter:simpleDateFormatter,
		parser:simpleDateParser
		});
	_filter_end_date=$('#endDate').datebox({
		formatter:simpleDateFormatter,
		parser:simpleDateParser
		});
});
function myTaskActionFormatter(value,rowData,rowIndex){
	var taskId = rowData.TASKID;
	var definitionId = rowData.DEFINITIONID;
	var instanceId = rowData.INSTANCEID;
	var p = '<img onclick="performMyTask(\''+definitionId+'\',\''+instanceId+'\',\''+taskId+'\')" src="${ctx}/image/edit.gif" title="'+"<s:text name='editMyTask'></s:text>"+'" style="cursor:hand;"/>';
	return p;
}
function performMyTask(definitionId,instanceId,taskId){
	//alert(taskId);
	$.ajax({
		url:"${ctx}/wf/taskinst/taskinst!getFormKey.action",
		type: 'POST',
		data:{
			definitionId:definitionId,
			taskId:taskId
		},
		dataType:'json',
		error:function(){
			return "";
		},
		success:function(data){
			var formKey = data.formKey;
			alert(formKey);
		}	
	}); 
}
function searchByFilter(){
	var type=document.getElementById("applyType").value;
	var startDate=_filter_start_date.datebox('getValue');
	var endDate=_filter_end_date.datebox('getValue');
	_my_task_list_grid.datagrid('reload',{
		procName:type,
		startDate:startDate,
		endDate:endDate
	});
}
//-->
</script>
<body>
<div id="_list_panel" style="padding:5px;">
	<table border="0">
		<tr>
			<td>Type:</td>
			<td><input type="text" name="applyType" id="applyType" value="" size="9"/></td>
			<td>Date:</td>
			<td><input type="text" name="startDate" id="startDate" value="" size="9"/></td>
			<td>-</td>
			<td><input type="text" name="endDate" id="endDate" value="" size="9"/></td>
			<td><a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="searchByFilter();"><s:text name='button.common.search'></s:text></a></td>
		</tr>
	</table>
	<table id="_my_task_list">
		<thead>
			<tr>
				<th field="APPLYTYPE" width="200" align="middle" sortable="true">Type</th>
				<th field="APPLYDATE" width="100" align="middle" sortable="true">Date</th>
				<th field="APPLICANT" width="100" align="middle" sortable="true">Applicant</th>
				<th field="action" width="100" align="middle" formatter="myTaskActionFormatter"><s:text name='label.sm.common.action'></s:text></th>
			</tr>
		</thead>
	</table>
</div>
</body>
</html>