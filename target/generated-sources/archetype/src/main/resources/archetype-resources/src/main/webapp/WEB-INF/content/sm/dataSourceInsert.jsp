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
					//required: true,
					maxlength:50
				},
				url:{
					required: true,
					maxlength:300
				},
				type:{
					required: true
				},
				userName:{
					required: true,
					maxlength:20
				},
				password:{
					required: true,
					maxlength:20
				},
				remark:{
					maxlength:200
				}
			},
			showErrors:showErrors
		});
	${symbol_dollar}('${symbol_pound}type').combobox({
	    url:'${symbol_dollar}{ctx}/common/dic/dic!getDicByParent.action?_dic_parent=0&_dic_code=db_type',
	    editable:false,
	    valueField:'code',
	    textField:'value'
	});
});
function save(){
	_editor_form_obj.ajaxSubmit({
			url:"${symbol_dollar}{ctx}/sm/datasource/datasource!save.action",
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
	window.location='${symbol_dollar}{ctx}/sm/datasource/datasource!forQuery.action';
}
//-->
</script>
<body>
<div id="_editor_panel" style="background:${symbol_pound}fafafa;padding:10px;" >
	<form id="_editor_form" method="post">
	<input type="hidden" name="dsId" value="${symbol_dollar}{dsId}"/>
		<table>
			<tr>
				<td><s:text name='label.sm.ds.name'></s:text>：</td>
				<td><input type="text" id="name" name="name" value="${symbol_dollar}{name}" size="50"></input></td>
			</tr>
			<tr>
				<td><s:text name='label.sm.ds.type'></s:text>：</td>
				<td><input id="type" name="type" value="${symbol_dollar}{type}" readonly="readonly"/></td>
			</tr>
			<tr>
				<td><s:text name='label.sm.ds.url'></s:text>：</td>
				<td><input type="text" id="url" name="url" value="${symbol_dollar}{url}" size="50"></input></td>
			</tr>
<!--			<tr>-->
<!--				<td><s:text name='label.sm.ds.driverClass'></s:text>：</td>-->
<!--				<td><input type="text" id="driverClass" name="driverClass" value="${symbol_dollar}{driverClass}" size="50"></input></td>-->
<!--			</tr>-->
			<tr>
				<td><s:text name='label.sm.ds.userName'></s:text>：</td>
				<td><input type="text" id="userName" name="userName" value="${symbol_dollar}{userName}" size="50"></input></td>
			</tr>
			<tr>
				<td><s:text name='label.sm.ds.password'></s:text>：</td>
				<td><input type="text" id="password" name="password" value="${symbol_dollar}{password}" size="50"></input></td>
			</tr>
			<tr>
				<td><s:text name='label.sm.ds.remark'></s:text>：</td>
				<td><textarea id="remark" name="remark" rows="5" cols="100">${symbol_dollar}{remark}</textarea></td>
			</tr>
		</table>
		<br />
		<div style="text-align: center;">
			<a href="javascript:void(0)" onclick="save()" class="easyui-linkbutton" id="btn-save" icon="icon-save"><s:text name='button.common.save'></s:text></a>
			<a href="javascript:void(0)" onclick="goBack()" class="easyui-linkbutton" id="btn-undo" icon="icon-undo"><s:text name='button.common.return'></s:text></a>
		</div>
	</form>
</div>
</body>
</html>