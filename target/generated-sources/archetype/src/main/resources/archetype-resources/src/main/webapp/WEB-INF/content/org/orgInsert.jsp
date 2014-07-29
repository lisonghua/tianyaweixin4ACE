#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML ${version} Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>Home Page</title>
	<%@ include file="/common/header.jsp" %>
</head>
<script type="text/javascript">
<!--
${symbol_dollar}(function(){
	_org_editor_obj=${symbol_dollar}('${symbol_pound}_org_editor_panel').panel({
			//height:430
		border:false,
		noheader:true,
		top:0,
		left:0
		});
	_org_form_obj=${symbol_dollar}('${symbol_pound}orgForm');
	_org_form_obj.validate({
			rules:{
				name:{
					required: true,
					maxlength:50
				},
				parentId:{
					required: true
				},
				orgCode:{
					required: true,
					maxlength:50
				},
				remark:{
					maxlength:200
				}
			},
			showErrors:showErrors
		});
	/*
	${symbol_dollar}('${symbol_pound}parentId').combotree({
		url:"${symbol_dollar}{ctx}/pm/module/module!getNodes.action",
	    editable:false
	});
	*/
	${symbol_dollar}('${symbol_pound}orgStatus').combobox({
	    url:'${symbol_dollar}{ctx}/common/dic/dic!getDicByParent.action?_dic_parent=0&_dic_code=org_status',
	    editable:false,
	    valueField:'code',
	    textField:'value'
	});
});
function save(){
	_org_form_obj.form('submit',{
		url:'${symbol_dollar}{ctx}/pm/org/organization!save.action',
		success:function(data){
			eval('data='+data);
			if(data.success){
				${symbol_dollar}.messager.alert('Info',data.message,'info');
			}else{
				${symbol_dollar}.messager.alert('Error',data.message,'error');
			}
		},
		onSubmit:function(){
			if(_org_form_obj.valid())
				return true;
			else
				return false;
		}
	});
}
function toBack(){
	window.location='${symbol_dollar}{ctx}/pm/org/organization!forQuery.action';
}
//-->
</script>
<body>
<div id="_org_editor_panel" style="background:${symbol_pound}fafafa;padding:10px;" >
	<form id="orgForm" method="post">
	<input type="hidden" name="organizationId" value="${symbol_dollar}{organizationId}"/>
		<table>
			<tr>
				<td><s:text name='label.pm.org.name'></s:text>：</td>
				<td><input type="text" id="name" name="name" value="${symbol_dollar}{name}" size="50"></input></td>
			</tr>
			<tr>
				<td><s:text name='label.pm.org.parentOrg'></s:text>：</td>
				<td><input id="parentId" name="parentId" value="${symbol_dollar}{parentId}"></input></td>
			</tr>
			<tr>
				<td><s:text name='label.pm.org.code'></s:text>：</td>
				<td><input type="text" id="orgCode" name="orgCode" value="${symbol_dollar}{orgCode}" size="100"></input></td>
			</tr>
			<tr>
				<td><s:text name='label.pm.org.status'></s:text>：</td>
				<td><input type="text" id="orgStatus" name="orgStatus" value="${symbol_dollar}{orgStatus}" size="100"></input></td>
			</tr>
			<tr>
				<td><s:text name='label.pm.org.remark'></s:text>：</td>
				<td><textarea id="remark" name="remark" rows="5" cols="100">${symbol_dollar}{remark}</textarea></td>
			</tr>
		</table>
		<br />
		<div style="text-align: center;">
			<a href="${symbol_pound}${symbol_pound}" onclick="save()" class="easyui-linkbutton" id="btn-save" icon="icon-save"><s:text name='button.common.save'></s:text></a>
			<a href="${symbol_pound}${symbol_pound}" onclick="toBack()" class="easyui-linkbutton" id="btn-undo" icon="icon-undo"><s:text name='button.common.return'></s:text></a>
		</div>
	</form>
</div>
</body>
</html>