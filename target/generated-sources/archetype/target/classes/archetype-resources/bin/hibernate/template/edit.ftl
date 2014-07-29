<#assign identifier = clazz.getIdentifierProperty()>
<#assign declarationName = pojo.importType(pojo.getDeclarationName())>
<#assign entityName = declarationName?uncap_first>
<#assign isIdentifier = pojo.hasIdentifierProperty()>
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
	_${entityName}_editor_panel_obj=$('#_${entityName}_editor_panel').panel({
			//height:430,
			border:false,
			noheader:true,
			top:0,
			left:0
		});
	_${entityName}_editor_form_obj=$('#_${entityName}_editor_form');
	_${entityName}_editor_form_obj.validate({
			rules:{
			<#assign properties = pojo.getAllPropertiesIterator()>
			<#foreach field in properties>
				<#if !field.equals(clazz.identifierProperty)>
					<#assign fValue = field.getValue()>
					<#assign colSpan = field.getColumnSpan()>
					${field.name}:{
						<#if !fValue.isNullable()>
							required: true,
						</#if>
						<#if colSpan=1>
							<#assign column = field.getColumnIterator().next()>
							maxlength:${column.getLength()}
						</#if>
						
					}<#if field_has_next>,</#if>
				</#if>
			</#foreach>
			},
			showErrors:showErrors
		});
});
function save${declarationName}(){
	_${entityName}_editor_form_obj.ajaxSubmit({
			url:"${r"${ctx}"}/${modelName}/${subModelName}/${entityName}/${entityName}!save.action",
			type: 'POST',
			dataType:'json',
			beforeSubmit:function(formData, jqForm, options){
				if(_${entityName}_editor_form_obj.valid())
					return true;
				else
					return false;
			},
			success:function(responseText, statusText, xhr, jqForm){
				if(responseText.success){
	                $.messager.alert("<s:text name='label.common.success'></s:text>",responseText.message,"info");
	        	}else{
	        		$.messager.alert("<s:text name='label.common.error'></s:text>",responseText.message,"error");
	            }
			}
		});
}
function goBack${declarationName}Query(){
	window.location='${r"${ctx}"}/${modelName}/${subModelName}/${entityName}/${entityName}!forQuery.action';
}
//-->
</script>
<body>
<div id="_${entityName}_editor_panel" style="background:#fafafa;padding:5px;" >
	<form id="_${entityName}_editor_form" method="post">
	<input type="hidden" name="${clazz.identifierProperty.name}" value="${r"${"}${clazz.identifierProperty.name}${r"}"}"/>
		<table>
			<#foreach field in pojo.getAllPropertiesIterator()>
				<#assign title = field.name?cap_first>
				<#assign column = field.getColumnIterator().next()>
				<#if !field.equals(clazz.identifierProperty)>
				<tr>
					<td>${title}：</td>
					<td><input type="text" id="${field.name}" name="${field.name}" value="${r"${"}${field.name}${r"}"}" size="80"></input></td>
				</tr>
				</#if>
			</#foreach>
		</table>
		<br />
		<div style="text-align: center;">
			<a href="##" onclick="save${declarationName}()" class="easyui-linkbutton" id="btn-save-${entityName}" icon="icon-save"><s:text name='button.common.save'></s:text></a>
			<a href="##" onclick="goBack${declarationName}Query()" class="easyui-linkbutton" id="btn-undo-${entityName}" icon="icon-cancel"><s:text name='button.common.return'></s:text></a>
		</div>
	</form>
</div>
</body>
</html>