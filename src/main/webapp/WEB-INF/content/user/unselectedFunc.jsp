<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<script type="text/javascript">
<!--
$(function(){
	//_unselected_module_panel_obj=$('#_unselected_module_panel').panel({
		//fit:true
	//});
	_unselected_modules_grid=$('#unselectedModuleTable').datagrid({
		title:"<s:text name='label.pm.user.functionality.list'></s:text>",
		url:'${ctx}/pm/user/user!searchUnselectedFunc.action?userId=${userId}',
		//singleSelect:true,
		//width:900,
		height:380,
		//pagination:true,
		//pageSize:15,
		//pageNumber:1,
		//pageList:[10,15],
		rownumbers:true,
		//nowrap : false,
		//collapsible : true,
		//sortName:'userId',
	    //sortOrder:'asc',
	    striped:true,
	    idField : 'moduleId',
		//treeField : 'id',
	    onLoadSuccess:function(data){
		   	var rows = data.rows;
		    for(var i=0;i<rows.length;i++){
			    if(rows[i].isAssigned){
					$(this).datagrid('selectRow',i);
				}
			}
		},
		onSelect:function(rowIndex, rowData){
		},
	    toolbar:[{
	        text:"<s:text name='button.pm.user.privilege.update'></s:text>",
	        iconCls:'icon-add',
	        handler:function(){
	    		addModules();
	        }
	    },'-',{
	    	text:"<s:text name='button.common.return'></s:text>",
	        iconCls:'icon-undo',
	        handler:toBack
		}]
	});
	_unselected_module_form_obj=$('#unselectedModuleForm');
});
function addModules(){
	var rows = _unselected_modules_grid.datagrid("getSelections");
	if(rows.length==0){
		$.messager.alert('Error',"<s:text name='message.common.must.selectRow'></s:text>",'error');
		return;
	}
	var ids = null;
	for(var i=0;i<rows.length;i++){
		ids=ids+rows[i].moduleId+",";
	}
	//alert(ids);
	document.getElementById("unselectedModuleIds").value=ids;
	_unselected_module_form_obj.form('submit',{
		url:'${ctx}/pm/user/user!assignModules.action',
		success:function(data){
			eval('data='+data);
			if(data.success){
				$.messager.alert('Info',data.message,'info');
				_unselected_modules_grid.datagrid("reload",{});
			}else{
				$.messager.alert('Error',data.message,'error');
			}
		},
		onSubmit:function(){
			//if(_group_form_obj.valid())
				return true;
			//else
				//return false;
		}
	});
}
function checkboxFormatter (value,rowData,rowIndex){
	var moduleId=rowData.moduleId;
	var c='<input type="checkbox" id="moduleId" name="moduleId" value="'+moduleId+'"/>';
	return c;
}
function selectModule(obj){
	//alert(obj.checked);
	/*
	if(obj.checked)
		obj.checked=false;
	else
		obj.checked=true;
	*/
}
function dosearchByUser(){
	var name=document.getElementById("_group_search_unslt_userName").value;
	var sso=document.getElementById("_group_search_unslt_sso").value;
	//var group=_search_group.combobox('getValue');
	//alert(group);
	var email=document.getElementById("_group_search_unslt_email").value;
	_unselected_users_grid.datagrid('reload',{
			filter_LIKES_name:name,
			filter_EQS_sso:sso,
			//group_EQI_groupId:group,
			filter_LIKES_email:email
		});
}
//-->
</script>
<!--<div id="_unselected_module_panel" style="padding:5px;">-->
<form id="unselectedModuleForm" method="post">
    <input type="hidden" name="userId" value="${userId}"/>
    <input type="hidden" name="unselectedModuleIds" id="unselectedModuleIds" value=""/>
       <table id="unselectedModuleTable">
			<thead>
				<tr>
					<th field="moduleId" checkbox="true" align="middle"></th>
					<th field="name" width="500" align="middle"><s:text name='label.pm.module.name'></s:text></th>
					<th field="privilege" width="200" align="middle"><s:text name='label.pm.module.privilege'></s:text></th>
				</tr>
			</thead>
		</table>
</form>
<!--</div>-->
