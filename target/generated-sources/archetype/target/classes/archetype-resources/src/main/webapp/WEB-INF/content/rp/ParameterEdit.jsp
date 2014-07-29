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
			height:600,
			border:false,
			noheader:true,
			top:0,
			left:0
		});
	_editor_form_obj=${symbol_dollar}('${symbol_pound}_editor_form');
	_editor_form_obj.validate({
			rules:{
				rpParamId:{
						required: true,
						maxlength:255
				},
				definition:{
						required: true,
						maxlength:255
				},
				name:{
						required: true,
						maxlength:50
				},
				expression:{
						maxlength:200
				},
				type:{
						required: true,
						maxlength:2
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
			url:"${symbol_dollar}{ctx}/genpact/parameter/parameter!save.action",
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
	window.location='${symbol_dollar}{ctx}/genpact/parameter/parameter!forQuery.action';
}
//-->
</script>
<body>
<div id="_editor_panel" style="background:${symbol_pound}fafafa;padding:5px;" >
	<form id="_editor_form" method="post">
	<input type="hidden" name="rpParamId" value="${symbol_dollar}{rpParamId}"/>
		<table>
				<tr>
					<td>Definition：</td>
					<td><input type="text" id="definition" name="definition" value="${symbol_dollar}{definition}" size="100"></input></td>
				</tr>
				<tr>
					<td>Name：</td>
					<td><input type="text" id="name" name="name" value="${symbol_dollar}{name}" size="100"></input></td>
				</tr>
				<tr>
					<td>Expression：</td>
					<td><input type="text" id="expression" name="expression" value="${symbol_dollar}{expression}" size="100"></input></td>
				</tr>
				<tr>
					<td>Type：</td>
					<td><input type="text" id="type" name="type" value="${symbol_dollar}{type}" size="100"></input></td>
				</tr>
				<tr>
					<td>Remark：</td>
					<td><input type="text" id="remark" name="remark" value="${symbol_dollar}{remark}" size="100"></input></td>
				</tr>
		</table>
		<br />
		<div style="text-align: center;">
			<a href="${symbol_pound}${symbol_pound}" onclick="save()" class="easyui-linkbutton" id="btn-save" icon="icon-save"><s:text name='button.common.save'></s:text></a>
			<a href="${symbol_pound}${symbol_pound}" onclick="goBack()" class="easyui-linkbutton" id="btn-undo" icon="icon-cancel"><s:text name='button.common.return'></s:text></a>
		</div>
	</form>
</div>
</body>
</html>