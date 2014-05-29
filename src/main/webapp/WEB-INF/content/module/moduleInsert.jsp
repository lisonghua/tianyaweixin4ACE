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
	_function_editor_obj=$('#_function_editor_panel').panel({
			//height:430
		});
	_function_form_obj=$('#moduleForm');
	_function_form_obj.validate({
			rules:{
				name:{
					required: true,
					maxlength:100
				},
				parentId:{
					required: true
				},
				path:{
					maxlength:200
				},
				indexPage:{
					maxlength:200
				},
				isLeaf:{
					required: true
				},
				sysModule:{
					required: true
				},
				privilegeModule:{
					required: true
				},
				orderNum:{
					digits:true,
					required: true
				},
				moduleStatus:{
					required: true
				},
				remark:{
					maxlength:300
				}
			},
			showErrors:showErrors
		});
	$('#parentId').combotree({
		url:"${ctx}/pm/module/module!getNodes.action",
		panelHeight:300,
		panelWidth:200,
	    editable:false
	});
	$('#isLeaf').combobox({
	    url:'${ctx}/common/dic/dic!getDicByParent.action?_dic_parent=0&_dic_code=module_type',
	    editable:false,
	    valueField:'code',
	    textField:'value'
	});
	$('#sysModule').combobox({
	    url:'${ctx}/common/dic/dic!getDicByParent.action?_dic_parent=0&_dic_code=yes_or_no',
	    editable:false,
	    valueField:'code',
	    textField:'value'
	});
	$('#privilegeModule').combobox({
	    url:'${ctx}/common/dic/dic!getDicByParent.action?_dic_parent=0&_dic_code=yes_or_no',
	    editable:false,
	    valueField:'code',
	    textField:'value'
	});
	$('#moduleStatus').combobox({
	    url:'${ctx}/common/dic/dic!getDicByParent.action?_dic_parent=0&_dic_code=module_status',
	    editable:false,
	    valueField:'code',
	    textField:'value'
	});
});
function save(){
	_function_form_obj.form('submit',{
		url:'${ctx}/pm/module/module!save.action',
		success:function(data){
			eval('data='+data);
			if(data.success){
				$.messager.alert('Info',data.message,'info');
			}else{
				$.messager.alert('Error',data.message,'error');
			}
		},
		onSubmit:function(){
			if(_function_form_obj.valid())
				return true;
			else
				return false;
		}
	});
}
function toBack(){
	window.location='${ctx}/pm/module/module!forQuery.action';
}
//-->
</script>
<body>
<div id="_function_editor_panel" style="background:#fafafa;padding:10px;" >
	<form id="moduleForm" method="post">
	<input type="hidden" name="moduleId" value="${moduleId}"/>
		<table>
			<tr>
				<td><s:text name='label.pm.module.name'></s:text>：</td>
				<td><input type="text" id="name" name="name" value="${name}" size="50"></input></td>
			</tr>
			<tr>
				<td><s:text name='label.pm.module.parent'></s:text>：</td>
				<td><input id="parentId" name="parentId" value="${parentId}"></input></td>
			</tr>
			<tr>
				<td><s:text name='label.pm.module.url'></s:text>：</td>
				<td><input type="text" id="path" name="path" value="${path}" size="100"></input></td>
			</tr>
			<tr>
				<td><s:text name='label.pm.module.homepage'></s:text>：</td>
				<td><input type="text" id="indexPage" name="indexPage" value="${indexPage}" size="100"></input></td>
			</tr>
			<tr>
				<td><s:text name='label.pm.module.isFunctionOrModule'></s:text>：</td>
				<td><input id="isLeaf" name="isLeaf" value="${isLeaf}" readonly="readonly"/></td>
			</tr>
			<tr>
				<td><s:text name='label.pm.module.isSystemModule'></s:text>：</td>
				<td><input id="sysModule" name="sysModule" value="${sysModule}"/></td>
			</tr>
			<tr>
				<td><s:text name='label.pm.module.isPrivilegeModule'></s:text>：</td>
				<td><input id="privilegeModule" name="privilegeModule" value="${privilegeModule}"/></td>
			</tr>
			<tr>
				<td><s:text name='label.pm.module.order'></s:text>：</td>
				<td><input id="orderNum" name="orderNum" value="${orderNum}"/></td>
			</tr>
			<tr>
				<td><s:text name='label.pm.module.status'></s:text>：</td>
				<td><input id="moduleStatus" name="moduleStatus" value="${moduleStatus}"/></td>
			</tr>
			<tr>
				<td><s:text name='label.pm.module.remark'></s:text>：</td>
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