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
			//height:430,
			border:false,
			noheader:true,
			top:0,
			left:0
		});
	_editor_form_obj=$('#_editor_form');
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
			url:"${ctx}/wf/application/application!save.action",
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
	window.location='${ctx}/wf/application/application!forQuery.action';
}
//-->
</script>
<body>
<div id="_editor_panel" style="background:#fafafa;padding:5px;" >
	<form id="_editor_form" method="post">
	<input type="hidden" name="appId" value="${appId}"/>
	<input type="hidden" name="_wf_v_is_dm" value="0"/>
		<table>
				<tr>
					<td>Applicant：</td>
					<td><input type="text" id="applicant" name="applicant" value="${applicant}" size="100"></input></td>
				</tr>
				<tr>
					<td>ApplyDate：</td>
					<td><input type="text" id="applyDate" name="applyDate" value="${applyDate}" size="100"></input></td>
				</tr>
				<tr>
					<td>LeaveType：</td>
					<td><input type="text" id="leaveType" name="leaveType" value="${leaveType}" size="100"></input></td>
				</tr>
				<tr>
					<td>StartDate：</td>
					<td><input type="text" id="startDate" name="startDate" value="${startDate}" size="100"></input></td>
				</tr>
				<tr>
					<td>EndDate：</td>
					<td><input type="text" id="endDate" name="endDate" value="${endDate}" size="100"></input></td>
				</tr>
				<tr>
					<td>Reason：</td>
					<td><input type="text" id="reason" name="reason" value="${reason}" size="100"></input></td>
				</tr>
				<tr>
					<td>Remark：</td>
					<td><input type="text" id="remark" name="remark" value="${remark}" size="100"></input></td>
				</tr>
		</table>
		<br />
		<div style="text-align: center;">
			<a href="##" onclick="save()" class="easyui-linkbutton" id="btn-save" icon="icon-save">Submit</a>
			<a href="##" onclick="goBack()" class="easyui-linkbutton" id="btn-undo" icon="icon-cancel"><s:text name='button.common.return'></s:text></a>
		</div>
	</form>
</div>
</body>
</html>