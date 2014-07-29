#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML ${version} Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title></title>
	<%@ include file="/common/header.jsp" %>
</head>
<script type="text/javascript">
<!--

${symbol_dollar}(function(){
	_list_panel_obj=${symbol_dollar}('${symbol_pound}_list_panel').panel({
		//height:600,
		border:false,
		noheader:true,
		top:0,
		left:0
		});
	_list_grid_obj=${symbol_dollar}('${symbol_pound}_list_table').datagrid({
		title:'<s:text name="label.sm.ds.table.title"></s:text>',
		url:'${symbol_dollar}{ctx}/sm/datasource/datasource!search.action',
		singleSelect:true,
		height:500,
		//idField:'serverId',
		pagination:true,
		pageSize:15,
		pageNumber:1,
		pageList:[10,15],
		rownumbers:true,
		sortName:'dsId',
	    sortOrder:'asc',
	    striped:true,
	    toolbar:[{
	        text:'<s:text name="button.common.add"></s:text>',
	        iconCls:'icon-add',
	        handler:function(){
	    		window.location='${symbol_dollar}{ctx}/sm/datasource/datasource!forUpdate.action';
	    		return false;
	        }
	    }]
	});
});
function searchByFilter(){
	var name=document.getElementById("filter_LIKES_name").value;
	var userName=document.getElementById("filter_LIKES_userName").value;
	_list_grid_obj.datagrid('reload',{
		filter_LIKES_userName:userName,
		filter_LIKES_name:name
		});
}

function  editRow(id){
	window.location='${symbol_dollar}{ctx}/sm/datasource/datasource!forUpdate.action?dsId='+id;
}
function  deleteRow(id){
	${symbol_dollar}.messager.confirm("Confirm","<s:text name='message.common.delete.confirm'></s:text>",function(flag){
		if(flag){
			${symbol_dollar}.ajax({
					url:'${symbol_dollar}{ctx}/sm/datasource/datasource!delete.action?dsId='+id,
					type: 'GET',
					dataType:'json',
					error:function(){
						${symbol_dollar}.messager.alert("<s:text name='label.common.error'></s:text>","<s:text name='message.common.delete.failure'></s:text>",'error');
					},
					success:function(data){
						if(data.success){
							_list_grid_obj.datagrid('reload',{});
							${symbol_dollar}.messager.alert("<s:text name='label.common.success'></s:text>",data.message,'info');
						}else{
							${symbol_dollar}.messager.alert("<s:text name='label.common.error'></s:text>",data.message,'error');
						}
					}
				}
			);
		}
	});
}
function actionFormatter(value,rowData,rowIndex){
	var id = rowData.dsId;
	var e = '<img onclick="editRow('+id+')" src="${symbol_dollar}{ctx}/image/edit.gif" title="'+"<s:text name='button.common.modify'></s:text>"+'" style="cursor:hand;"/>';   
    var d = '<img onclick="deleteRow('+id+')" src="${symbol_dollar}{ctx}/image/delete.gif" title="'+"<s:text name='button.common.delete'></s:text>"+'" style="cursor:hand;"/>';
   	var c = '<img onclick="analyzeLog('+id+')" src="${symbol_dollar}{ctx}/image/chart_bar_edit.png" title="'+"<s:text name='button.sm.ds.analyze.log'></s:text>"+'" style="cursor:hand;"/>';
    return c+'&nbsp;'+e+'&nbsp;'+d;
}
function analyzeLog(id){
	window.location='${symbol_dollar}{ctx}/sm/datasource/datasource!forAnalyze.action?dsId='+id;
}

//-->
</script>
<body>
<div id="_list_panel" style="padding:5px;">
<div id="filter">
	<table border="0">
		<tr>
			<td><s:text name='label.sm.ds.name'></s:text>:</td>
			<td><input type="text" name="filter_LIKES_name" value="" size="9"/></td>
			<td><s:text name='label.sm.ds.userName'></s:text>:</td>
			<td><input type="text" name="filter_LIKES_userName" value="" size="9"/></td>
			<td><a href="${symbol_pound}" class="easyui-linkbutton" iconCls="icon-search" onclick="searchByFilter();"><s:text name='button.common.search'></s:text></a></td>
		</tr>
	</table>
</div>
<div id="content">
<table id="_list_table">
	<thead>
		<tr>
			<th field="name" width="80" align="middle" sortable="true"><s:text name='label.sm.ds.name'></s:text></th>
			<th field="url" width="300" align="middle"><s:text name='label.sm.ds.url'></s:text></th>
			<th field="type" width="50" align="middle"><s:text name='label.sm.ds.type'></s:text></th>
<!--			<th field="driverClass" width="150" align="middle"><s:text name='label.sm.ds.driverClass'></s:text></th>-->
			<th field="userName" width="100" align="middle"><s:text name='label.sm.ds.userName'></s:text></th>
			<th field="password" width="100" align="middle"><s:text name='label.sm.ds.password'></s:text></th>
			<th field="remark" width="150" align="middle"><s:text name='label.sm.ds.remark'></s:text></th>
			<th field="action" width="100" align="middle" formatter="actionFormatter"><s:text name='label.sm.common.action'></s:text></th>
		</tr>
	</thead>
</table>
</div>
</div> 
</body>
</html>