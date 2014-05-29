<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<script type="text/javascript">
<!--
jq(function(){
	_task_candidate_unselected_group_panel_obj=jq('#_task_candidate_unselected_group_panel').panel({
		//height:600,
		border:false,
		noheader:true,
		top:0,
		left:0
	});
	_task_candidate_unselected_group_grid=jq('#_task_candidate_unselected_group_table').datagrid({
		title:"<s:text name='label.pm.group.list'></s:text>",
		url:'${ctx}/wf/procdef/procdef!searchCandidateGroup.action',
		//singleSelect:true,
		idField:'groupId',
		height:400,
		pagination:true,
		pageSize:15,
		pageNumber:1,
		pageList:[10,15],
		rownumbers:true,
		sortName:'name',
	    sortOrder:'asc',
	    striped:true,
	    onLoadSuccess:function(data){
		   	var rows = data.rows;
		    for(var i=0;i<rows.length;i++){
			    if(task.getCandidateGroup(rows[i].name)!=null){
					jq(this).datagrid('selectRow',i);
				}
			}
		},
	    toolbar:[{
	        text:"<s:text name='button.common.save'></s:text>",
	        iconCls:'icon-save',
	        handler:function(){
	        	addCandidateGroups();
	        }
	    }]
	});
});
function searchTaskCandidateUnselectedGroup(){
	var name=document.getElementById("filter_LIKES_name").value;
	_task_candidate_unselected_group_grid.datagrid('reload',{
		filter_LIKES_name:name
		});
}
function addCandidateGroups(){
	var rows = _task_candidate_unselected_group_grid.datagrid("getSelections");
	for(var i=0;i<rows.length;i++){
		var group = rows[i];
		task.addCandidateGroup(group.name);
	}
	loadTaskCandidateGroups();
	_task_candidate_win.window('close');
}
//-->
</script>
<div id="_task_candidate_unselected_group_panel" style="padding:5px;">
<div>
	<table border="0">
		<tr>
			<td><s:text name='label.pm.group.name'></s:text>:</td>
			<td><input type="text" name="filter_LIKES_name" value="" size="9"/></td>
			<td><a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="searchTaskCandidateUnselectedGroup();"><s:text name='button.common.search'></s:text></a></td>
		</tr>
	</table>
</div>
<div>
<table id="_task_candidate_unselected_group_table">
	<thead>
		<tr>
			<th field="groupId" align="middle" checkbox="true"></th>
			<th field="name" width="100" align="middle" sortable="true"><s:text name='label.pm.group.name'></s:text></th>
			<th field="remark" width="300" align="middle"><s:text name='label.pm.group.remark'></s:text></th>
		</tr>
	</thead>
</table>
</div>
</div>