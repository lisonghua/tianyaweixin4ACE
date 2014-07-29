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
	_pw_editor_obj = ${symbol_dollar}('${symbol_pound}_pw_editor').panel({
		height:200
	});
	_pw_form_obj = ${symbol_dollar}('${symbol_pound}_pw_Form');
	_pw_form_obj.validate({
		rules: {
			opw:{
				required: true,
				remote: "${symbol_dollar}{ctx}/pm/user/user!checkOldPassword.action?userId="+encodeURIComponent(document.getElementById('userId').value)+"&oldPassword=" + encodeURIComponent(document.getElementById('opw').value),
				maxlength:10
			},
			npw: {
				required: true,
				minlength:3,
				maxlength:10
			},
			passwordConfirm: {
				equalTo:"${symbol_pound}npw"
			}
		},
		messages:{
			opw:{
				remote:"<s:text name='message.pm.user.old.password.fault'></s:text>"
			}
		}
	});
});
function updatePw(){
	_pw_form_obj.form('submit',{
		url:'${symbol_dollar}{ctx}/pm/user/user!updatePassword.action',
		success:function(data){
			eval('data='+data);
			if(data.success){
				_pw_form_obj.form('clear');
				${symbol_dollar}.messager.alert('Info',data.message,'info');
			}else{
				${symbol_dollar}.messager.alert('Error',data.message,'error');
			}
		},
		onSubmit:function(){
			if(_pw_form_obj.valid())
				return true;
			else
				return false;
		}
	});
}
//-->
function closePwForm(){
	_pw_form_obj.form('clear');
}
function closeWindow(){
	parent.closePwWindow();
}
</script>
<body>
<div id="_pw_editor" style="background:${symbol_pound}fafafa;padding:5px;">
	<form id="_pw_Form">
		<input type="hidden" name="userId" value="${symbol_dollar}{userId}"/>
		<table>
			<tr>
				<td><s:text name='label.pm.user.old.password'></s:text>:</td>
				<td><input type="password" id="opw" name="opw" value=""/></td>
			</tr>
			<tr>
				<td><s:text name='label.pm.user.new.password'></s:text>:</td>
				<td><input type="password" id="npw" name="npw" value=""/></td>
			</tr>
			<tr>
				<td><s:text name='label.pm.user.confirm.password'></s:text>:</td>
				<td><input type="password" id="passwordConfirm" name="passwordConfirm" value=""/>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<a href="javascript:void(0)" onclick="updatePw()" class="easyui-linkbutton" id="btn-save" icon="icon-save"><s:text name='button.common.save'></s:text></a>
					<a href="javascript:void(0)" onclick="closeWindow()" class="easyui-linkbutton" id="btn-cancel" icon="icon-cancel"><s:text name='button.common.close'></s:text></a>
				</td>
			</tr>
		</table>
	</form>
</div>
</body>
</html>
