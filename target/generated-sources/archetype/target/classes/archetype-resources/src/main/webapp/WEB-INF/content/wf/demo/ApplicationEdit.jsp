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
			//height:430,
			border:false,
			noheader:true,
			top:0,
			left:0
		});
	_editor_form_obj=${symbol_dollar}('${symbol_pound}_editor_form');
	_editor_form_obj.validate({
			rules:{
				applicant:{
						required: true,
						maxlength:20
				},
				applyDate:{
						maxlength:10
				},
				leaveType:{
						required: true,
						maxlength:10
				},
				startDate:{
						maxlength:10
				},
				endDate:{
						maxlength:10
				},
				reason:{
						maxlength:200
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
			url:"${symbol_dollar}{ctx}/wf/application/application!save.action",
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
	window.location='${symbol_dollar}{ctx}/wf/application/application!forQuery.action';
}
//-->
</script>
<body>
<div id="_editor_panel" style="background:${symbol_pound}fafafa;padding:5px;" >
	<form id="_editor_form" method="post">
	<input type="hidden" name="appId" value="${symbol_dollar}{appId}"/>
	<input type="hidden" name="_wf_v_is_dm" value="0"/>
		<table>
				<tr>
					<td>Applicant：</td>
					<td><input type="text" id="applicant" name="applicant" value="${symbol_dollar}{applicant}" size="100"></input></td>
				</tr>
				<tr>
					<td>ApplyDate：</td>
					<td><input type="text" id="applyDate" name="applyDate" value="${symbol_dollar}{applyDate}" size="100"></input></td>
				</tr>
				<tr>
					<td>LeaveType：</td>
					<td><input type="text" id="leaveType" name="leaveType" value="${symbol_dollar}{leaveType}" size="100"></input></td>
				</tr>
				<tr>
					<td>StartDate：</td>
					<td><input type="text" id="startDate" name="startDate" value="${symbol_dollar}{startDate}" size="100"></input></td>
				</tr>
				<tr>
					<td>EndDate：</td>
					<td><input type="text" id="endDate" name="endDate" value="${symbol_dollar}{endDate}" size="100"></input></td>
				</tr>
				<tr>
					<td>Reason：</td>
					<td><input type="text" id="reason" name="reason" value="${symbol_dollar}{reason}" size="100"></input></td>
				</tr>
				<tr>
					<td>Remark：</td>
					<td><input type="text" id="remark" name="remark" value="${symbol_dollar}{remark}" size="100"></input></td>
				</tr>
		</table>
		<br />
		<div style="text-align: center;">
			<a href="${symbol_pound}${symbol_pound}" onclick="save()" class="easyui-linkbutton" id="btn-save" icon="icon-save">Submit</a>
			<a href="${symbol_pound}${symbol_pound}" onclick="goBack()" class="easyui-linkbutton" id="btn-undo" icon="icon-cancel"><s:text name='button.common.return'></s:text></a>
		</div>
	</form>
</div>
</body>
</html>