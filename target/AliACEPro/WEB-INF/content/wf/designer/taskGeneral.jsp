<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<script type="text/javascript">
<!--
jq(function(){
		loadTaskGeneral();
	});
function saveTaskGeneral(){
	task.taskId=jq('#id').val();
	task.taskName=jq('#name').val();
	task.setContent(jq('#name').val());
	if(jq('#asynchronous').attr('checked')){
		task.asynchronous=true;
	}else{
		task.asynchronous=false;
	}
	if(!jq('#exclusive').attr('checked')){
		task.exclusive=false;
	}else{
		task.exclusive=true;
	}
}
function loadTaskGeneral(){
	jq('#id').val(task.taskId);
	jq('#name').val(task.taskName);
	if(task.asynchronous){
		jq('#asynchronous').attr('checked',true);
	}else{
		jq('#asynchronous').attr('checked',false);
	}
	if(!task.exclusive){
		jq('#exclusive').attr('checked',false);
	}else{
		jq('#exclusive').attr('checked',true);
	}
}
//-->
</script>
<table id="general-properties">
					<tr>
						<td align="right">Id:</td>
						<td><input type="text" id="id" name="id" size="50" value=""/></td>
					</tr>
					<tr>
						<td align="right">Name:</td>
						<td><input type="text" id="name" name="name" size="50" value=""/></td>
					</tr>
					<tr>
						<td align="right">Asynchronous:</td>
						<td><input type="checkbox" id="asynchronous" name="asynchronous" value="true"/></td>
					</tr>
					<tr>
						<td align="right">Exclusive:</td>
						<td><input type="checkbox" id="exclusive" name="exclusive" value="true" checked/></td>
					</tr>
</table>