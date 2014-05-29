<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>

<script type="text/javascript">
<!--
$(function(){
	//_selected_func_panel_obj=$('#_selected_module_panel').panel({
		//fit:true
		//border:false,
		//noheader:true,
		//top:0,
		//left:0
	//});
	_selected_funcs_grid=$('#selectedModuleTable').datagrid({
		title:"<s:text name='label.pm.common.functionality.list'></s:text>",
		url:'${ctx}/pm/role/role!searchSelectedFunc.action?roleId=${roleId}',
		//singleSelect:true,
		//width:900,
		height:380,
		idField:'moduleId',
		//pagination:true,
		//pageSize:15,
		//pageNumber:1,
		//pageList:[10,15],
		rownumbers:true,
		//sortName:'userId',
	    //sortOrder:'asc',
	    striped:true,
	    /*
	    queryParams:{
			filter_EQI_id:'${groupId}'
	    },
	    */
	    toolbar:[{
	        text:"<s:text name='button.pm.common.privilege.cancel'></s:text>",
	        iconCls:'icon-cancel',
	        handler:function(){
	        	deleteModules();
	        }
	    },'-',{
	    	text:"<s:text name='button.common.return'></s:text>",
	        iconCls:'icon-undo',
	        handler:toBack
		}]
	});
	_selected_func_form_obj=$('#selectedModuleForm');
	_field_win_obj = $('#_field_win').window({   
	    closed:true,
	    draggable:false,
	    collapsible:false,
	    minimizable:false,
	    maximizable:false,
	    modal:true,
	    shadow:true,
	    onClose:clearForm
	});
	_field_frame_obj = document.getElementById("_field_frame");
});
function deleteModules(){
	var rows = _selected_funcs_grid.datagrid("getSelections");
	if(rows.length==0){
		$.messager.alert('Error',"<s:text name='message.common.must.selectRow'></s:text>",'error');
		return;
	}else{
		$.messager.confirm("Confirm","<s:text name='message.common.delete.confirm'></s:text>",function(flag){
			//alert(flag);
			if(flag){
				var ids = null;
				for(var i=0;i<rows.length;i++){
					ids=ids+rows[i].moduleId+",";
				}
				document.getElementById("selectedModuleIds").value=ids;
				_selected_func_form_obj.form('submit',{
						url:'${ctx}/pm/role/role!unassignModules.action',
						success:function(data){
							eval('data='+data);
							if(data.success){
								$.messager.alert('Success',data.message,'info');
								_selected_funcs_grid.datagrid("clearSelections");
								_selected_funcs_grid.datagrid('reload',{});
							}else{
								$.messager.alert('Error',data.message,'error');
							}
						}
					}
				);
			}
		});
	}
};
function displayActionBt (value,rowData,rowIndex){
	var moduleId = rowData.moduleId;
    var a = '<img onclick="assignFields('+moduleId+')" src="${ctx}/image/permissions.gif" title="'+"<s:text name='button.pm.role.assign.field'></s:text>"+'" style="cursor:hand;"/>';
    return a;
}
function assignFields(mid){
	_field_win_obj.window('open');
	//alert('${ctx}/pm/role/role!forAssignField.action?moduleId='+mid+'&roleId=${roleId}');
	_field_frame_obj.src='${ctx}/pm/role/role!forAssignField.action?moduleId='+mid+'&roleId=${roleId}';
}
function clearForm(){
	_field_frame_obj.src="about:blank";
}
function closeWin(){
	_field_win_obj.window('close');
}
//-->
</script>
<!--<div id="_selected_module_panel" style="padding:5px;">-->
<form id="selectedModuleForm">
    <input type="hidden" name="roleId" value="${roleId}"/>
    <input type="hidden" name="selectedModuleIds" id="selectedModuleIds" value=""/>
       <table id="selectedModuleTable">
			<thead>
				<tr>
					<th field="moduleId" align="middle" checkbox="true"></th>
					<th field="name" width="500" align="middle"><s:text name='label.pm.role.name'></s:text></th>
					<th field="privilege" width="200" align="middle"><s:text name='button.pm.role.assign.privilege'></s:text></th>
					<th field="action" align="middle" width="100" formatter="displayActionBt"><s:text name='label.common.action'></s:text></th>
				</tr>
			</thead>
		</table>
</form>
<!--</div>-->
<div id="_field_win" title="<s:text name='label.pm.module.field.list'></s:text>" style="width:650px;height:400px;">  
    <iframe id="_field_frame" name="_field_frame" frameborder="0" width="100%" height="100%" marginheight="0" marginwidth="0" scrolling="no"></iframe>
</div>