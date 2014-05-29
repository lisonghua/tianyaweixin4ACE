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
	_editor_panel_obj=$('#_editor_panel').panel({
			//height:430
		border:false,
		noheader:true,
		top:0,
		left:0
		});
	_editor_form_obj=$('#_editor_form');
	_editor_form_obj.validate({
			rules:{
				name:{
					required: true,
					maxlength:50
				},
				ip:{
					required: true,
					maxlength:50
				},
				type:{
					maxlength:50
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
			url:"${ctx}/sm/appserver/appserver!save.action",
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
	                $.messager.alert("<s:text name='label.common.success'></s:text>",responseText.message,"info");
	        	}else{
	        		$.messager.alert("<s:text name='label.common.error'></s:text>",responseText.message,"error");
	            }
			}
		});
}
function goBack(){
	window.location='${ctx}/sm/appserver/appserver!forQuery.action';
}
//-->
</script>
<body>
<div id="_editor_panel" style="background:#fafafa;padding:10px;" >
	<form id="_editor_form" method="post">
	<input type="hidden" name="serverId" value="${serverId}"/>
		<table>
			<tr>
				<td><s:text name='label.sm.server.name'></s:text>：</td>
				<td><input type="text" id="name" name="name" value="${name}" size="50"></input></td>
			</tr>
			<tr>
				<td><s:text name='label.sm.server.ip'></s:text>：</td>
				<td><input type="text" id="ip" name="ip" value="${ip}" size="50"></input></td>
			</tr>
			<tr>
				<td><s:text name='label.sm.server.type'></s:text>：</td>
				<td><input type="text" id="type" name="type" value="${type}" size="50"></input></td>
			</tr>
			<tr>
				<td><s:text name='label.sm.server.remark'></s:text>：</td>
				<td><textarea id="remark" name="remark" rows="5" cols="100">${remark}</textarea></td>
			</tr>
		</table>
		<br />
		<div style="text-align: center;">
			<a href="##" onclick="save()" class="easyui-linkbutton" id="btn-save" icon="icon-save"><s:text name='button.common.save'></s:text></a>
			<a href="##" onclick="goBack()" class="easyui-linkbutton" id="btn-undo" icon="icon-undo"><s:text name='button.common.return'></s:text></a>
		</div>
	</form>
</div>
</body>
</html>