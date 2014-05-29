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
			height:600,
			border:false,
			noheader:true,
			top:0,
			left:0
		});
	_list_grid_obj=$('#_list_table').datagrid({
		title:'',
		url:'${ctx}/genpact/parameter/parameter!search.action',//加载表格数据的URL
		singleSelect:true,
		height:400,
		idField:'rpParamId',
		pagination:true,
		pageSize:15,
		pageNumber:1,
		pageList:[10,15],
		rownumbers:true,
		sortName:'rpParamId',
	    sortOrder:'asc',
	    striped:true,
	    toolbar:[{
	        text:'<s:text name="button.common.add"></s:text>',
	        iconCls:'icon-add',
	        handler:function(){
	        	//点击添加按钮的URL
	    		window.location='${ctx}/genpact/parameter/parameter!forInsert.action';
	    		return false;
	        }
	    }]
	});
});
//点击修改按钮转向的URL
function  editRow(id){
	window.location='${ctx}/genpact/parameter/parameter!forUpdate.action?rpParamId='+id;
}
//点击删除按钮的URL
function  deleteRow(id){
	$.messager.confirm("Confirm","<s:text name='message.common.delete.confirm'></s:text>",function(flag){
		if(flag){
			$.ajax({
					url:'${ctx}/genpact/parameter/parameter!delete.action?rpParamId='+id,//删除调用的URL
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
//输出每一行末尾的操作按钮
function actionFormatter(value,rowData,rowIndex){
	var id = rowData.rpParamId;
	var e = '<img onclick="editRow(\''+id+'\')" src="${ctx}/image/edit.gif" title="'+"<s:text name='button.common.modify'></s:text>"+'" style="cursor:hand;"/>';   
    var d = '<img onclick="deleteRow(\''+id+'\')" src="${ctx}/image/delete.gif" title="'+"<s:text name='button.common.delete'></s:text>"+'" style="cursor:hand;"/>';
    return e+'&nbsp;'+d;
}
//点击查询按钮的操作函数
function searchByFilter(){
	var rpParamId=document.getElementById("filter_EQI_rpParamId").value;
	_list_grid_obj.datagrid('reload',{
		filter_EQI_rpParamId:rpParamId
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
			<td>RpParamId:</td>
			<td><input type="text" name="filter_EQI_rpParamId" value="" size="9"/></td>
			<td><a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="searchByFilter();"><s:text name='button.common.search'></s:text></a></td>
		</tr>
	</table>
	</div>
<!--***************************查询部分结束*************************************-->
<!--***************************表格部分开始*************************************-->
<div id="content">
<table id="_list_table">
	<thead>
		<tr>
			<th field="rpParamId" width="100" align="middle" sortable="true">RpParamId</th>
			<th field="definition" width="100" align="middle" >Definition</th>
			<th field="name" width="100" align="middle" >Name</th>
			<th field="expression" width="100" align="middle" >Expression</th>
			<th field="type" width="100" align="middle" >Type</th>
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
