<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title></title>
	<%@ include file="/common/header.jsp" %>
	<script type="text/javascript" src="${ctx}/js/ckeditor/ckeditor.js"></script>
	<script>
	CKEDITOR.config.jqueryOverrideVal = true;
	//CKEDITOR.config.htmlEncodeOutput = true;
	</script>
	<script type="text/javascript" src="${ctx}/js/ckeditor/adapters/jquery.js"></script>
<!--	<script src="${ctx}/js/htmlformatter/globals.js" type="text/javascript"></script>-->
<!--	<script src="${ctx}/js/htmlformatter/base.js" type="text/javascript"></script>-->
<!--	<script src="${ctx}/js/htmlformatter/jsformat.js" type="text/javascript"></script>-->
<!--	<script src="${ctx}/js/htmlformatter/htmlformat.js" type="text/javascript"></script>-->
</head>
<%
	String lang = "";
	if(locale != null){
		if(locale.getLanguage().equals(new Locale("zh", "", "").getLanguage())){
			lang = "zh-cn";
		}else{
			lang = "en";
		}
	}
%>
<script type="text/javascript">
<!--
$(function(){
	//packer = new Packer;
	_editor_panel_obj=$('#_editor_panel').panel({
			//height:430,
			//fit:true,
			border:false,
			noheader:true,
			top:0,
			left:0
		});
	_editor_form_obj=$('#_editor_form');
	_editor_form_obj.validate({
			rules:{
					process:{
							required: true,
							maxlength:100
						
					},
					tempKey:{
							required: true,
							remote:"${ctx}/wf/emailtemp/emailtemp!checkTempKey.action?oldTempKey=" + encodeURIComponent('${tempKey}'),
							maxlength:200
					},
					tempName:{
							required: true,
							maxlength:100
						
					},
					remark:{
							maxlength:200
						
					}
			},
			messages:{
				process:{
					remote:"<s:text name='message.wf.email.template.existing'></s:text>"
				}
			},
			showErrors:showErrors
		});
		$('#templateContent').ckeditor(
				{
					skin : 'office2003',
					height:500,
					width:'100%',
					language:"<%=lang%>",
					fullPage:true,
					startupFocus:true,
					//basicEntities : false,
					//startupShowBorders:true,
					//htmlEncodeOutput: true,
					autoUpdateElement :true,
					toolbar:[
					         { name: 'document',    items : [ 'Source','-','Preview' ] },
					         { name: 'clipboard',   items : [ 'Cut','Copy','Paste','PasteText','-','Undo','Redo' ] },
					         { name: 'editing',     items : [ 'Find','Replace','-','SelectAll' ] },
					         { name: 'forms',       items : [ 'Form', 'Checkbox', 'Radio', 'TextField', 'Textarea', 'Select', 'Button', 'ImageButton', 'HiddenField' ] },
					         '/',
					         { name: 'basicstyles', items : [ 'Bold','Italic','Underline','Strike','-','RemoveFormat' ] },
					         { name: 'paragraph',   items : [ 'NumberedList','BulletedList','-','Outdent','Indent','-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock','-','BidiLtr','BidiRtl' ] },
					         { name: 'links',       items : [ 'Link','Unlink'] },
					         { name: 'insert',      items : [ 'Table','HorizontalRule'] },
					         '/',
					         { name: 'styles',      items : [ 'Styles','Format','Font','FontSize' ] },
					         { name: 'colors',      items : [ 'TextColor','BGColor' ] }
					     ]
				}
			);
});
function save(){
	//var content = $('#editor').val();
	//content = packer.pack(content, 0, 0);
	//content = CKEDITOR.tools.htmlEncode(content);
	_editor_form_obj.ajaxSubmit({
			url:"${ctx}/wf/emailtemp/emailtemp!save.action",
			type: 'POST',
			/*
			data:{
					templateContent:content
				},
			*/
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
	window.location='${ctx}/wf/emailtemp/emailtemp!forQuery.action';
}
//-->
</script>
<body>
<div id="_editor_panel" style="background:#fafafa;padding:5px;" >
	<form id="_editor_form" method="post">
	<input type="hidden" name="tid" id="tid" value="${tid}"/>
		<table width="95%">
				<tr>
					<td><s:text name='lable.wf.email.template.process'></s:text>：</td>
					<td><input type="text" id="process" name="process" value="${process}" size="100"></input></td>
				</tr>
				<tr>
					<td><s:text name='lable.wf.email.template.key'></s:text>：</td>
					<td><input type="text" id="tempKey" name="tempKey" value="${tempKey}" size="100"></input></td>
				</tr>
				<tr>
					<td><s:text name='lable.wf.email.template.name'></s:text>：</td>
					<td><input type="text" id="tempName" name="tempName" value="${tempName}" size="100"></input></td>
				</tr>
				<tr>
					<td><s:text name='lable.wf.email.template.remark'></s:text>：</td>
					<td><textarea id="remark" name="remark" rows="3" cols="80">${remark}</textarea></td>
				</tr>
				<tr>
					<td colspan="2"><textarea id="templateContent" name="templateContent">${templateContent}</textarea></td>
				</tr>
		</table>
		<br />
		<div style="text-align: center;">
			<a href="###" onclick="save()" class="easyui-linkbutton" id="btn-save" icon="icon-save"><s:text name='button.common.save'></s:text></a>
			<a href="###" onclick="goBack()" class="easyui-linkbutton" id="btn-undo" icon="icon-cancel"><s:text name='button.common.return'></s:text></a>
		</div>
<!--		<div id="htmlContainer" style="display: none;"></div>-->
	</form>
</div>
</body>
</html>