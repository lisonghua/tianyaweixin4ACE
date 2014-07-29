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
	_editor_panel_obj=${symbol_dollar}('${symbol_pound}_editor_panel').panel({
			//height:430
		border:false,
		noheader:true,
		top:0,
		left:0
		});
	_editor_form_obj=${symbol_dollar}('${symbol_pound}_editor_form');
	_editor_form_obj.validate({
			rules:{
				name:{
					required: true,
					maxlength:50
				},
				jndiName:{
					required: true,
					maxlength:50
				},
				serviceName:{
					required: true,
					maxlength:100
				},
				remark:{
					maxlength:200
				}
			},
			showErrors:showErrors
		});
});
function save(){
	_editor_form_obj.ajaxSubmit({
			url:"${symbol_dollar}{ctx}/sm/connectionpool/connectionpool!save.action",
			type: 'POST',
			dataType:'json',
			beforeSubmit:function(formData, jqForm, options){
				if(_editor_form_obj.valid())
					return true;
				else
					return false;
			},
			success:function(responseText, statusText, xhr, jqForm){
				if(responseText.success){
	                ${symbol_dollar}.messager.alert("<s:text name='label.common.success'></s:text>",responseText.message,"info");
	        	}else{
	        		${symbol_dollar}.messager.alert("<s:text name='label.common.error'></s:text>",responseText.message,"error");
	            }
			}
		});
}
function goBack(){
	window.location='${symbol_dollar}{ctx}/sm/server/server!forView.action?serverId=${symbol_dollar}{serverId}';
}
//-->
</script>
<body>
<div id="_editor_panel" style="background:${symbol_pound}fafafa;padding:10px;" >
	<form id="_editor_form" method="post">
	<input type="hidden" name="connectionpoolId" value="${symbol_dollar}{connectionpoolId}"/>
	<input type="hidden" name="serverId" value="${symbol_dollar}{serverId}"/>
		<table>
			<tr>
				<td><s:text name='label.sm.connectionpool.name'></s:text>：</td>
				<td><input type="text" id="name" name="name" value="${symbol_dollar}{name}" size="50"></input></td>
			</tr>
			<tr>
				<td><s:text name='label.sm.connectionpool.jndiName'></s:text>：</td>
				<td><input type="text" id="jndiName" name="jndiName" value="${symbol_dollar}{jndiName}" size="50"></input></td>
			</tr>
			<tr>
				<td><s:text name='label.sm.connectionpool.serviceName'></s:text>：</td>
				<td><input type="text" id="serviceName" name="serviceName" value="${symbol_dollar}{serviceName}" size="50"></input></td>
			</tr>
			<tr>
				<td><s:text name='label.sm.server.remark'></s:text>：</td>
				<td><textarea id="remark" name="remark" rows="5" cols="100">${symbol_dollar}{remark}</textarea></td>
			</tr>
		</table>
		<br />
		<div style="text-align: center;">
			<a href="${symbol_pound}${symbol_pound}" onclick="save()" class="easyui-linkbutton" id="btn-save" icon="icon-save"><s:text name='button.common.save'></s:text></a>
			<a href="${symbol_pound}${symbol_pound}" onclick="goBack()" class="easyui-linkbutton" id="btn-undo" icon="icon-undo"><s:text name='button.common.return'></s:text></a>
		</div>
	</form>
</div>
</body>
</html>