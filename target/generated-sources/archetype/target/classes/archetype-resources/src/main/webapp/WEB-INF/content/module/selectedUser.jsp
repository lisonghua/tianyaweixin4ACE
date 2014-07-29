#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>

<script type="text/javascript">
<!--
${symbol_dollar}(function(){
	//_selected_user_panel_obj=${symbol_dollar}('${symbol_pound}_selected_user_panel').panel({
		//fit:true
	//});
	_selected_users_grid=${symbol_dollar}('${symbol_pound}selectedUserTable').datagrid({
		title:"<s:text name='label.pm.user.table.title'></s:text>",
		url:'${symbol_dollar}{ctx}/pm/module/module!searchSelectedUser.action?moduleId=${symbol_dollar}{moduleId}',
		//singleSelect:true,
		//width:900,
		height:380,
		idField:'userId',
		pagination:true,
		pageSize:15,
		pageNumber:1,
		pageList:[10,15],
		rownumbers:true,
		//sortName:'userId',
	    //sortOrder:'asc',
	    striped:true,
	    /*
	    queryParams:{
			filter_EQI_id:'${symbol_dollar}{groupId}'
	    },
	    */
	    toolbar:[{
	        text:"<s:text name='button.pm.common.privilege.cancel'></s:text>",
	        iconCls:'icon-cancel',
	        handler:function(){
	    		deleteUser();
	        }
	    },'-',{
	    	text:"<s:text name='button.common.return'></s:text>",
	        iconCls:'icon-undo',
	        handler:toBack
		}]
	});
	_selected_user_form_obj=${symbol_dollar}('${symbol_pound}selectedUserForm');
});
function deleteUser(){
	var rows = _selected_users_grid.datagrid("getSelections");
	if(rows.length==0){
		${symbol_dollar}.messager.alert('Error',"<s:text name='message.common.must.selectRow'></s:text>",'error');
		return;
	}else{
		${symbol_dollar}.messager.confirm("Confirm","<s:text name='message.common.delete.confirm'></s:text>",function(flag){
			//alert(flag);
			if(flag){
				var ids = null;
				for(var i=0;i<rows.length;i++){
					ids=ids+rows[i].userId+",";
				}
				document.getElementById("selectedUserIds").value=ids;
				_selected_user_form_obj.form('submit',{
						url:'${symbol_dollar}{ctx}/pm/module/module!deleteUsers.action',
						success:function(data){
							eval('data='+data);
							if(data.success){
								${symbol_dollar}.messager.alert('Success',data.message,'info');
								_selected_users_grid.datagrid("clearSelections");
								_selected_users_grid.datagrid('reload',{});
							}else{
								${symbol_dollar}.messager.alert('Error',data.message,'error');
							}
						}
					}
				);
			}
		});
	}
};

//-->
</script>
<!--<div id="_selected_user_panel" style="padding:5px;">-->
<form id="selectedUserForm">
    <input type="hidden" name="moduleId" value="${symbol_dollar}{moduleId}"/>
    <input type="hidden" name="selectedUserIds" id="selectedUserIds" value=""/>
       <table id="selectedUserTable">
			<thead>
				<tr>
					<th field="userId" align="middle" checkbox="true"></th>
					<th field="sso" width="80" align="middle" sortable="true"><s:text name='label.pm.user.sso'></s:text></th>
					<th field="name" width="100" align="middle" sortable="true"><s:text name='label.pm.user.name'></s:text></th>
					<th field="email" width="200" align="middle"><s:text name='label.pm.user.email'></s:text></th>
					<th field="userStatus" width="200" align="middle"><s:text name='label.pm.user.status'></s:text></th>
					<th field="privilege" width="200" align="middle"><s:text name='label.pm.module.privilege'></s:text></th>
				</tr>
			</thead>
		</table>
</form>
<!--</div>-->
