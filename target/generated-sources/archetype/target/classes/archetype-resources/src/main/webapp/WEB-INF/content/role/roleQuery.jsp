#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML ${version} Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>Home Page</title>
	<%@ include file="/common/header.jsp" %>
</head>
<script type="text/javascript">
<!--
${symbol_dollar}(function(){
	_role_panel_obj=${symbol_dollar}('${symbol_pound}_role_panel').panel({
			//height:600,
			border:false,
			noheader:true,
			top:0,
			left:0
		});
	_role_grid=${symbol_dollar}('${symbol_pound}_role_table').datagrid({
		title:"<s:text name='label.pm.role.list'></s:text>",
		url:'${symbol_dollar}{ctx}/pm/role/role!search.action',
		//singleSelect:true,
		height:500,
		idField:'roleId',
		pagination:true,
		pageSize:15,
		pageNumber:1,
		pageList:[10,15],
		rownumbers:true,
		sortName:'name',
	    sortOrder:'asc',
	    striped:true,
	    toolbar:[{
	        text:"<s:text name='button.common.add'></s:text>",
	        iconCls:'icon-add',
	        handler:function(){
	    		window.location='${symbol_dollar}{ctx}/pm/role/role!forInsert.action';
				return false;
	        }
	    }]
	});
});
function dosearch(){
	var name=document.getElementById("filter_LIKES_name").value;
	_role_grid.datagrid('reload',{
		filter_LIKES_name:name
		});
}
function  editrow(id){
	window.location='${symbol_dollar}{ctx}/pm/role/role!forUpdate.action?roleId='+id;
}
function  deleterow(id){
	${symbol_dollar}.messager.confirm("Confirm","<s:text name='message.common.delete.confirm'></s:text>",function(flag){
		if(flag){
			${symbol_dollar}.ajax({
					url:'${symbol_dollar}{ctx}/pm/role/role!delete.action?_role_id='+id,
					type: 'GET',
					dataType:'json',
					error:function(){
						${symbol_dollar}.messager.alert('Error',"<s:text name='message.common.delete.failure'></s:text>",'error');
					},
					success:function(data){
						if(data.success){
							_role_grid.datagrid('reload',{});
							${symbol_dollar}.messager.alert('Success',data.message,'info');
						}else{
							${symbol_dollar}.messager.alert('Error',data.message,'error');
						}
					}
				}
			);
		}
	});
}
function displayActionBt (value,rowData,rowIndex){
		var id = rowData.roleId;
		var e = '<img onclick="editrow('+id+')" src="${symbol_dollar}{ctx}/image/edit.gif" title="'+"<s:text name='button.common.modify'></s:text>"+'" style="cursor:hand;"/>';   
        var d = '<img onclick="deleterow('+id+')" src="${symbol_dollar}{ctx}/image/delete.gif" title="'+"<s:text name='button.common.delete'></s:text>"+'" style="cursor:hand;"/>';
        var a = '<img onclick="addUsers('+id+')" src="${symbol_dollar}{ctx}/image/assign.gif" title="'+"<s:text name='button.pm.role.add.user'></s:text>"+'" style="cursor:hand;"/>';
        var p = '<img onclick="assignPrivilege('+id+')" src="${symbol_dollar}{ctx}/image/permissions.gif" title="'+"<s:text name='button.pm.role.assign.privilege'></s:text>"+'" style="cursor:hand;"/>';
        return e+'&nbsp;'+a+'&nbsp;'+p+'&nbsp;'+d;
}
function addUsers(id){
	//alert(id);
	window.location="${symbol_dollar}{ctx}/pm/role/role!forAssignUser.action?roleId="+id;
}
function assignPrivilege(id){
    //alert('${symbol_dollar}{ctx}/pm/module/module!forAssignPrivilege.action?moduleId='+id+'&moduleName='+name);
	window.location='${symbol_dollar}{ctx}/pm/role/role!forAssignPrivilege.action?roleId='+id;
}
//-->
</script>
<body>
<div id="_role_panel" style="padding:5px;">
<div id="filter">
	<table border="0">
		<tr>
			<td><s:text name='label.pm.role.name'></s:text>:</td>
			<td><input type="text" name="filter_LIKES_name" value="" size="9"/></td>
			<td><a href="${symbol_pound}" class="easyui-linkbutton" iconCls="icon-search" onclick="dosearch();"><s:text name='button.common.search'></s:text></a></td>
		</tr>
	</table>
</div>
<div id="content">
<table id="_role_table">
	<thead>
		<tr>
			<th field="name" width="100" align="middle" sortable="true"><s:text name='label.pm.role.name'></s:text></th>
			<th field="remark" width="300" align="middle"><s:text name='label.pm.role.remark'></s:text></th>
			<th field="action" width="200" align="middle" formatter="displayActionBt"><s:text name='label.pm.role.action'></s:text></th>
		</tr>
	</thead>
</table>
</div>
</div>
</body>
</html>