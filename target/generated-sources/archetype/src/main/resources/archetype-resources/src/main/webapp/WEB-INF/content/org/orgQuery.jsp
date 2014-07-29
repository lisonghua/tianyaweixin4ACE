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
${symbol_dollar}(function() {
	_org_panel_obj=${symbol_dollar}('${symbol_pound}_org_panel').panel({
			//height:600,
			border:false,
			noheader:true,
			top:0,
			left:0
	});
	_org_table_obj = ${symbol_dollar}('${symbol_pound}_org_table').treegrid(
					{
						title:"<s:text name='label.pm.org.list'></s:text>",
						//width:980,
						height:500,
						iconCls:'icon-save',
						url : '${symbol_dollar}{ctx}/pm/org/organization!getNodes.action',
						animate : true,
						nowrap : false,
						rownumbers : true,
						collapsible : true,
						idField : 'id',
						treeField : 'id',
						frozenColumns:[[
						                {field:'id',width:100,align:'center'},
						                {field:'text',title:"<s:text name='label.pm.org.name'></s:text>",width:100,align:'center'}
						]],
						columns:[[
						          
						          {field:'orgCode',title:"<s:text name='label.pm.org.code'></s:text>",width:100,align:'center'},
						          {field:'orgStatus',title:"<s:text name='label.pm.org.status'></s:text>",width:50,align:'center'},
						          {field:'action',title:"<s:text name='label.pm.org.action'></s:text>",width:200,align:'center',
						        	  formatter:function (value,rowData,rowIndex){
						        	  		var id = rowData.id;
						        	  		var c = '<img onclick="createrow('+id+')" src="${symbol_dollar}{ctx}/image/edit_add.png" title="'+"<s:text name='label.pm.org.add.subOrg'></s:text>"+'" style="cursor:hand;"/>';   
											var e = '<img onclick="editrow('+id+')" src="${symbol_dollar}{ctx}/image/edit.gif" title="'+"<s:text name='button.common.modify'></s:text>"+'" style="cursor:hand;"/>';   
								    	    var d = '<img onclick="deleterow('+id+')" src="${symbol_dollar}{ctx}/image/delete.gif" title="'+"<s:text name='button.common.delete'></s:text>"+'" style="cursor:hand;"/>';
								    	    var a = '<img onclick="addUser('+id+')" src="${symbol_dollar}{ctx}/image/assign.gif" title="'+"<s:text name='label.pm.org.add.user'></s:text>"+'" style="cursor:hand;"/>';
											if(id!=0){
									    	    return c+'&nbsp;'+e+'&nbsp;'+a+'&nbsp;'+d;
											}else{
												return c+'&nbsp;'+e;
											}
						        	 }
							       }
						]]
					});
});
function  createrow(id){
	window.location='${symbol_dollar}{ctx}/pm/org/organization!forInsert.action?parentId='+id;
}
function  editrow(id){
	window.location='${symbol_dollar}{ctx}/pm/org/organization!forUpdate.action?organizationId='+id;
}
function  deleterow(id){
	${symbol_dollar}.messager.confirm("Confirm","<s:text name='message.common.delete.confirm'></s:text>",function(flag){
		if(flag){
			${symbol_dollar}.ajax({
					url:'${symbol_dollar}{ctx}/pm/org/organization!delete.action?organizationId='+id,
					type: 'GET',
					dataType:'json',
					error:function(){
						${symbol_dollar}.messager.alert('Error',"<s:text name='message.common.delete.failure'></s:text>",'error');
					},
					success:function(data){
						if(data.success){
							_org_table_obj.datagrid('reload',{});
							${symbol_dollar}.messager.alert('Success',data.message,'info');
						}else{
							${symbol_dollar}.messager.alert('Error',data.message,'error');
						}
					}
				}
			);
		}
	});
}
function addUser(id){
	
}
//-->
</script>
<body>
<div id="_org_panel" style="padding:5px;">
<table id="_org_table">
</table>
</div>
</body>
</html>