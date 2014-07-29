#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<script type="text/javascript">
<!--
jq(function(){
	_task_candidate_users_list=jq('${symbol_pound}task-candidate-users-list').datagrid({
		title:"Candidate Users",
		singleSelect:true,
		height:200,
		//fit:true,
		rownumbers:true,
		striped:true,
		toolbar:[{
	        text:'Add',
	        iconCls:'icon-add',
	        handler:function(){
				_task_candidate_win.window('open');
				_task_candidate_win.window('setTitle','Candidate User Config');
				_task_candidate_win.window('refresh','${symbol_dollar}{ctx}/wf/procdef/procdef!forAddTaskCandidateUser.action');
	        }
	    }]
	});
	_task_candidate_win = jq('${symbol_pound}task-candidate-win').window({
		//href:'${symbol_dollar}{ctx}/wf/procdef/procdef!forTaskListenerConfig.action',   
	    closed:true,
	    //cache:false,
	    draggable:false,
	    collapsible:false,
	    minimizable:false,
	    maximizable:false,
	    modal:true,
	    shadow:true
	});
	loadTaskCandidateUsers();
});
function candidateUsersBtFormatter(value,rowData,rowIndex){
	var sso = rowData.sso;
	//var e = '<img onclick="editCandidateUser('+id+')" src="${symbol_dollar}{ctx}/image/edit.gif" title="'+"<s:text name='button.common.modify'></s:text>"+'" style="cursor:hand;"/>';   
    var d = '<img onclick="deleteCandidateUser(${symbol_escape}''+sso+'${symbol_escape}')" src="${symbol_dollar}{ctx}/image/delete.gif" title="'+"<s:text name='button.common.delete'></s:text>"+'" style="cursor:hand;"/>';
	return d;
}
function deleteCandidateUser(sso){
	task.deleteCandidateUser(sso);
	loadTaskCandidateUsers();
}
function loadTaskCandidateUsers(){
	var candidateUsers = task.candidateUsers;
	var candidate_users_grid_rows=[];
	//alert(listeners.getSize());
	for(var i=0;i<candidateUsers.getSize();i++){
		var candidateUser = candidateUsers.get(i);
		var user = {
					id:candidateUser.userId,
					sso:candidateUser.sso,
					name:candidateUser.name,
					action:''
				};
		candidate_users_grid_rows[i]=user;
	};
	//alert(listener_grid_rows);
	var candidate_users_grid_data={
			total:candidateUsers.getSize(),
			rows:candidate_users_grid_rows
	};
	_task_candidate_users_list.datagrid('loadData',candidate_users_grid_data);
}
//-->
</script>
<!--<div id="task-candidate-users-panel">-->
							<table id="task-candidate-users-list" name="task-candidate-users-list">
								<thead>
								<tr>
								<th field="sso" width="100" align="middle" sortable="false">SSO</th>
								<th field="name" width="100" align="middle" sortable="false">Name</th>
								<th field="action" width="80" align="middle" formatter="candidateUsersBtFormatter">Action</th>
								</tr>
								</thead>
							</table>
<!--</div>-->