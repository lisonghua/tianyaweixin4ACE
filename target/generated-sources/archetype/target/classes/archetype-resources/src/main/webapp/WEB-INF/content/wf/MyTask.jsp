#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML ${version} Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title></title>
	<%@ include file="/common/header.jsp" %>
</head>
<script type="text/javascript">
<!--
${symbol_dollar}(function(){
	_list_panel_obj=${symbol_dollar}('${symbol_pound}_list_panel').panel({
		//height:600,
		border:false,
		noheader:true,
		top:0,
		left:0
	});
	_my_task_list_grid=${symbol_dollar}('${symbol_pound}_my_task_list').datagrid({
		url:'${symbol_dollar}{ctx}/wf/taskinst/taskinst!search.action',//加载表格数据的URL
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
	_filter_start_date=${symbol_dollar}('${symbol_pound}startDate').datebox({
		formatter:simpleDateFormatter,
		parser:simpleDateParser
		});
	_filter_end_date=${symbol_dollar}('${symbol_pound}endDate').datebox({
		formatter:simpleDateFormatter,
		parser:simpleDateParser
		});
});
function myTaskActionFormatter(value,rowData,rowIndex){
	var taskId = rowData.TASKID;
	var definitionId = rowData.DEFINITIONID;
	var instanceId = rowData.INSTANCEID;
	var p = '<img onclick="performMyTask(${symbol_escape}''+definitionId+'${symbol_escape}',${symbol_escape}''+instanceId+'${symbol_escape}',${symbol_escape}''+taskId+'${symbol_escape}')" src="${symbol_dollar}{ctx}/image/edit.gif" title="'+"<s:text name='editMyTask'></s:text>"+'" style="cursor:hand;"/>';
	return p;
}
function performMyTask(definitionId,instanceId,taskId){
	//alert(taskId);
	${symbol_dollar}.ajax({
		url:"${symbol_dollar}{ctx}/wf/taskinst/taskinst!getFormKey.action",
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
			<td><a href="${symbol_pound}" class="easyui-linkbutton" iconCls="icon-search" onclick="searchByFilter();"><s:text name='button.common.search'></s:text></a></td>
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