<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>Home Page</title>
	<%@ include file="/common/header.jsp" %>
</head>
<script type="text/javascript">
<!--
$(function(){
	_opt_panel_obj=$('#_opt_panel').panel({
			//height:600,
			border:false,
			noheader:true,
			top:0,
			left:0
		});
	_opt_grid=$('#_opt_table').datagrid({
		title:"<s:text name='label.pm.opt.list'></s:text>",
		url:'${ctx}/pm/opt/operation!search.action',
		//singleSelect:true,
		height:500,
		idField:'operationId',
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
	    		window.location='${ctx}/pm/opt/operation!forInsert.action';
				return false;
	        }
	    }]
	});
});
function dosearch(){
	var name=document.getElementById("filter_LIKES_name").value;
	_opt_grid.datagrid('reload',{
		filter_LIKES_name:name
		});
}
function  editrow(id){
	window.location='${ctx}/pm/opt/operation!forInsert.action?operationId='+id;
}
function  deleterow(id){
	$.messager.confirm("Confirm","<s:text name='message.common.delete.confirm'></s:text>",function(flag){
		if(flag){
			$.ajax({
					url:'${ctx}/pm/opt/operation!delete.action?_operation_id='+id,
					type: 'GET',
					dataType:'json',
					error:function(){
						$.messager.alert('Error',"<s:text name='message.common.delete.failure'></s:text>",'error');
					},
					success:function(data){
						if(data.success){
							_group_grid.datagrid('reload',{});
							$.messager.alert('Success',data.message,'info');
						}else{
							$.messager.alert('Error',data.message,'error');
						}
					}
				}
			);
		}
	});
}
function displayActionBt (value,rowData,rowIndex){
		var id = rowData.operationId;
		var e = '<img onclick="editrow('+id+')" src="${ctx}/image/edit.gif" title="'+"<s:text name='button.common.modify'></s:text>"+'" style="cursor:hand;"/>';   
        var d = '<img onclick="deleterow('+id+')" src="${ctx}/image/delete.gif" title="'+"<s:text name='button.common.delete'></s:text>"+'" style="cursor:hand;"/>';
        return e+'&nbsp;'+d;
}
function addUsers(id){
	
}
//-->
</script>
<body>
<div id="_opt_panel" style="padding:5px;">
<div id="filter">
	<table border="0">
		<tr>
			<td><s:text name='label.pm.opt.name'></s:text>:</td>
			<td><input type="text" name="filter_LIKES_name" value="" size="9"/></td>
			<td><a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="dosearch();"><s:text name='button.common.search'></s:text></a></td>
		</tr>
	</table>
</div>
<div id="content">
<table id="_opt_table">
	<thead>
		<tr>
			<th field="name" width="100" align="middle" sortable="true"><s:text name='label.pm.opt.name'></s:text></th>
			<th field="remark" width="300" align="middle"><s:text name='label.pm.opt.remark'></s:text></th>
			<th field="action" width="200" align="middle" formatter="displayActionBt"><s:text name='label.pm.opt.action'></s:text></th>
		</tr>
	</thead>
</table>
</div>
</div>
</body>
</html>