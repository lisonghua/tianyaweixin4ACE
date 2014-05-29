<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>

<script type="text/javascript">
<!--
$(function(){
	//_selected_func_panel_obj=$('#_selected_module_panel').panel({
		//fit:true
	//});
	_selected_funcs_grid=$('#selectedModuleTable').datagrid({
		title:"<s:text name='label.pm.user.functionality.list'></s:text>",
		url:'${ctx}/pm/user/user!searchSelectedFunc.action?userId=${userId}',
		//singleSelect:true,
		//width:900,
		height:380,
		//fit:true,
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
	        text:"<s:text name='button.pm.user.privilege.cancel'></s:text>",
	        iconCls:'icon-cancel',
	        handler:function(){
	    		deleteUser();
	        }
	    },'-',{
	    	text:"<s:text name='button.common.return'></s:text>",
	        iconCls:'icon-undo',
	        handler:toBack
		}]
	});
	_selected_func_form_obj=$('#selectedModuleForm');
});
function deleteUser(){
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
						url:'${ctx}/pm/user/user!unassignModules.action',
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

//-->
</script>
<!--<div id="_selected_module_panel" style="padding:5px;">-->
<form id="selectedModuleForm">
    <input type="hidden" name="userId" value="${userId}"/>
    <input type="hidden" name="selectedModuleIds" id="selectedModuleIds" value=""/>
       <table id="selectedModuleTable">
			<thead>
				<tr>
					<th field="moduleId" align="middle" checkbox="true"></th>
					<th field="name" width="500" align="middle"><s:text name='label.pm.module.name'></s:text></th>
					<th field="privilege" width="200" align="middle"><s:text name='label.pm.module.privilege'></s:text></th>
				</tr>
			</thead>
		</table>
</form>
<!--</div>-->
