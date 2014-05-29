<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>Home Page</title>
	<%@ include file="/common/header.jsp" %>
</head>
<script type="text/javascript">
<!--
var fieldTypeDics=<%=request.getAttribute("_field_type_items")%>;
var lastIndex;
var lastRow = null;
var editcount = 0;
$(function(){
	_field_panle_obj=$('#_field_panel').panel({
		height:370
	});
	_field_grid_obj=$('#_field_table').datagrid({
			url : '${ctx}/pm/field/field!getAllFieldsByModule.action?moduleId=<%=request.getParameter("moduleId")%>',
			title:"<s:text name='label.pm.field.list'></s:text>",
			iconCls:'icon-edit',
			rownumbers : true,
			width:'623',
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
						$('#_field_table').datagrid('appendRow',{
							domId:'',
							name:'',
							fieldType:'',
							remark:'',
							action:''
						});
						var index = $('#_field_table').datagrid('getRows').length-1;
						$('#_field_table').datagrid('beginEdit', index);
						//alert(editcount);
					}
				},'-',{
				id : 'btnsave',   
                text : "<s:text name='button.common.save'></s:text>",   
                //disabled : true,   
                iconCls : 'icon-save',   
                handler : function() {
                    //alert(editcount);   
                	if(editcount>0){
						$.messager.alert("<s:text name='label.common.error'></s:text>","<s:text name='message.common.notAccept'></s:text>",'error');
						return;
					}
                    var insertRows = $('#_field_table').datagrid('getChanges','inserted');   
                    var updateRows = $('#_field_table').datagrid('getChanges','updated');   
                    var deleteRows = $('#_field_table').datagrid('getChanges','deleted');   
                    var changesRows = {   
                            inserted : [],   
                            updated : [],
                            deleted : []  
                            };   
                    if (insertRows.length>0) {   
                        for (var i=0;i<insertRows.length;i++) {   
                            changesRows.inserted.push(insertRows[i]);   
                        }   
                    }   
  
                    if (updateRows.length>0) {   
                        for (var k=0;k<updateRows.length;k++) {   
                            changesRows.updated.push(updateRows[k]);   
                        }   
                    }   
                       
                    if (deleteRows.length>0) {   
                        for (var j=0;j<deleteRows.length;j++) {   
                            changesRows.deleted.push(deleteRows[j]);   
                        }   
                    }   

  					var json4params = JSON.stringify(changesRows);
                    //alert(json4params);

                    $.ajax({
              			url:"${ctx}/pm/field/field!saveFieldsOfModule.action",
            			type: 'POST',
            			data:{
              					moduleId:"${moduleId}",
              					_request_json_fields:json4params
                			},
            			dataType:'json',
            			error:function(){
                			$.messager.alert("<s:text name='label.common.error'></s:text>","<s:text name='message.common.save.failure'></s:text>","error");
            				return "";
            			},
            			success:function(data){
                			if(data.success){
                				// 保存成功后，可以刷新页面，也可以：   
                                $('#_field_table').datagrid('acceptChanges');
                                $.messager.alert("<s:text name='label.common.success'></s:text>",data.message,"info");
                        	}else{
                        		$.messager.alert("<s:text name='label.common.error'></s:text>",data.message,"error");
                            }
            			}	
                	}); 
                }
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
function closeWin(){
	parent.closeWin();
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
function fieldTypeFormatter(value,rowData,rowIndex){
	for(var i=0; i<fieldTypeDics.length; i++){
		if (fieldTypeDics[i].code == value){ 
			return fieldTypeDics[i].value;
		}
	}
	return value;
}
function cancelRow(id){
	_field_grid_obj.datagrid('cancelEdit', id);
}
function editRow(id){
	_field_grid_obj.datagrid('beginEdit', id);
}
function saveRow(id){
	//alert(id);
	_field_grid_obj.datagrid('endEdit', id);
	//alert(editcount);
}
function deleteRow(id){
	if(editcount>0){
		$.messager.alert("<s:text name='label.common.error'></s:text>","<s:text name='message.common.notDelete'></s:text>",'error');
		return;
	}
	_field_grid_obj.datagrid('deleteRow',id);
	refreshAllRows();
}
function refreshAllRows(){
	var rs = _field_grid_obj.datagrid('getRows');
	for(var i=0;i<rs.length;i++){
		var ri =_field_grid_obj.datagrid('getRowIndex',rs[i]);
		_field_grid_obj.datagrid('refreshRow',ri);
	}
}
//-->
</script>
<body>
<input type="hidden" id="moduleId" name="moduleId" value="${moduleId}"/>
<div id="_field_panel" style="padding:5px;">
<table id="_field_table">
	<thead>
			<tr>
				<th field="domId" width="80" align="center" editor="{
				type:'validatebox',
				options:{
				required:true,
				validType:'length[1,30]'
				}}"
				>
				<s:text name='label.pm.field.domId'></s:text>
				</th>
				<th field="name" width="80" align="center"  editor="text"><s:text name='label.pm.field.name'></s:text></th>
				<th field="fieldType" width="100" align="center" formatter="fieldTypeFormatter" editor="{
				type:'combobox',
				options:{
					data:fieldTypeDics,
					valueField:'code',
					textField:'value',
					editable:false,
					required:true
				}}">
				<s:text name='label.pm.field.type'></s:text>
				</th>
				<th field="remark" width="100" align="center" editor="text"><s:text name='label.pm.field.remark'></s:text></th>
				<th field="action" width="80" align="right" formatter="actionFormatter"><s:text name='label.common.action'></s:text></th>
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