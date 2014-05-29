<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<script type="text/javascript">
<!--
$(function(){
	//_role_unselected_user_panel_obj=$('#_role_unselected_user_panel').panel({
		//border:false,
		//noheader:true,
		//top:0,
		//left:0
		//fit:true
	//});
	_role_unselected_users_grid=$('#roleUnselectedUserTable').datagrid({
		title:"<s:text name='label.pm.user.table.title'></s:text>",
		url:'${ctx}/pm/role/role!searchUnselectedUser.action?roleId=${roleId}',
		//singleSelect:true,
		//width:900,
		height:390,
		idField:'userId',
		pagination:true,
		pageSize:15,
		pageNumber:1,
		pageList:[10,15],
		rownumbers:true,
		sortName:'userId',
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
	    		addUsers();
	        }
	    },{
	    	text:"<s:text name='button.common.return'></s:text>",
	        iconCls:'icon-undo',
	        handler:toBack
		}]
	});
	_role_unselected_user_form_obj=$('#roleUnselectedUserForm');
	
	_role_search_group=$('#_role_search_unslt_groupId').combobox({
	    url:'${ctx}/pm/group/group!getAllGroups.action',
	    //editable:false,
	    valueField:'groupId',
	    textField:'name'
	});
	
});
function addUsers(){
	var rows = _role_unselected_users_grid.datagrid("getSelections");
	if(rows.length==0){
		$.messager.alert('Error',"<s:text name='message.common.must.selectRow'></s:text>",'error');
		return
	}
	var ids = null;
	for(var i=0;i<rows.length;i++){
		ids=ids+rows[i].userId+",";
	}
	//alert(ids);
	document.getElementById("roleUnselectedUserIds").value=ids;
	_role_unselected_user_form_obj.form('submit',{
		url:'${ctx}/pm/role/role!addUsers.action',
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
function dosearchByUser(){
	var name=document.getElementById("_role_search_unslt_userName").value;
	var sso=document.getElementById("_role_search_unslt_sso").value;
	var group=_role_search_group.combobox('getValue');
	//alert(group);
	var email=document.getElementById("_role_search_unslt_email").value;
	//alert(sso);
	_role_unselected_users_grid.datagrid('reload',{
			filter_LIKES_name:name,
			filter_EQS_sso:sso,
			group_EQI_groupId:group,
			filter_LIKES_email:email
		});
}
//-->
</script>

<!--<div id="_role_unselected_user_panel" style="padding:5px;">-->
<table border="0">
	<tr>
		<td><s:text name='label.pm.role.group'></s:text>:</td>
		<td><input type="text" id="_role_search_unslt_groupId" name="_role_search_unslt_groupId" value="" readonly="readonly"/></td>
			<td><s:text name='label.pm.user.sso'></s:text>:</td>
			<td><input type="text" id="_role_search_unslt_sso" name="_role_search_unslt_sso" value="" size="9"/></td>
			<td><s:text name='label.pm.user.name'></s:text>:</td>
			<td><input type="text" id="_role_search_unslt_userName" name="_role_search_unslt_userName" value="" size="9"/></td>
			<td><s:text name='label.pm.user.email'></s:text>:</td>
			<td><input type="text" id="_role_search_unslt_email" name="_role_search_unslt_email" value="" size="9"/></td>
			<td><a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="dosearchByUser();"><s:text name='button.common.search'></s:text></a></td>
	</tr>
</table>
<form id="roleUnselectedUserForm" method="post">
    <input type="hidden" name="roleId" value="${roleId}"/>
    <input type="hidden" name="roleUnselectedUserIds" id="roleUnselectedUserIds" value=""/>
       <table id="roleUnselectedUserTable">
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
