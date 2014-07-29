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
			height:600,
			border:false,
			noheader:true,
			top:0,
			left:0
		});
	_list_grid_obj=${symbol_dollar}('${symbol_pound}_list_table').datagrid({
		title:'',
		url:'${symbol_dollar}{ctx}/genpact/folder/folder!search.action',//加载表格数据的URL
		singleSelect:true,
		height:400,
		idField:'rpFolderId',
		pagination:true,
		pageSize:15,
		pageNumber:1,
		pageList:[10,15],
		rownumbers:true,
		sortName:'rpFolderId',
	    sortOrder:'asc',
	    striped:true,
	    toolbar:[{
	        text:'<s:text name="button.common.add"></s:text>',
	        iconCls:'icon-add',
	        handler:function(){
	        	//点击添加按钮的URL
	    		window.location='${symbol_dollar}{ctx}/genpact/folder/folder!forInsert.action';
	    		return false;
	        }
	    }]
	});
});
//点击修改按钮转向的URL
function  editRow(id){
	window.location='${symbol_dollar}{ctx}/genpact/folder/folder!forUpdate.action?rpFolderId='+id;
}
//点击删除按钮的URL
function  deleteRow(id){
	${symbol_dollar}.messager.confirm("Confirm","<s:text name='message.common.delete.confirm'></s:text>",function(flag){
		if(flag){
			${symbol_dollar}.ajax({
					url:'${symbol_dollar}{ctx}/genpact/folder/folder!delete.action?rpFolderId='+id,//删除调用的URL
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
//输出每一行末尾的操作按钮
function actionFormatter(value,rowData,rowIndex){
	var id = rowData.rpFolderId;
	var e = '<img onclick="editRow(${symbol_escape}''+id+'${symbol_escape}')" src="${symbol_dollar}{ctx}/image/edit.gif" title="'+"<s:text name='button.common.modify'></s:text>"+'" style="cursor:hand;"/>';   
    var d = '<img onclick="deleteRow(${symbol_escape}''+id+'${symbol_escape}')" src="${symbol_dollar}{ctx}/image/delete.gif" title="'+"<s:text name='button.common.delete'></s:text>"+'" style="cursor:hand;"/>';
    return e+'&nbsp;'+d;
}
//点击查询按钮的操作函数
function searchByFilter(){
	var rpFolderId=document.getElementById("filter_EQI_rpFolderId").value;
	_list_grid_obj.datagrid('reload',{
		filter_EQI_rpFolderId:rpFolderId
	});
}
//-->
</script>
<body>
<div id="_list_panel" style="padding:5px;">
<!--***************************查询部分开始*************************************-->
<!--
查询操作符规则如下：
	属性比较类型：EQ(=), LIKE(like), LT(<), GT(>), LE(<=), GE(>=)
	属性数据类型：S(String.class), I(Integer.class), L(Long.class), N(Double.class), D(Date.class), B(Boolean.class)
-->
	<div id="filter">
	<table border="0">
		<tr>
			<td>RpFolderId:</td>
			<td><input type="text" name="filter_EQI_rpFolderId" value="" size="9"/></td>
			<td><a href="${symbol_pound}" class="easyui-linkbutton" iconCls="icon-search" onclick="searchByFilter();"><s:text name='button.common.search'></s:text></a></td>
		</tr>
	</table>
	</div>
<!--***************************查询部分结束*************************************-->
<!--***************************表格部分开始*************************************-->
<div id="content">
<table id="_list_table">
	<thead>
		<tr>
			<th field="rpFolderId" width="100" align="middle" sortable="true">RpFolderId</th>
			<th field="name" width="100" align="middle" >Name</th>
			<th field="path" width="100" align="middle" >Path</th>
			<th field="remark" width="100" align="middle" >Remark</th>
			<th field="action" width="100" align="middle" formatter="actionFormatter"><s:text name='label.sm.common.action'></s:text></th>
		</tr>
	</thead>
</table>
</div>
<!--***************************表格部分结束*************************************-->
</div> 
</body>
</html>
