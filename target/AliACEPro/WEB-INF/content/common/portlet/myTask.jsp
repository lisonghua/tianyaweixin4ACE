<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<script type="text/javascript">
<!--
$(function(){
	_my_task_list_grid=$('#_my_task_list').datagrid({
		url:'${ctx}/wf/taskinst/taskinst!search.action',//加载表格数据的URL
		singleSelect:true,
		//height:300,
		fit:true,
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
//-->
</script>
<table id="_my_task_list">
	<thead>
		<tr>
			<th field="APPLYTYPE" width="100" align="middle" sortable="true">Type</th>
			<th field="APPLYDATE" width="100" align="middle" sortable="true">Date</th>
			<th field="APPLICANT" width="100" align="middle" sortable="true">Applicant</th>
			<th field="action" width="100" align="middle" formatter="myTaskActionFormatter"><s:text name='label.sm.common.action'></s:text></th>
		</tr>
	</thead>
</table>