<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<script type="text/javascript">
<!--
$(function(){
	//_role_unselected_user_panel_obj=$('#_role_unselected_user_panel').panel({
		//border:false,
		//noheader:true,
		//top:0,
		//left:0
		//fit:true
	//});
	_role_unselected_users_grid=$('#roleUnselectedUserTable').datagrid({
		title:"<s:text name='label.pm.role.list'></s:text>",
		url:'${ctx}/pm/user/user!searchUnselectedRoles.action?userId=${userId}',
		//singleSelect:true,
		//width:900,
		height:390,
		idField:'roleId',
		pagination:true,
		pageSize:15,
		pageNumber:1,
		pageList:[10,15],
		rownumbers:true,
		sortName:'roleId',
	    sortOrder:'asc',
	    striped:true,
	    onLoadSuccess:function(data){
		   	var rows = data.rows;
		    for(var i=0;i<rows.length;i++){
			    if(rows[i].isAssigned){
					$(this).datagrid('selectRow',i);
				}
			}
		},
	    toolbar:[{
	        text:"<s:text name='button.pm.common.privilege.update'></s:text>",
	        iconCls:'icon-add',
	        handler:function(){
	    		addUsers();
	        }
	    },{
	    	text:"<s:text name='button.common.return'></s:text>",
	        iconCls:'icon-undo',
	        handler:toBack
		}]
	});
	_role_unselected_user_form_obj=$('#roleUnselectedUserForm');
});
function addUsers(){
	var rows = _role_unselected_users_grid.datagrid("getSelections");
	if(rows.length==0){
		$.messager.alert('Error',"<s:text name='message.common.must.selectRow'></s:text>",'error');
		return
	}
	var ids = null;
	for(var i=0;i<rows.length;i++){
		ids=ids+rows[i].roleId+",";
	}
	//alert(ids);
	document.getElementById("roleUnselectedUserIds").value=ids;
	_role_unselected_user_form_obj.form('submit',{
		url:'${ctx}/pm/user/user!assignRole.action',
		success:function(data){
			eval('data='+data);
			if(data.success){
				$.messager.alert('Info',data.message,'info');
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
function dosearchUnselectedByRole(){
	var name=document.getElementById("_role_search_unslt_name").value;;
	_role_unselected_users_grid.datagrid('reload',{
			filter_LIKES_name:name
		});
}
//-->
</script>
<table border="0">
	<tr>
			<td><s:text name='label.pm.role.name'></s:text>:</td>
			<td><input type="text" id="_role_search_unslt_name" name="_role_search_unslt_name" value="" size="15"/></td>
			<td><a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="dosearchUnselectedByRole();"><s:text name='button.common.search'></s:text></a></td>
	</tr>
</table>
<!--<div id="_role_unselected_user_panel" style="padding:5px;">-->
<form id="roleUnselectedUserForm" method="post">
    <input type="hidden" name="userId" value="${userId}"/>
    <input type="hidden" name="roleUnselectedUserIds" id="roleUnselectedUserIds" value=""/>
       <table id="roleUnselectedUserTable">
			<thead>
				<tr>
					<th field="roleId" align="middle" checkbox="true"></th>
					<th field="name" width="200" align="middle" sortable="true"><s:text name='label.pm.role.name'></s:text></th>
					<th field="remark" width="300" align="middle"><s:text name='label.pm.role.remark'></s:text></th>
				</tr>
			</thead>
		</table>
	</form>

<!--</div>-->
