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
var fieldTypeDics=<%=request.getAttribute("_field_type_items")%>;
${symbol_dollar}(function(){
	_field_panle_obj=${symbol_dollar}('${symbol_pound}_field_panel').panel({
		height:370
	});
	_field_grid_obj=${symbol_dollar}('${symbol_pound}_field_table').datagrid({
			url : '${symbol_dollar}{ctx}/pm/role/role!searchFieldsOfModule.action?roleId=<%=request.getParameter("roleId")%>&moduleId=<%=request.getParameter("moduleId")%>',
			title:"<s:text name='label.pm.field.list'></s:text>",
			iconCls:'icon-edit',
			rownumbers : true,
			width:'623',
			height:'300',
			//singleSelect:true,
			idField:'fieldId',
			onLoadSuccess:function(data){
			   	var rows = data.rows;
			    for(var i=0;i<rows.length;i++){
				    if(rows[i].isAssigned){
						${symbol_dollar}(this).datagrid('selectRow',i);
					}
				}
			},
			toolbar:[{
					text:"<s:text name='button.pm.common.privilege.update'></s:text>",
					iconCls:'icon-add',
					handler:function(){
						savePrivilege();
					}
				}
			]
		});
});
function closeWin(){
	parent.closeWin();
}
function fieldTypeFormatter(value,rowData,rowIndex){
	for(var i=0; i<fieldTypeDics.length; i++){
		if (fieldTypeDics[i].code == value){ 
			return fieldTypeDics[i].value;
		}
	}
	return value;
}
function savePrivilege(){
	var rows = _field_grid_obj.datagrid("getSelections");
	var ids = "";
	for(var i=0;i<rows.length;i++){
		ids=ids+rows[i].fieldId+",";
	}
	${symbol_dollar}.ajax({
			url:"${symbol_dollar}{ctx}/pm/role/role!savePrivilegeOfField.action",
		type: 'POST',
		data:{
					roleId:"${symbol_dollar}{roleId}",
					moduleId:"<%=request.getParameter("moduleId")%>",
					_request_field_ids:ids
		},
		dataType:'json',
		error:function(){
			${symbol_dollar}.messager.alert("<s:text name='label.common.error'></s:text>","<s:text name='message.common.save.failure'></s:text>","error");
			return "";
		},
		success:function(data){
			if(data.success){
				// 保存成功后，可以刷新页面，也可以：   
                ${symbol_dollar}('${symbol_pound}_field_table').datagrid('reload',{});
                ${symbol_dollar}.messager.alert("<s:text name='label.common.success'></s:text>",data.message,"info");
        	}else{
        		${symbol_dollar}.messager.alert("<s:text name='label.common.error'></s:text>",data.message,"error");
            }
		}	
	});
}
//-->
</script>
<body>
<input type="hidden" id="moduleId" name="moduleId" value="${symbol_dollar}{moduleId}"/>
<div id="_field_panel" style="padding:5px;">
<table id="_field_table">
	<thead>
			<tr>
				<th field="fieldId" checkbox="true" align="middle"></th>
				<th field="domId" width="80" align="center"><s:text name='label.pm.field.domId'></s:text></th>
				<th field="name" width="80" align="center"><s:text name='label.pm.field.name'></s:text></th>
				<th field="fieldType" width="100" align="center" formatter="fieldTypeFormatter"><s:text name='label.pm.field.type'></s:text></th>
				<th field="remark" width="100" align="center" editor="text"><s:text name='label.pm.field.remark'></s:text></th>
				<th field="privilege" width="100" align="center" editor="text"><s:text name='button.pm.role.assign.privilege'></s:text></th>
			</tr>
	</thead>
</table>
<br />
<div style="text-align: center;">
	<a href="javascript:void(0)" onclick="closeWin()" class="easyui-linkbutton" id="btn-cancel" icon="icon-cancel"><s:text name='button.common.close'></s:text></a>
</div>
</div>
</body>
</html>