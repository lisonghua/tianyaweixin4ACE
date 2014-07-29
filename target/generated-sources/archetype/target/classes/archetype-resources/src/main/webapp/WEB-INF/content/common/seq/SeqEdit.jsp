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
				seqName:{
						required: true,
						remote:"${symbol_dollar}{ctx}/common/seq/seq!isExistingSeq.action?oldName=${symbol_dollar}{name}",
						maxlength:255
				},
				seqMin:{
						required: true,
						maxlength:255
				},
				seqLength:{
						required: true,
						maxlength:255
				},
				next:{
						required: true,
						maxlength:255
				},
				rules:{
						maxlength:255
				}
			},
			messages:{
				seqName:{
					remote:"<s:text name='message.pm.seq.name.isExisting'></s:text>"
				}
			},
			showErrors:showErrors
		});
});
function save(){
	_editor_form_obj.ajaxSubmit({
			url:"${symbol_dollar}{ctx}/common/seq/seq!save.action",
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
	window.location='${symbol_dollar}{ctx}/common/seq/seq!forQuery.action';
}
//-->
</script>
<body>
<div id="_editor_panel" style="background:${symbol_pound}fafafa;padding:5px;" >
	<form id="_editor_form" method="post">
	<input type="hidden" name="seqId" value="${symbol_dollar}{seqId}"/>
		<table>
				<tr>
					<td><s:text name='label.pm.seq.name'></s:text>：</td>
					<td><input type="text" id="seqName" name="seqName" value="${symbol_dollar}{seqName}" size="80"></input></td>
				</tr>
				<tr>
					<td><s:text name='label.pm.seq.min'></s:text>：</td>
					<td><input type="text" id="seqMin" name="seqMin" value="${symbol_dollar}{seqMin}" size="80"></input></td>
				</tr>
				<tr>
					<td><s:text name='label.pm.seq.length'></s:text>：</td>
					<td><input type="text" id="seqLength" name="seqLength" value="${symbol_dollar}{seqLength}" size="80"></input></td>
				</tr>
				<tr>
					<td><s:text name='label.pm.seq.next'></s:text>：</td>
					<td><input type="text" id="next" name="next" value="${symbol_dollar}{next}" size="80"></input></td>
				</tr>
				<tr>
					<td><s:text name='label.pm.seq.rules'></s:text>：</td>
					<td><input type="text" id="rules" name="rules" value="${symbol_dollar}{rules}" size="80"></input></td>
				</tr>
		</table>
		<br />
		<div style="text-align: center;">
			<a href="${symbol_pound}" onclick="save()" class="easyui-linkbutton" id="btn-save" icon="icon-save"><s:text name='button.common.save'></s:text></a>
			<a href="${symbol_pound}" onclick="goBack()" class="easyui-linkbutton" id="btn-undo" icon="icon-cancel"><s:text name='button.common.return'></s:text></a>
		</div>
	</form>
</div>
</body>
</html>