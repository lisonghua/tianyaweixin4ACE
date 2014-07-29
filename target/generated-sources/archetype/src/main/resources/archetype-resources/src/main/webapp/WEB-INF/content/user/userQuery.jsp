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
	_user_panel_obj=${symbol_dollar}('${symbol_pound}_user_panel').panel({
			//height:600,
			//fit:true,
			border:false,
			noheader:true,
			top:0,
			left:0
		});
	_users_grid=${symbol_dollar}('${symbol_pound}userTable').datagrid({
		title:'<s:text name="label.pm.user.table.title"></s:text>',
		url:'${symbol_dollar}{ctx}/pm/user/user!searchUser.action',
		//singleSelect:true,
		height:500,
		//fit:true,
		idField:'userId',
		pagination:true,
		pageSize:15,
		pageNumber:1,
		pageList:[10,15],
		rownumbers:true,
		sortName:'userId',
	    sortOrder:'asc',
	    striped:true,
	    toolbar:[{
	        text:'<s:text name="button.common.add"></s:text>',
	        iconCls:'icon-add',
	        handler:addUser
	    },'-',{
	        text:'<s:text name="button.common.modify"></s:text>',
	        iconCls:'icon-edit',
	        handler:updateUser
	    }
	    /*,'-',{
	        text:'<s:text name="button.common.delete"></s:text>',
	        iconCls:'icon-cancel',
	        handler:deleteUser
	    }
	    */]
	});
	_pw_window=${symbol_dollar}('${symbol_pound}setPwWindow').window({   
	    closed:true,
	    collapsible:false,
	    minimizable:false,
	    maximizable:false,
	    modal:true,
	    shadow:true,
	    onClose:closePwForm
	});
	_pw_frame=document.getElementById('setPwFrame');
});
function addUser(){
	window.location='${symbol_dollar}{ctx}/pm/user/user!forInsert.action';
	return false;
}
function dosearch(){
	var id=document.getElementById("filter_EQS_sso").value;
	var name=document.getElementById("filter_LIKES_name").value;
	_users_grid.datagrid('reload',{
		filter_EQS_sso:id,
		filter_LIKES_name:name
		});
}
function updateUser(){
	var rows = _users_grid.datagrid("getSelections");
	if(rows.length==0){
		${symbol_dollar}.messager.alert('Error',"<s:text name='message.common.must.selectRow'></s:text>",'error');
		return false;
	}else if(rows.length>1){
		${symbol_dollar}.messager.alert('Error',"<s:text name='message.common.only.selectOneRow'></s:text>",'error');
		return false;
	}else{
		var seleted = _users_grid.datagrid("getSelected");
		//alert('${symbol_dollar}{ctx}/pm/user/user!forUpdate.action?userId='+seleted.userId);
		window.location='${symbol_dollar}{ctx}/pm/user/user!forUpdate.action?userId='+seleted.userId;
		return false;
	}
}
function deleteUser(){
	var rows = _users_grid.datagrid("getSelections");
	if(rows.length==0){
		${symbol_dollar}.messager.alert('Error',"<s:text name='message.common.must.selectRow'></s:text>",'error');
		return false;
	}else{
		${symbol_dollar}.messager.confirm("Confirm","<s:text name='message.common.delete.confirm'></s:text>",function(flag){
			//alert(flag);
			if(flag){
				var ids = null;
				for(var i=0;i<rows.length;i++){
					ids=ids+rows[i].userId+",";
				}
				//alert(ids);
				${symbol_dollar}.ajax({
						url:'${symbol_dollar}{ctx}/pm/user/user!delete.action?ids='+ids,
						type: 'GET',
						dataType:'json',
						error:function(){
							${symbol_dollar}.messager.alert('Error',"<s:text name='message.common.delete.failure'></s:text>",'error');
						},
						success:function(data){
							if(data.success){
								${symbol_dollar}.messager.alert('Success',data.message,'info');
								_users_grid.datagrid("clearSelections");
								_users_grid.datagrid('reload',{});
							}else{
								${symbol_dollar}.messager.alert('Error',data.message,'error');
							}
						}
					}
				);
			}
		});
	}
}
function actionFormatter(value,rowData,rowIndex){
	var id = rowData.userId;
	var ustatus = rowData.userStatusCode;
	var p = '<img onclick="assignPrivilege('+id+')" src="${symbol_dollar}{ctx}/image/permissions.gif" title="'+"<s:text name='button.pm.user.set.privilege'></s:text>"+'" style="cursor:hand;"/>';
	var sp = '<img onclick="setPassword('+id+')" src="${symbol_dollar}{ctx}/image/setPassword.gif" title="'+"<s:text name='button.pm.user.update.password'></s:text>"+'" style="cursor:hand;"/>';
	var a = '<img onclick="activateUser('+id+')" src="${symbol_dollar}{ctx}/image/activate.gif" title="'+"<s:text name='button.pm.user.activate'></s:text>"+'" style="cursor:hand;"/>';
	var da = '<img onclick="deactivateUser('+id+')" src="${symbol_dollar}{ctx}/image/deactivate.gif" title="'+"<s:text name='button.pm.user.deactivate'></s:text>"+'" style="cursor:hand;"/>';
	var r = '<img onclick="assignRole('+id+')" src="${symbol_dollar}{ctx}/image/role.gif" title="'+"<s:text name='button.pm.user.assign.role'></s:text>"+'" style="cursor:hand;"/>';
	//super user
	if(id==0)
		return sp;
	else if(ustatus==0)
		return a+'&nbsp;'+sp+'&nbsp;'+p+'&nbsp;'+r;
	else
		return da+'&nbsp;'+sp+'&nbsp;'+p+'&nbsp;'+r;
}
function activateUser(id){
	${symbol_dollar}.ajax({
		url:'${symbol_dollar}{ctx}/pm/user/user!activateUser.action?userId='+id,
		type: 'GET',
		dataType:'json',
		error:function(){
			${symbol_dollar}.messager.alert('Error',"<s:text name='message.pm.user.activate.failure'></s:text>",'error');
		},
		success:function(data){
			if(data.success){
				${symbol_dollar}.messager.alert('Success',data.message,'info');
				_users_grid.datagrid("clearSelections");
				_users_grid.datagrid('reload',{});
			}else{
				${symbol_dollar}.messager.alert('Error',data.message,'error');
			}
		}
	}
	);
}
function deactivateUser(id){
	${symbol_dollar}.ajax({
		url:'${symbol_dollar}{ctx}/pm/user/user!deactivateUser.action?userId='+id,
		type: 'GET',
		dataType:'json',
		error:function(){
			${symbol_dollar}.messager.alert('Error',"<s:text name='message.pm.user.deactivate.failure'></s:text>",'error');
		},
		success:function(data){
			if(data.success){
				${symbol_dollar}.messager.alert('Success',data.message,'info');
				_users_grid.datagrid("clearSelections");
				_users_grid.datagrid('reload',{});
			}else{
				${symbol_dollar}.messager.alert('Error',data.message,'error');
			}
		}
	}
	);
}
function assignPrivilege(id){
    //alert('${symbol_dollar}{ctx}/pm/module/module!forAssignPrivilege.action?moduleId='+id+'&moduleName='+name);
	window.location='${symbol_dollar}{ctx}/pm/user/user!forAssignPrivilege.action?userId='+id;
}
function assignRole(id){
    //alert('${symbol_dollar}{ctx}/pm/module/module!forAssignPrivilege.action?moduleId='+id+'&moduleName='+name);
	window.location='${symbol_dollar}{ctx}/pm/user/user!forAssignRole.action?userId='+id;
}
function setPassword(id){
    //alert('${symbol_dollar}{ctx}/pm/module/module!forAssignPrivilege.action?moduleId='+id+'&moduleName='+name);
	//window.location='${symbol_dollar}{ctx}/pm/user/user!forAssignPrivilege.action?userId='+id;
	_pw_window.window('open');
	_pw_frame.src="${symbol_dollar}{ctx}/pm/user/user!forUpdatePassword.action?userId="+id;
}
function closePwWindow(){
	_pw_window.window('close');
}
function closePwForm(){
	_pw_frame.contentWindow.closePwForm();
	
}
//-->
</script>
<body>
<div id="_user_panel" style="padding:5px;">
<div id="filter">
	<table border="0">
		<tr>
			<td><s:text name='label.pm.user.sso'></s:text>:</td>
			<td><input type="text" name="filter_EQS_sso" value="" size="9"/></td>
			<td><s:text name='label.pm.user.name'></s:text>:</td>
			<td><input type="text" name="filter_LIKES_name" value="" size="9"/></td>
			<td><a href="${symbol_pound}" class="easyui-linkbutton" iconCls="icon-search" onclick="dosearch();"><s:text name='button.common.search'></s:text></a></td>
		</tr>
	</table>
</div>
<div id="content">
<table id="userTable">
	<thead>
		<tr>
			<th field="userId" align="middle" checkbox="true"></th>
			<th field="sso" width="80" align="middle" sortable="true"><s:text name='label.pm.user.sso'></s:text></th>
			<th field="name" width="100" align="middle" sortable="true"><s:text name='label.pm.user.name'></s:text></th>
			<th field="title" width="100" align="middle" sortable="true"><s:text name='label.pm.user.title'></s:text></th>
			<th field="email" width="200" align="middle"><s:text name='label.pm.user.email'></s:text></th>
			<th field="userStatus" width="100" align="middle"><s:text name='label.pm.user.status'></s:text></th>
			<th field="isAdmin" width="100" align="middle"><s:text name='label.pm.user.isAdmin'></s:text></th>
			<th field="action" width="100" align="middle" formatter="actionFormatter"><s:text name='label.pm.user.action'></s:text></th>
		</tr>
	</thead>
</table>
</div>
</div>
<div id="setPwWindow" title="<s:text name='label.pm.user.update.password'></s:text>" style="width:400px;height:300px;">
	<iframe id="setPwFrame" name="setPwFrame" frameborder="0" width="100%" height="100%"></iframe>  
</div> 
</body>
</html>
