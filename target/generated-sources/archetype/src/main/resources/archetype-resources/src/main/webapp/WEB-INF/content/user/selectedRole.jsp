#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<script type="text/javascript">
<!--
${symbol_dollar}(function(){
	//_role_selected_user_panel_obj=${symbol_dollar}('${symbol_pound}_role_selected_user_panel').panel({
		//border:false,
		//noheader:true,
		//top:0,
		//left:0
		//fit:true
	//});
	_role_selected_users_grid=${symbol_dollar}('${symbol_pound}roleSelectedUserTable').datagrid({
		title:"<s:text name='label.pm.role.list'></s:text>",
		url:'${symbol_dollar}{ctx}/pm/user/user!searchSelectedRoles.action?userId=${symbol_dollar}{userId}',
		//singleSelect:true,
		//width:900,
		height:390,
		idField:'roleId',
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
	    },{
	    	text:"<s:text name='button.common.return'></s:text>",
	        iconCls:'icon-undo',
	        handler:toBack
		}]
	});
	_role_selected_user_form_obj=${symbol_dollar}('${symbol_pound}roleSelectedUserForm');
});
function deleteUser(){
	var rows = _role_selected_users_grid.datagrid("getSelections");
	if(rows.length==0){
		${symbol_dollar}.messager.alert('Error',"<s:text name='message.common.must.selectRow'></s:text>",'error');
		return;
	}else{
		${symbol_dollar}.messager.confirm("Confirm","<s:text name='message.common.delete.confirm'></s:text>",function(flag){
			//alert(flag);
			if(flag){
				var ids = null;
				for(var i=0;i<rows.length;i++){
					ids=ids+rows[i].roleId+",";
				}
				document.getElementById("roleSelectedUserIds").value=ids;
				_role_selected_user_form_obj.form('submit',{
						url:'${symbol_dollar}{ctx}/pm/user/user!unassignRole.action',
						success:function(data){
							eval('data='+data);
							if(data.success){
								${symbol_dollar}.messager.alert('Success',data.message,'info');
								_role_selected_users_grid.datagrid("clearSelections");
								_role_selected_users_grid.datagrid('reload',{});
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
function dosearchByRole(){
	var name=document.getElementById("_role_search_slt_name").value;;
	_role_selected_users_grid.datagrid('reload',{
			filter_LIKES_name:name
		});
}
//-->
</script>

<!--<div id="_role_selected_user_panel" style="padding:5px;">-->
<table border="0">
	<tr>
			<td><s:text name='label.pm.role.name'></s:text>:</td>
			<td><input type="text" id="_role_search_slt_name" name="_role_search_slt_name" value="" size="15"/></td>
			<td><a href="${symbol_pound}" class="easyui-linkbutton" iconCls="icon-search" onclick="dosearchByRole();"><s:text name='button.common.search'></s:text></a></td>
	</tr>
</table>
<form id="roleSelectedUserForm">
    <input type="hidden" name="userId" value="${symbol_dollar}{userId}"/>
    <input type="hidden" name="roleSelectedUserIds" id="roleSelectedUserIds" value=""/>
       <table id="roleSelectedUserTable">
			<thead>
				<tr>
					<th field="roleId" align="middle" checkbox="true"></th>
					<th field="name" width="200" align="middle" sortable="true"><s:text name='label.pm.role.name'></s:text></th>
					<th field="remark" width="300" align="middle"><s:text name='label.pm.role.remark'></s:text></th>
				</tr>
			</thead>
		</table>
	</form>
<!--</div>-->
