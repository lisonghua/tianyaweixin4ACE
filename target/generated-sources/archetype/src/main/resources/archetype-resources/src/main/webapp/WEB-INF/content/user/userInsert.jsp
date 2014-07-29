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
	_user_editor_obj=${symbol_dollar}('${symbol_pound}_user_editor').panel({
			//height:420,
			border:false,
			noheader:true,
			top:0,
			left:0
		});
	_user_form=${symbol_dollar}('${symbol_pound}userForm');
	//为inputForm注册validate函数
	_user_form.validate({
		rules: {
			age:{
				digits:true,
				maxlength:2
			},
			sso: {
				required: true,
				remote: "${symbol_dollar}{ctx}/pm/user/user!checkSso.action?oldSso=" + encodeURIComponent('${symbol_dollar}{sso}'),
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
			pw: {
				required: true,
				minlength:3,
				maxlength:10
			},
			passwordConfirm: {
				equalTo:"${symbol_pound}pw"
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
			},
			cellphone:{
				mobile:"<s:text name='message.pm.user.cellphone.fault'></s:text>"
			}
		},
		showErrors:showErrors
	});
	${symbol_dollar}('${symbol_pound}orgId').combotree({
		url:"${symbol_dollar}{ctx}/pm/org/organization!getNodes.action",
		panelWidth:200,
	    editable:true
	});
	${symbol_dollar}('${symbol_pound}gender').combobox({
	    url:'${symbol_dollar}{ctx}/common/dic/dic!getDicByParent.action?_dic_parent=0&_dic_code=sex',
	    editable:false,
	    valueField:'code',
	    textField:'value'
	});
	${symbol_dollar}('${symbol_pound}supervisor').combobox({
		width:200,
		panelHeight:'auto',
	    url:'${symbol_dollar}{ctx}/pm/user/user!getAllUsers.action',
	    valueField:'sso',
	    textField:'name',
	    filter:function(q,row){
	    	var opts = ${symbol_dollar}(this).combobox("options");
	    	var textArray = row[opts.textField].split("|");
	    	var r = false;
	    	${symbol_dollar}.each(textArray,function(i,n){
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
		url:'${symbol_dollar}{ctx}/pm/user/user!savaUser.action',
		success:function(data){
			eval('data='+data);
			if(data.success){
				_user_form.form('clear');
				${symbol_dollar}.messager.alert('Info',data.message,'info');
			}else{
				${symbol_dollar}.messager.alert('Error',data.message,'error');
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
	window.location='${symbol_dollar}{ctx}/pm/user/user!forQuery.action';
}
//-->
</script>
<body style="background:${symbol_pound}fafafa;">
<div id="_user_editor" style="overflow:auto;${symbol_pound}fafafa;padding:5px;" >
<form id="userForm" method="post">
<input type="hidden" name="userId" value="${symbol_dollar}{userId}"/>
<fieldset>
	<legend><s:text name='label.pm.user.basicInfo'></s:text></legend>
	<table>
			<tr>
				<td><s:text name='label.pm.user.name'></s:text>:</td>
				<td><input type="text" id="name" name="name" value="${symbol_dollar}{name}"/></td>
				<td><s:text name='label.pm.user.enName'></s:text>:</td>
				<td><input type="text" id="enName" name="enName" value="${symbol_dollar}{enName}"/></td>
			</tr>
<!--			<tr>-->
<!--				<td><s:text name='label.pm.user.jpName'></s:text>:</td>-->
<!--				<td colspan="3"><input type="text" id="jpName" name="jpName" value="${symbol_dollar}{jpName}"/></td>-->
<!--			</tr>-->
			<tr>
				<td><s:text name='label.pm.user.sex'></s:text>:</td>
				<td width="350"><input type="text" id="gender" name="gender" value="${symbol_dollar}{gender}"/></td>
				<td><s:text name='label.pm.user.age'></s:text>:</td>
				<td width="350"><input type="text" name="age" value="${symbol_dollar}{age}" id="age" /></td>
			</tr>
			<tr>
				<td><s:text name='label.pm.user.nationality'></s:text>:</td>
				<td><input type="text" id="nationality" name="nationality" value="${symbol_dollar}{nationality}"/></td>
				<td><s:text name='label.pm.user.folk'></s:text>:</td>
				<td><input type="text" name="folk" value="${symbol_dollar}{folk}" id="folk" /></td>
			</tr>
			<tr>
				<td><s:text name='label.pm.user.prinvince'></s:text>:</td>
				<td><input type="text" id="province" name="province" value="${symbol_dollar}{province}"/></td>
				<td><s:text name='label.pm.user.city'></s:text>:</td>
				<td><input type="text" name="city" value="${symbol_dollar}{city}" id="city" /></td>
			</tr>
			<tr>
				<td><s:text name='label.pm.user.address'></s:text>:</td>
				<td><input type="text" id="address" name="address" value="${symbol_dollar}{address}"/></td>
				<td><s:text name='label.pm.user.organization'></s:text>:</td>
				<td><input id="orgId" name="orgId" value="${symbol_dollar}{organization.orgId}"/></td>
			</tr>
			<tr>
				<td><s:text name='label.pm.user.supervisor'></s:text>:</td>
				<td><input type="text" id="supervisor" name="supervisor" value="${symbol_dollar}{supervisor}"/></td>
				<td><s:text name='label.pm.user.title'></s:text>:</td>
				<td><input type="text" id="title" name="title" value="${symbol_dollar}{title}"/></td>
			</tr>
	</table>  
</fieldset>
<br/>
<fieldset>
	<legend><s:text name='label.pm.user.loginInfo'></s:text></legend>
	<table>
		<tr>
			<td><s:text name='label.pm.user.sso'></s:text>:</td>
			<td><input type="text" name="sso" value="${symbol_dollar}{sso}" id="sso" /></td>
		</tr>
		<tr>
			<td><s:text name='label.pm.user.password'></s:text>:</td>
			<td><input type="password" id="pw" name="pw" value="${symbol_dollar}{pw}"/></td>
		</tr>
		<tr>
			<td><s:text name='label.pm.user.confirm.password'></s:text>:</td>
			<td><input type="password" id="passwordConfirm" name="passwordConfirm" value="${symbol_dollar}{pw}"/>
			</td>
		</tr>
	</table>
</fieldset>
<br/>
<fieldset>
	<legend><s:text name='label.pm.user.contactInfo'></s:text></legend>
	<table>
		<tr>
			<td><s:text name='label.pm.user.cellphone'></s:text>:</td>
			<td><input type="text" id="cellphone" name="cellphone" value="${symbol_dollar}{cellphone}"/></td>
		</tr>
		<tr>
			<td><s:text name='label.pm.user.telephone'></s:text>:</td>
			<td><input type="text" id="telephone" name="telephone" value="${symbol_dollar}{telephone}"/></td>
		</tr>
		<tr>
			<td><s:text name='label.pm.user.fax'></s:text>:</td>
			<td><input type="text" id="fax" name="fax" value="${symbol_dollar}{fax}"/></td>
		</tr>
		<tr>
			<td><s:text name='label.pm.user.email'></s:text>:</td>
			<td><input type="text" id="email" name="email" value="${symbol_dollar}{email}"/></td>
		</tr>
		<tr>
			<td><s:text name='label.pm.user.msn'></s:text>:</td>
			<td><input type="text" id="msn" name="msn" value="${symbol_dollar}{msn}"/></td>
		</tr>
		<tr>
			<td><s:text name='label.pm.user.qq'></s:text>:</td>
			<td><input type="text" id="qq" name="qq" value="${symbol_dollar}{qq}"/></td>
		</tr>
	</table>
</fieldset>
<br/>
<fieldset>
	<legend><s:text name='label.pm.user.otherInfo'></s:text></legend>
	<table>
		<tr>
		<td><s:text name='label.pm.user.remark'></s:text>:</td>
		<td><textarea id="remark" name="remark" rows="5" cols="50">${symbol_dollar}{remark}</textarea></td>
		</tr>
	</table>
</fieldset>
<br/>
</form>
</div>
<div style="background:${symbol_pound}fafafa;text-align: center;">
		<a href="${symbol_pound}${symbol_pound}" onclick="saveUser()" class="easyui-linkbutton" id="btn-save" icon="icon-save"><s:text name='button.common.save'></s:text></a>
		<a href="${symbol_pound}${symbol_pound}" onclick="toBack()" class="easyui-linkbutton" id="btn-cancel" icon="icon-undo"><s:text name='button.common.return'></s:text></a>
</div>
</body>
</html>