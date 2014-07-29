#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>

<script type="text/javascript">
<!--
${symbol_dollar}(function(){
	//_selected_func_panel_obj=${symbol_dollar}('${symbol_pound}_selected_module_panel').panel({
		//fit:true
	//});
	_selected_funcs_grid=${symbol_dollar}('${symbol_pound}selectedModuleTable').datagrid({
		title:"<s:text name='label.pm.user.functionality.list'></s:text>",
		url:'${symbol_dollar}{ctx}/pm/user/user!searchSelectedFunc.action?userId=${symbol_dollar}{userId}',
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
			filter_EQI_id:'${symbol_dollar}{groupId}'
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
	_selected_func_form_obj=${symbol_dollar}('${symbol_pound}selectedModuleForm');
});
function deleteUser(){
	var rows = _selected_funcs_grid.datagrid("getSelections");
	if(rows.length==0){
		${symbol_dollar}.messager.alert('Error',"<s:text name='message.common.must.selectRow'></s:text>",'error');
		return;
	}else{
		${symbol_dollar}.messager.confirm("Confirm","<s:text name='message.common.delete.confirm'></s:text>",function(flag){
			//alert(flag);
			if(flag){
				var ids = null;
				for(var i=0;i<rows.length;i++){
					ids=ids+rows[i].moduleId+",";
				}
				document.getElementById("selectedModuleIds").value=ids;
				_selected_func_form_obj.form('submit',{
						url:'${symbol_dollar}{ctx}/pm/user/user!unassignModules.action',
						success:function(data){
							eval('data='+data);
							if(data.success){
								${symbol_dollar}.messager.alert('Success',data.message,'info');
								_selected_funcs_grid.datagrid("clearSelections");
								_selected_funcs_grid.datagrid('reload',{});
							}else{
								${symbol_dollar}.messager.alert('Error',data.message,'error');
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
    <input type="hidden" name="userId" value="${symbol_dollar}{userId}"/>
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
