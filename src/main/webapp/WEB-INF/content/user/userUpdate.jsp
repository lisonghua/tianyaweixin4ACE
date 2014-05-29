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
	_user_editor_obj=$('#_user_editor').panel({
			//height:420,
			border:false
		});
	_user_form=$('#userForm');
	//为inputForm注册validate函数
	_user_form.validate({
		rules: {
			age:{
				digits:true,
				maxlength:2
			},
			sso: {
				required: true,
				remote: "${ctx}/pm/user/user!checkSso.action?oldSso=" + encodeURIComponent('${sso}'),
				maxlength:10
			},
			name: {
				required: true,
				maxlength:20
			},
			enName: {
				//required: true,
				maxlength:100
			},
			/*
			jpName: {
				//required: true,
				maxlength:100
			},
			*/
			title: {
				maxlength:100
			},
			email:{
				email:true,
				maxlength:50
			},
			folk:{
				maxlength:20
			},
			address:{
				maxlength:100
			},
			cellphone:{
				mobile:true,
				maxlength:20,
				minlength:10
			},
			telephone:{
				phone:true,
				maxlength:20
			},
			fax:{
				maxlength:20
			},
			msn:{
				maxlength:50
			},
			qq:{
				qq:true,
				maxlength:20
			},
			remark:{
				maxlength:200
			}
		},
		messages:{
			sso:{
				remote:"<s:text name='message.pm.user.sso.isExist'></s:text>"
			}
		},
		showErrors:showErrors
	});
	$('#orgId').combotree({
		url:"${ctx}/pm/org/organization!getNodes.action",
		panelWidth:200,
	    editable:true
	});
	$('#gender').combobox({
	    url:'${ctx}/common/dic/dic!getDicByParent.action?_dic_parent=0&_dic_code=sex',
	    editable:false,
	    valueField:'code',
	    textField:'value'
	});
	$('#supervisor').combobox({
		width:200,
		panelHeight:'auto',
	    url:'${ctx}/pm/user/user!getAllUsers.action',
	    valueField:'sso',
	    textField:'name',
	    filter:function(q,row){
	    	var opts = $(this).combobox("options");
	    	var textArray = row[opts.textField].split("|");
	    	var r = false;
	    	$.each(textArray,function(i,n){
					if(n.indexOf(q)==0){
						r = true;
						return false;
					}	
		    	});
		    return r;
		}
	});
});
function saveUser(){
	//alert(user_form);
	_user_form.form('submit',{
		url:'${ctx}/pm/user/user!savaUser.action',
		success:function(data){
			eval('data='+data);
			if(data.success){
				//_user_form.form('clear');
				$.messager.alert('Info',data.message,'info');
			}else{
				$.messager.alert('Error',data.message,'error');
			}
		},
		onSubmit:function(){
			if(_user_form.valid())
				return true;
			else
				return false;
		}
	});
}
function toBack(){
	window.location='${ctx}/pm/user/user!forQuery.action';
}
//-->
</script>
<body style="background:#fafafa;">
<div id="_user_editor" style="background:#fafafa;padding:10px;" >
<form id="userForm" method="post">
<input type="hidden" name="userId" value="${userId}"/>
<input type="hidden" id="pw" name="pw" value="${pw}"/>
<fieldset>
	<legend><s:text name='label.pm.user.basicInfo'></s:text></legend>
	<table>
			<tr>
				<td><s:text name='label.pm.user.name'></s:text>:</td>
				<td><input type="text" id="name" name="name" value="${name}"/></td>
				<td><s:text name='label.pm.user.enName'></s:text>:</td>
				<td><input type="text" id="enName" name="enName" value="${enName}"/></td>
			</tr>
<!--			<tr>-->
<!--				<td><s:text name='label.pm.user.jpName'></s:text>:</td>-->
<!--				<td colspan="3"><input type="text" id="jpName" name="jpName" value="${jpName}"/></td>-->
<!--			</tr>-->
			<tr>
				<td><s:text name='label.pm.user.sex'></s:text>:</td>
				<td width="350"><input type="text" id="gender" name="gender" value="${gender}"/></td>
				<td><s:text name='label.pm.user.age'></s:text>:</td>
				<td width="350"><input type="text" name="age" value="${age}" id="age" /></td>
			</tr>
			<tr>
				<td><s:text name='label.pm.user.nationality'></s:text>:</td>
				<td><input type="text" id="nationality" name="nationality" value="${nationality}"/></td>
				<td><s:text name='label.pm.user.folk'></s:text>:</td>
				<td><input type="text" name="folk" value="${folk}" id="folk" /></td>
			</tr>
			<tr>
				<td><s:text name='label.pm.user.prinvince'></s:text>:</td>
				<td><input type="text" id="province" name="province" value="${province}"/></td>
				<td><s:text name='label.pm.user.city'></s:text>:</td>
				<td><input type="text" name="city" value="${city}" id="city" /></td>
			</tr>
			<tr>
				<td><s:text name='label.pm.user.address'></s:text>:</td>
				<td><input type="text" id="address" name="address" value="${address}"/></td>
				<td><s:text name='label.pm.user.organization'></s:text>:</td>
				<td><input id="orgId" name="orgId" value="${organization.orgId}"/></td>
			</tr>
			<tr>
				<td><s:text name='label.pm.user.supervisor'></s:text>:</td>
				<td><input type="text" id="supervisor" name="supervisor" value="${supervisor}"/></td>
				<td><s:text name='label.pm.user.title'></s:text>:</td>
				<td><input type="text" id="title" name="title" value="${title}"/></td>
			</tr>
	</table>  
</fieldset>
<br/>
<fieldset>
	<legend><s:text name='label.pm.user.loginInfo'></s:text></legend>
	<table>
		<tr>
			<td><s:text name='label.pm.user.sso'></s:text>:</td>
			<td><input type="text" name="sso" value="${sso}" id="sso" /></td>
		</tr>
	</table>
</fieldset>
<br/>
<fieldset>
	<legend><s:text name='label.pm.user.contactInfo'></s:text></legend>
	<table>
		<tr>
			<td><s:text name='label.pm.user.cellphone'></s:text>:</td>
			<td><input type="text" id="cellphone" name="cellphone" value="${cellphone}"/></td>
		</tr>
		<tr>
			<td><s:text name='label.pm.user.telephone'></s:text>:</td>
			<td><input type="text" id="telephone" name="telephone" value="${telephone}"/></td>
		</tr>
		<tr>
			<td><s:text name='label.pm.user.fax'></s:text>:</td>
			<td><input type="text" id="fax" name="fax" value="${fax}"/></td>
		</tr>
		<tr>
			<td><s:text name='label.pm.user.email'></s:text>:</td>
			<td><input type="text" id="email" name="email" value="${email}"/></td>
		</tr>
		<tr>
			<td><s:text name='label.pm.user.msn'></s:text>:</td>
			<td><input type="text" id="msn" name="msn" value="${msn}"/></td>
		</tr>
		<tr>
			<td><s:text name='label.pm.user.qq'></s:text>:</td>
			<td><input type="text" id="qq" name="qq" value="${qq}"/></td>
		</tr>
	</table>
</fieldset>
<br/>
<fieldset>
	<legend><s:text name='label.pm.user.otherInfo'></s:text></legend>
	<table>
		<tr>
		<td><s:text name='label.pm.user.remark'></s:text>:</td>
		<td><textarea id="remark" name="remark" rows="5" cols="50">${remark}</textarea></td>
		</tr>
	</table>
</fieldset>
<br/>
</form>
</div>
<div style="background:#fafafa;text-align: center;">
		<a href="##" onclick="saveUser()" class="easyui-linkbutton" id="btn-save" icon="icon-save"><s:text name='button.common.save'></s:text></a>
		<a href="##" onclick="toBack()" class="easyui-linkbutton" id="btn-cancel" icon="icon-undo"><s:text name='button.common.return'></s:text></a>
</div>
</body>
</html>