<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>Home Page</title>
	<%@ include file="/common/header.jsp" %>
</head>
<script type="text/javascript">
<!--
$(function(){
	_org_editor_obj=$('#_org_editor_panel').panel({
			//height:430
		border:false,
		noheader:true,
		top:0,
		left:0
		});
	_org_form_obj=$('#orgForm');
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
	$('#parentId').combotree({
		url:"${ctx}/pm/module/module!getNodes.action",
	    editable:false
	});
	*/
	$('#orgStatus').combobox({
	    url:'${ctx}/common/dic/dic!getDicByParent.action?_dic_parent=0&_dic_code=org_status',
	    editable:false,
	    valueField:'code',
	    textField:'value'
	});
});
function save(){
	_org_form_obj.form('submit',{
		url:'${ctx}/pm/org/organization!save.action',
		success:function(data){
			eval('data='+data);
			if(data.success){
				$.messager.alert('Info',data.message,'info');
			}else{
				$.messager.alert('Error',data.message,'error');
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
	window.location='${ctx}/pm/org/organization!forQuery.action';
}
//-->
</script>
<body>
<div id="_org_editor_panel" style="background:#fafafa;padding:10px;" >
	<form id="orgForm" method="post">
	<input type="hidden" name="organizationId" value="${organizationId}"/>
		<table>
			<tr>
				<td><s:text name='label.pm.org.name'></s:text>：</td>
				<td><input type="text" id="name" name="name" value="${name}" size="50"></input></td>
			</tr>
			<tr>
				<td><s:text name='label.pm.org.parentOrg'></s:text>：</td>
				<td><input id="parentId" name="parentId" value="${parentId}"></input></td>
			</tr>
			<tr>
				<td><s:text name='label.pm.org.code'></s:text>：</td>
				<td><input type="text" id="orgCode" name="orgCode" value="${orgCode}" size="100"></input></td>
			</tr>
			<tr>
				<td><s:text name='label.pm.org.status'></s:text>：</td>
				<td><input type="text" id="orgStatus" name="orgStatus" value="${orgStatus}" size="100"></input></td>
			</tr>
			<tr>
				<td><s:text name='label.pm.org.remark'></s:text>：</td>
				<td><textarea id="remark" name="remark" rows="5" cols="100">${remark}</textarea></td>
			</tr>
		</table>
		<br />
		<div style="text-align: center;">
			<a href="##" onclick="save()" class="easyui-linkbutton" id="btn-save" icon="icon-save"><s:text name='button.common.save'></s:text></a>
			<a href="##" onclick="toBack()" class="easyui-linkbutton" id="btn-undo" icon="icon-undo"><s:text name='button.common.return'></s:text></a>
		</div>
	</form>
</div>
</body>
</html>