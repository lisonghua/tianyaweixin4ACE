<#assign identifier = clazz.getIdentifierProperty()>
<#assign declarationName = pojo.importType(pojo.getDeclarationName())>
<#assign entityName = declarationName?uncap_first>
<#assign isIdentifier = pojo.hasIdentifierProperty()>
<#if isIdentifier>
	<#assign propType = identifier.getValue().getTypeName()>
	<#assign propTypeName = propType?lower_case>
	<#if propTypeName == "integer">
		<#assign filterOperator = "EQI">
	<#elseif propTypeName == "long">
		<#assign filterOperator = "EQL">
	<#elseif propTypeName == "double">
		<#assign filterOperator = "EQD">
	<#else>
		<#assign filterOperator = "EQS">
	</#if>
</#if>
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
	_${entityName}_list_panel_obj=$('#_${entityName}_list_panel').panel({
			//height:600,
			border:false,
			noheader:true,
			top:0,
			left:0
		});
	_${entityName}_list_grid_obj=$('#_${entityName}_list_table').datagrid({
		title:'',
		url:'${r"${ctx}"}/${modelName}/${subModelName}/${entityName}/${entityName}!search.action',//加载表格数据的URL
		singleSelect:true,
		height:500,
		idField:'${identifier.getName()}',
		pagination:true,
		pageSize:15,
		pageNumber:1,
		pageList:[10,15],
		rownumbers:true,
		sortName:'${identifier.getName()}',
	    sortOrder:'asc',
	    striped:true,
	    toolbar:[{
	        text:'<s:text name="button.common.add"></s:text>',
	        iconCls:'icon-add',
	        handler:function(){
	        	//点击添加按钮的URL
	    		window.location='${r"${ctx}"}/${modelName}/${subModelName}/${entityName}/${entityName}!forInsert.action';
	    		return false;
	        }
	    }]
	});
});
//点击修改按钮转向的URL
function  edit${declarationName}Row(id){
	window.location='${r"${ctx}"}/${modelName}/${subModelName}/${entityName}/${entityName}!forUpdate.action?${identifier.getName()}='+id;
}
//点击删除按钮的URL
function  delete${declarationName}Row(id){
	$.messager.confirm("Confirm","<s:text name='message.common.delete.confirm'></s:text>",function(flag){
		if(flag){
			$.ajax({
					url:'${r"${ctx}"}/${modelName}/${subModelName}/${entityName}/${entityName}!delete.action?${identifier.getName()}='+id,//删除调用的URL
					type: 'GET',
					dataType:'json',
					error:function(){
						$.messager.alert("<s:text name='label.common.error'></s:text>","<s:text name='message.common.delete.failure'></s:text>",'error');
					},
					success:function(data){
						if(data.success){
							_${entityName}_list_grid_obj.datagrid('reload',{});
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
function actionFormatter4${declarationName}(value,rowData,rowIndex){
	var id = rowData.${identifier.getName()};
	var e = '<img onclick="edit${declarationName}Row(\''+id+'\')" src="${r"${ctx}"}/image/edit.gif" title="'+"<s:text name='button.common.modify'></s:text>"+'" style="cursor:hand;"/>';   
    var d = '<img onclick="delete${declarationName}Row(\''+id+'\')" src="${r"${ctx}"}/image/delete.gif" title="'+"<s:text name='button.common.delete'></s:text>"+'" style="cursor:hand;"/>';
    return e+'&nbsp;'+d;
}
//点击查询按钮的操作函数
function search${declarationName}ByFilter(){
	var ${identifier.getName()}=document.getElementById("filter_${filterOperator}_${clazz.identifierProperty.name}").value;
	_${entityName}_list_grid_obj.datagrid('reload',{
		filter_${filterOperator}_${clazz.identifierProperty.name}:${identifier.getName()}
	});
}
//-->
</script>
<body>
<div id="_${entityName}_list_panel" style="padding:5px;">
<#if isIdentifier>
<!--***************************查询部分开始*************************************-->
<!--
查询操作符规则如下：
	属性比较类型：EQ(=), LIKE(like), LT(<), GT(>), LE(<=), GE(>=)
	属性数据类型：S(String.class), I(Integer.class), L(Long.class), N(Double.class), D(Date.class), B(Boolean.class)
-->
	<div>
	<table border="0">
		<tr>
			<td>${clazz.identifierProperty.name?cap_first}:</td>
			<td><input type="text" id="filter_${filterOperator}_${clazz.identifierProperty.name}" name="filter_${filterOperator}_${clazz.identifierProperty.name}" value="" size="9"/></td>
			<td><a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="search${declarationName}ByFilter();"><s:text name='button.common.search'></s:text></a></td>
		</tr>
	</table>
	</div>
<!--***************************查询部分结束*************************************-->
</#if>
<!--***************************表格部分开始*************************************-->
<div id="_${entityName}_content">
<table id="_${entityName}_list_table">
	<thead>
		<tr>
		<#foreach field in pojo.getAllPropertiesIterator()>
			<#assign title = field.name?cap_first>
			<th field="${field.name}" width="100" align="middle" <#if field.equals(clazz.identifierProperty)>sortable="true"</#if>>${title}</th>
		</#foreach>
			<th field="action" width="100" align="middle" formatter="actionFormatter4${declarationName}"><s:text name='label.sm.common.action'></s:text></th>
		</tr>
	</thead>
</table>
</div>
<!--***************************表格部分结束*************************************-->
</div> 
</body>
</html>
