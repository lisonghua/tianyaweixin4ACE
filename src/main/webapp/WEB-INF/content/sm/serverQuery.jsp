<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title></title>
	<%@ include file="/common/header.jsp" %>
</head>
<script type="text/javascript">
<!--
$(function(){
	_list_panel_obj=$('#_list_panel').panel({
		//height:600,
		border:false,
		noheader:true,
		top:0,
		left:0
		});
	_list_grid_obj=$('#_list_table').datagrid({
		title:'<s:text name="label.sm.server.table.title"></s:text>',
		url:'${ctx}/sm/server/server!search.action',
		singleSelect:true,
		height:500,
		//idField:'serverId',
		pagination:true,
		pageSize:15,
		pageNumber:1,
		pageList:[10,15],
		rownumbers:true,
		sortName:'serverId',
	    sortOrder:'asc',
	    striped:true,
	    toolbar:[{
	        text:'<s:text name="button.common.add"></s:text>',
	        iconCls:'icon-add',
	        handler:function(){
	    		window.location='${ctx}/sm/server/server!forUpdate.action';
	    		return false;
	        }
	    }]
	});
});
function searchByFilter(){
	var name=document.getElementById("filter_LIKES_name").value;
	var ip=document.getElementById("filter_LIKES_ip").value;
	_list_grid_obj.datagrid('reload',{
		filter_LIKES_ip:ip,
		filter_LIKES_name:name
		});
}

function  editRow(id){
	window.location='${ctx}/sm/server/server!forUpdate.action?serverId='+id;
}
function  deleteRow(id){
	$.messager.confirm("Confirm","<s:text name='message.common.delete.confirm'></s:text>",function(flag){
		if(flag){
			$.ajax({
					url:'${ctx}/sm/server/server!delete.action?serverId='+id,
					type: 'GET',
					dataType:'json',
					error:function(){
						$.messager.alert("<s:text name='label.common.error'></s:text>","<s:text name='message.common.delete.failure'></s:text>",'error');
					},
					success:function(data){
						if(data.success){
							_list_grid_obj.datagrid('reload',{});
							$.messager.alert("<s:text name='label.common.success'></s:text>",data.message,'info');
						}else{
							$.messager.alert("<s:text name='label.common.error'></s:text>",data.message,'error');
						}
					}
				}
			);
		}
	});
}
function actionFormatter(value,rowData,rowIndex){
	var id = rowData.serverId;
	var e = '<img onclick="editRow('+id+')" src="${ctx}/image/edit.gif" title="'+"<s:text name='button.common.modify'></s:text>"+'" style="cursor:hand;"/>';   
    var d = '<img onclick="deleteRow('+id+')" src="${ctx}/image/delete.gif" title="'+"<s:text name='button.common.delete'></s:text>"+'" style="cursor:hand;"/>';
    var c = '<img onclick="viewResources('+id+')" src="${ctx}/image/pages.gif" title="'+"<s:text name='button.sm.server.view.resources'></s:text>"+'" style="cursor:hand;"/>';
    return c+'&nbsp;'+e+'&nbsp;'+d;
}
function viewResources(id){
	window.location="${ctx}/sm/server/server!forView.action?serverId="+id;
}

//-->
</script>
<body>
<div id="_list_panel" style="padding:5px;">
<div id="filter">
	<table border="0">
		<tr>
			<td><s:text name='label.sm.server.name'></s:text>:</td>
			<td><input type="text" name="filter_LIKES_name" value="" size="9"/></td>
			<td><s:text name='label.sm.server.ip'></s:text>:</td>
			<td><input type="text" name="filter_LIKES_ip" value="" size="9"/></td>
			<td><a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="searchByFilter();"><s:text name='button.common.search'></s:text></a></td>
		</tr>
	</table>
</div>
<div id="content">
<table id="_list_table">
	<thead>
		<tr>
			<th field="name" width="200" align="middle" sortable="true"><s:text name='label.sm.server.name'></s:text></th>
			<th field="type" width="50" align="middle" sortable="true"><s:text name='label.sm.server.type'></s:text></th>
			<th field="ip" width="100" align="middle"><s:text name='label.sm.server.ip'></s:text></th>
			<th field="port" width="50" align="middle"><s:text name='label.sm.server.port'></s:text></th>
			<th field="version" width="50" align="middle"><s:text name='label.sm.server.version'></s:text></th>
			<th field="remark" width="150" align="middle"><s:text name='label.sm.server.remark'></s:text></th>
			<th field="action" width="100" align="middle" formatter="actionFormatter"><s:text name='label.sm.common.action'></s:text></th>
		</tr>
	</thead>
</table>
</div>
</div> 
</body>
</html>
