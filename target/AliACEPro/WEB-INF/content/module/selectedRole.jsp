<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>

<script type="text/javascript">
<!--
$(function(){
	//_selected_role_panel_obj=$('#_selected_role_panel').panel({
		//fit:true
	//});
	_selected_roles_grid=$('#selectedRoleTable').datagrid({
		title:"<s:text name='label.pm.role.list'></s:text>",
		url:'${ctx}/pm/module/module!searchSelectedRole.action?moduleId=${moduleId}',
		//singleSelect:true,
		//width:900,
		height:380,
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
			filter_EQI_id:'${groupId}'
	    },
	    */
	    toolbar:[{
	        text:"<s:text name='button.pm.common.privilege.cancel'></s:text>",
	        iconCls:'icon-cancel',
	        handler:function(){
	    		deleteRole();
	        }
	    },'-',{
	    	text:"<s:text name='button.common.return'></s:text>",
	        iconCls:'icon-undo',
	        handler:toBack
		}]
	});
	_selected_role_form_obj=$('#selectedRoleForm');
});
function deleteRole(){
	var rows = _selected_roles_grid.datagrid("getSelections");
	if(rows.length==0){
		$.messager.alert('Error',"<s:text name='message.common.must.selectRow'></s:text>",'error');
		return;
	}else{
		$.messager.confirm("Confirm","<s:text name='message.common.delete.confirm'></s:text>",function(flag){
			//alert(flag);
			if(flag){
				var ids = null;
				for(var i=0;i<rows.length;i++){
					ids=ids+rows[i].roleId+",";
				}
				document.getElementById("selectedRoleIds").value=ids;
				_selected_role_form_obj.form('submit',{
						url:'${ctx}/pm/module/module!deleteRoles.action',
						success:function(data){
							eval('data='+data);
							if(data.success){
								$.messager.alert('Success',data.message,'info');
								_selected_roles_grid.datagrid("clearSelections");
								_selected_roles_grid.datagrid('reload',{});
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

//-->
</script>
<!--<div id="_selected_role_panel" style="padding:5px;">-->
<form id="selectedRoleForm">
    <input type="hidden" name="moduleId" value="${moduleId}"/>
    <input type="hidden" name="selectedRoleIds" id="selectedRoleIds" value=""/>
       <table id="selectedRoleTable">
			<thead>
				<tr>
					<th field="roleId" align="middle" checkbox="true"></th>
					<th field="name" width="100" align="middle" sortable="true"><s:text name='label.pm.role.name'></s:text></th>
					<th field="privilege" width="200" align="middle"><s:text name='label.pm.module.privilege'></s:text></th>
				</tr>
			</thead>
		</table>
</form>
<!--</div>-->
