<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<script type="text/javascript">
<!--
$(function(){
	//_unselected_role_panel_obj=$('#_unselected_role_panel').panel({
		//fit:true
	//});
	_unselected_roles_grid=$('#unselectedRoleTable').datagrid({
		title:"<s:text name='label.pm.role.list'></s:text>",
		url:'${ctx}/pm/module/module!searchUnselectedRole.action?moduleId=${moduleId}',
		//singleSelect:true,
		//width:900,
		height:380,
		idField:'roleId',
		pagination:true,
		pageSize:15,
		pageNumber:1,
		pageList:[10,15],
		rownumbers:true,
		sortName:'roleId',
	    sortOrder:'asc',
	    striped:true,
	    onLoadSuccess:function(data){
		   	var rows = data.rows;
		    for(var i=0;i<rows.length;i++){
			    if(rows[i].isAssigned){
					$(this).datagrid('selectRow',i);
				}
			}
		},
	    toolbar:[{
	        text:"<s:text name='button.pm.common.privilege.update'></s:text>",
	        iconCls:'icon-add',
	        handler:function(){
	    		addRoles();
	        }
	    },'-',{
	    	text:"<s:text name='button.common.return'></s:text>",
	        iconCls:'icon-undo',
	        handler:toBack
		}]
	});
	_unselected_role_form_obj=$('#unselectedRoleForm');
});
function addRoles(){
	var rows = _unselected_roles_grid.datagrid("getSelections");
	if(rows.length==0){
		$.messager.alert('Error',"<s:text name='message.common.must.selectRow'></s:text>",'error');
		return;
	}
	var ids = null;
	for(var i=0;i<rows.length;i++){
		ids=ids+rows[i].roleId+",";
	}
	//alert(ids);
	document.getElementById("unselectedRoleIds").value=ids;
	_unselected_role_form_obj.form('submit',{
		url:'${ctx}/pm/module/module!addRoles.action',
		success:function(data){
			eval('data='+data);
			if(data.success){
				$.messager.alert('Info',data.message,'info');
			}else{
				$.messager.alert('Error',data.message,'error');
			}
		},
		onSubmit:function(){
			//if(_group_form_obj.valid())
				return true;
			//else
				//return false;
		}
	});
}
function checkboxFormatter (value,rowData,rowIndex){
	var userId=rowData.userId;
	var c='<input type="checkbox" id="userId" name="userId" value="'+userId+'"/>';
	return c;
}
function dosearchByRole(){
	var name=document.getElementById("_group_search_unslt_roleName").value;
	//var group=_search_group.combobox('getValue');
	//alert(group);
	//var email=document.getElementById("_group_search_unslt_email").value;
	_unselected_roles_grid.datagrid('reload',{
			filter_LIKES_name:name
			//filter_EQS_sso:sso,
			//group_EQI_groupId:group,
			//filter_LIKES_email:email
		});
}
//-->
</script>
<!--<div id="_unselected_role_panel" style="padding:10px;">-->
<table border="0">
	<tr>
			<td><s:text name='label.pm.role.name'></s:text>:</td>
			<td><input type="text" id="_group_search_unslt_roleName" name="_group_search_unslt_roleName" value="" size="9"/></td>
			<td><a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="dosearchByRole();"><s:text name='button.common.search'></s:text></a></td>
	</tr>
</table>
<form id="unselectedRoleForm" method="post">
    <input type="hidden" name="moduleId" value="${moduleId}"/>
    <input type="hidden" name="unselectedRoleIds" id="unselectedRoleIds" value=""/>
       <table id="unselectedRoleTable">
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
