<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<script type="text/javascript">
<!--
var operatorTypeDics=<%=request.getAttribute("_operator_type_items")%>;
var lastIndex;
var lastRow = null;
var editcount = 0;
$(function(){
	_edit_grid_panel_obj=$('#_edit_grid_panel').panel({
		//height:370
		fit:true
	});
	_qstring_edit_grid_obj=$('#_qstring_edit_grid').datagrid({
			//url : '${ctx}/pm/field/field!getAllFieldsByModule.action?moduleId=<%=request.getParameter("moduleId")%>',
			title:"<s:text name='label.sm.app.advanced.search.title'></s:text>",
			iconCls:'icon-edit',
			rownumbers : true,
			width:'625',
			height:'300',
			singleSelect:true,
			idField:'fieldId',
			
			toolbar:[{
					text:"<s:text name='button.common.add'></s:text>",
					iconCls:'icon-add',
					handler:function(){
						if(editcount>0){
							$.messager.alert("<s:text name='label.common.error'></s:text>","<s:text name='message.common.notAdd'></s:text>",'error');
							return;
						}
						$('#_qstring_edit_grid').datagrid('appendRow',{
							param:'',
							operator:'',
							value:''
						});
						var index = $('#_qstring_edit_grid').datagrid('getRows').length-1;
						$('#_qstring_edit_grid').datagrid('beginEdit', index);
						//alert(editcount);
					}
				},'-',{
				id : 'btnsave',   
                text : "<s:text name='button.common.ok'></s:text>",   
                //disabled : true,   
                iconCls : 'icon-ok',   
                handler : confirmConditions
			}
			],
			
			onDblClickRow:function(rowIndex,rowData){
				editRow(rowIndex);
			},
			
			onBeforeEdit:function(index,row){
				row.editing = true;
				$(this).datagrid('refreshRow', index);
				editcount++;
			},
			onAfterEdit:function(index,row){
				row.editing = false;
				$(this).datagrid('refreshRow', index);
				editcount--;
			},
			onCancelEdit:function(index,row){
				row.editing = false;
				$(this).datagrid('refreshRow', index);
				editcount--;
			}
		});
});
function confirmConditions(){
	if(!validateEdit())return;
    closeAdvancedSearch();
	/*
    $.ajax({
			url:"${ctx}/sm/appserver/appserver!exportEverydayAccessNum4PerAppReport.action",
		type: 'POST',
		data:{
					_request_json_fields:json4params
			},
		dataType:'html',
		error:function(){
			$.messager.alert("<s:text name='label.common.error'></s:text>","<s:text name='message.common.save.failure'></s:text>","error");
			return "";
		},
		success:function(data){
			$('#chartdiv').html(responseText);
		}	
	});
	*/
}

function actionFormatter(value,rowData,rowIndex){
	var id = rowIndex;
	var s='<img onclick="saveRow('+id+')" src="${ctx}/image/ok.png" title="'+"<s:text name='button.common.ok'></s:text>"+'" style="cursor:hand;"/>';
	var c='<img onclick="cancelRow('+id+')" src="${ctx}/image/cancel.png" title="'+"<s:text name='button.common.cancel'></s:text>"+'" style="cursor:hand;"/>';
	var e='<img onclick="editRow('+id+')" src="${ctx}/image/modify.png" title="'+"<s:text name='button.common.modify'></s:text>"+'" style="cursor:hand;"/>';
	var d='<img onclick="deleteRow('+id+')" src="${ctx}/image/delete.gif" title="'+"<s:text name='button.common.delete'></s:text>"+'" style="cursor:hand;"/>';
	if(rowData.editing)
		return s;
	else
		return e+'&nbsp;'+d;
}
function operatorTypeFormatter(value,rowData,rowIndex){
	for(var i=0; i<operatorTypeDics.length; i++){
		if (operatorTypeDics[i].code == value){ 
			return operatorTypeDics[i].value;
		}
	}
	return value;
}
function cancelRow(id){
	_qstring_edit_grid_obj.datagrid('cancelEdit', id);
}
function editRow(id){
	_qstring_edit_grid_obj.datagrid('beginEdit', id);
}
function saveRow(id){
	_qstring_edit_grid_obj.datagrid('endEdit', id);
	//alert(editcount);
}
function deleteRow(id){
	_qstring_edit_grid_obj.datagrid('deleteRow',id);
}
//-->
</script>
<div id="_edit_grid_panel" style="padding:5px;">
<table id="_qstring_edit_grid">
	<thead>
			<tr>
				<th field="param" width="200" align="center"  editor="{type:'validatebox',options:{required:true}}"><s:text name='label.sm.app.advanced.search.param'></s:text></th>
				<th field="operator" width="100" align="center" formatter="operatorTypeFormatter" editor="{
				type:'combobox',
				options:{
					data:operatorTypeDics,
					valueField:'code',
					textField:'value',
					editable:false,
					required:true
				}}">
				<s:text name='label.sm.app.advanced.search.opt'></s:text>
				</th>
				<th field="value" width="200" align="center" editor="{type:'validatebox',options:{required:true}}"><s:text name='label.sm.app.advanced.search.value'></s:text></th>
				<th field="action" width="80" align="center" formatter="actionFormatter"><s:text name='label.common.action'></s:text></th>
			</tr>
	</thead>
</table>
<br />
<div style="text-align: center;">
	<a href="javascript:void(0)" onclick="closeAdvancedSearch()" class="easyui-linkbutton" id="btn-cancel" icon="icon-cancel"><s:text name='button.common.close'></s:text></a>
</div>
</div>