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
	<script type="text/javascript" src="${symbol_dollar}{ctx}/js/ckeditor/ckeditor.js"></script>
	<script type="text/javascript" src="${symbol_dollar}{ctx}/js/ckeditor/adapters/jquery.js"></script>
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
${symbol_dollar}(function(){
	${symbol_dollar}('${symbol_pound}editor' ).ckeditor(
			{
				skin : 'office2003',
				height:500,
				language:"<%=lang%>",
				//fullPage:true,
				toolbar:[
				         { name: 'document',    items : [ 'Source','-','Save','NewPage','Preview','-','Templates' ] },
				         { name: 'clipboard',   items : [ 'Cut','Copy','Paste','PasteText','-','Undo','Redo' ] },
				         { name: 'editing',     items : [ 'Find','Replace','-','SelectAll' ] },
				         { name: 'forms',       items : [ 'Form', 'Checkbox', 'Radio', 'TextField', 'Textarea', 'Select', 'Button', 'ImageButton', 'HiddenField' ] },
				         '/',
				         { name: 'basicstyles', items : [ 'Bold','Italic','Underline','Strike','-','RemoveFormat' ] },
				         { name: 'paragraph',   items : [ 'NumberedList','BulletedList','-','Outdent','Indent','-','Blockquote','CreateDiv','-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock','-','BidiLtr','BidiRtl' ] },
				         { name: 'links',       items : [ 'Link','Unlink','Anchor' ] },
				         { name: 'insert',      items : [ 'Table','HorizontalRule'] },
				         '/',
				         { name: 'styles',      items : [ 'Styles','Format','Font','FontSize' ] },
				         { name: 'colors',      items : [ 'TextColor','BGColor' ] }
				     ]
			}
		);
});


//-->
</script>
<body>
<div id="editor"></div>
</body>
</html>
