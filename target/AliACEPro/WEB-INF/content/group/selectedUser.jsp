<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<script type="text/javascript">
<!--
$(function(){
	//_selected_user_panel_obj=$('#_selected_user_panel').panel({
		//fit:true
	//});
	_selected_users_grid=$('#selectedUserTable').datagrid({
		title:"<s:text name='label.pm.user.table.title'></s:text>",
		url:'${ctx}/pm/group/group!searchSelectedUser.action?groupId=${groupId}',
		//singleSelect:true,
		//width:900,
		height:450,
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
			filter_EQI_id:'${groupId}'
	    },
	    */
	    toolbar:[{
	        text:"<s:text name='button.pm.common.privilege.cancel'></s:text>",
	        iconCls:'icon-cancel',
	        handler:function(){
	    		deleteUser();
	        }
	    },{
	    	text:"<s:text name='button.common.return'></s:text>",
	        iconCls:'icon-undo',
	        handler:toBack
		}]
	});
	_selected_user_form_obj=$('#selectedUserForm');
});
function deleteUser(){
	var rows = _selected_users_grid.datagrid("getSelections");
	if(rows.length==0){
		$.messager.alert('Error',"<s:text name='message.common.must.selectRow'></s:text>",'error');
		return;
	}else{
		$.messager.confirm("Confirm","<s:text name='message.common.delete.confirm'></s:text>",function(flag){
			//alert(flag);
			if(flag){
				var ids = null;
				for(var i=0;i<rows.length;i++){
					ids=ids+rows[i].userId+",";
				}
				document.getElementById("selectedUserIds").value=ids;
				_selected_user_form_obj.form('submit',{
						url:'${ctx}/pm/group/group!deleteUsers.action',
						success:function(data){
							eval('data='+data);
							if(data.success){
								$.messager.alert('Success',data.message,'info');
								_selected_users_grid.datagrid("clearSelections");
								_selected_users_grid.datagrid('reload',{});
							}else{
								$.messager.alert('Error',data.message,'error');
							}
						}
					}
				);
			}
		});
	}
};
function dosearchByGroup(){
	var name=document.getElementById("_group_search_slt_userName").value;
	var sso=document.getElementById("_group_search_slt_sso").value;
	//var group=_search_group.combobox('getValue');
	//alert(group);
	var email=document.getElementById("_group_search_slt_email").value;
	_selected_users_grid.datagrid('reload',{
			filter_LIKES_name:name,
			filter_EQS_sso:sso,
			//group_EQI_groupId:group,
			filter_LIKES_email:email
		});
}
//-->
</script>
<!--<div id="_selected_user_panel" style="padding:5px;">-->
<table border="0">
	<tr>
			<td><s:text name='label.pm.user.sso'></s:text>:</td>
			<td><input type="text" id="_group_search_slt_sso" name="_group_search_slt_sso" value="" size="15"/></td>
			<td><s:text name='label.pm.user.name'></s:text>:</td>
			<td><input type="text" id="_group_search_slt_userName" name="_group_search_slt_userName" value="" size="9"/></td>
			<td><s:text name='label.pm.user.email'></s:text>:</td>
			<td><input type="text" id="_group_search_slt_email" name="_group_search_slt_email" value="" size="9"/></td>
			<td><a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="dosearchByGroup();"><s:text name='button.common.search'></s:text></a></td>
	</tr>
</table>
<form id="selectedUserForm">
    <input type="hidden" name="groupId" value="${groupId}"/>
    <input type="hidden" name="selectedUserIds" id="selectedUserIds" value=""/>
       <table id="selectedUserTable">
			<thead>
				<tr>
					<th field="userId" align="middle" checkbox="true"></th>
					<th field="sso" width="80" align="middle" sortable="true"><s:text name='label.pm.user.sso'></s:text></th>
					<th field="name" width="100" align="middle" sortable="true"><s:text name='label.pm.user.name'></s:text></th>
					<th field="title" width="100" align="middle" sortable="true"><s:text name='label.pm.user.title'></s:text></th>
					<th field="email" width="200" align="middle"><s:text name='label.pm.user.email'></s:text></th>
					<th field="userStatus" width="200" align="middle"><s:text name='label.pm.user.status'></s:text></th>
				</tr>
			</thead>
		</table>
	</form>
<!--</div>-->
