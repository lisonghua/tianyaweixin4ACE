#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<script type="text/javascript">
<!--
var formValuesEditCount = 0;
jq(function(){
	
	_form_property_type=jq('${symbol_pound}propertyType').combobox({
		editable:false
	});
	_form_property_readable=jq('${symbol_pound}readable').combobox({
		editable:false
	});
	_form_property_writeable=jq('${symbol_pound}writeable').combobox({
		editable:false
	});
	_form_property_required=jq('${symbol_pound}required').combobox({
		editable:false
	});
	_task_form_values_dg=jq('${symbol_pound}task-form-values-list').datagrid({
		singleSelect:true,
		width:600,
		height:200,
		iconCls:'icon-edit',
		rownumbers:true,
	  striped:true,
	    toolbar:[{
	        text:'New',
	        iconCls:'icon-add',
	        handler:function(){
		    	if(formValuesEditCount>0){
						jq.messager.alert("error","有可编辑的单元格，不能添加",'error');
						return;
					}
					jq('${symbol_pound}task-form-values-list').datagrid('appendRow',{
					id:'',
					name:'',
					action:''
					});
						var index = jq('${symbol_pound}task-form-values-list').datagrid('getRows').length-1;
						jq('${symbol_pound}task-form-values-list').datagrid('beginEdit', index);
	        }
	    }],
		
		onDblClickRow:function(rowIndex,rowData){
			editListenerField(rowIndex);
		},
		
		onBeforeEdit:function(index,row){
			row.editing = true;
			jq(this).datagrid('refreshRow', index);
			formValuesEditCount++;
		},
		onAfterEdit:function(index,row){
			row.editing = false;
			jq(this).datagrid('refreshRow', index);
			formValuesEditCount--;
		},
		onCancelEdit:function(index,row){
			row.editing = false;
			jq(this).datagrid('refreshRow', index);
			formValuesEditCount--;
		}
	});
	
	jq('${symbol_pound}formSaveBt').linkbutton({
		iconCls:"icon-save"
	});
	jq('${symbol_pound}formCancelBt').linkbutton({
		iconCls:"icon-cancel"
	});
	populateFormProperties();
});

function formValuesActionFormatter(value,rowData,rowIndex){
	var id = rowIndex;
	var s='<img onclick="saveFormValue('+id+')" src="../../image/ok.png" title="Save" style="cursor:hand;"/>';
	var c='<img onclick="cancelFormValue('+id+')" src="../../image/cancel.png" title="Cancel" style="cursor:hand;"/>';
	var e='<img onclick="editFormValue('+id+')" src="../../image/modify.png" title="Update" style="cursor:hand;"/>';
	var d='<img onclick="deleteFormValue('+id+')" src="../../image/delete.gif" title="Delete" style="cursor:hand;"/>';
	if(rowData.editing){
		return s;
	}else{
		return e+'&nbsp;'+d;
	}
}
function cancelFormValue(id){
	_task_form_values_dg.datagrid('cancelEdit', id);
}
function editFormValue(id){
	_task_form_values_dg.datagrid('beginEdit', id);
}
function saveFormValue(id){
	//alert(id);
	_task_form_values_dg.datagrid('endEdit', id);
	//alert(editcount);
}
function deleteFormValue(id){
	_task_form_values_dg.datagrid('deleteRow',id);
	refreshAllFormValues();
}
function refreshAllFormValues(){
	var rs = _task_form_values_dg.datagrid('getRows');
	for(var i=0;i<rs.length;i++){
		var ri =_task_form_values_dg.datagrid('getRowIndex',rs[i]);
		_task_form_values_dg.datagrid('refreshRow',ri);
	}
}
function createNewProperty(){
	var property = new draw2d.UserTask.FormProperty();
    return property;   
}
function getExsitingProperty(propId){
	var property = task.getFormProperties(propId);
	return property;
}
function getFormValuesGridChangeRows(){
	if(formValuesEditCount>0){
		jq.messager.alert("error","有可编辑的单元格，不能添加",'error');
		return null;
	}
    var insertRows = _task_form_values_dg.datagrid('getChanges','inserted');   
    var updateRows = _task_form_values_dg.datagrid('getChanges','updated');   
    var deleteRows = _task_form_values_dg.datagrid('getChanges','deleted');   
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
    return changesRows;
}
function saveTaskFormConfig(){
	if(formPropertyId != "" && formPropertyId != null && formPropertyId!="null"&&formPropertyId!="NULL"){
		var prop = getExsitingProperty(formPropertyId);
		var r = updateExistingProperty(prop);
		if(!r)return;		
	}else{
		var prop = createNewProperty();
		var r = insertNewProperty(prop);
		if(!r)return;
	}
	_form_win.window('close');
}
function insertNewProperty(prop){
	prop.id=jq('${symbol_pound}propertyId').val();
	prop.name=jq('${symbol_pound}propertyName').val();
	prop.type=_form_property_type.combobox('getValue');
	prop.expression=jq('${symbol_pound}expressionValue').val();
	prop.variable=jq('${symbol_pound}variable').val();
	prop.defaultValue=jq('${symbol_pound}default').val();
	prop.datePattern=jq('${symbol_pound}datePattern').val();
	prop.readable=_form_property_readable.combobox('getValue');
	prop.writeable=_form_property_writeable.combobox('getValue');
	prop.required=_form_property_required.combobox('getValue');
	var changesRows = getFormValuesGridChangeRows();
    if(changesRows == null)return false;
    var insertRows = changesRows['inserted'];   
    if (insertRows.length>0) {   
        for (var i=0;i<insertRows.length;i++) {
            var fvs = new draw2d.UserTask.FormProperty.FormValue();
		    		fvs.id=insertRows[i].id;
		    		fvs.name=insertRows[i].name;
		    		prop.values.add(fvs);  
        }   
    }
	task.formProperties.add(prop);
	loadTaskFormProperties();
	return true;
}
function updateExistingProperty(prop){
	prop.id=jq('${symbol_pound}propertyId').val();
	prop.name=jq('${symbol_pound}propertyName').val();
	prop.type=_form_property_type.combobox('getValue');
	prop.expression=jq('${symbol_pound}expressionValue').val();
	prop.variable=jq('${symbol_pound}variable').val();
	prop.defaultValue=jq('${symbol_pound}default').val();
	prop.datePattern=jq('${symbol_pound}datePattern').val();
	prop.readable=_form_property_readable.combobox('getValue');
	prop.writeable=_form_property_writeable.combobox('getValue');
	prop.required=_form_property_required.combobox('getValue');
	var changesRows = getFormValuesGridChangeRows();
    if(changesRows == null)return false;
    var insertRows = changesRows['inserted'];   
    var updateRows = changesRows['updated'];   
    var deleteRows = changesRows['deleted'];   
    if (insertRows.length>0) {   
        for (var i=0;i<insertRows.length;i++) {
            var fvs = new draw2d.UserTask.FormProperty.FormValue();
		    		fvs.id=insertRows[i].id;
		    		fvs.name=insertRows[i].name;
		    		prop.values.add(fvs);  
        }   
    }

    if (updateRows.length>0) {   
        for (var k=0;k<updateRows.length;k++) {   
        	var fvs = prop.getFormValue(updateRows[k].id);
	    		fvs.id=updateRows[k].id;
	    		fvs.name=updateRows[k].name;
        }   
    }   
       
    if (deleteRows.length>0) {   
        for (var j=0;j<deleteRows.length;j++) {   
        	prop.deleteFormValue(deleteRows[j].id);
        }   
    }
    loadTaskFormProperties();
    return true;
}

function populateFormProperties(){
	if(formPropertyId != "" && formPropertyId != null && formPropertyId!="null"&&formPropertyId!="NULL"){
		var prop = task.getFormProperties(formPropertyId);
		jq('${symbol_pound}propertyId').val(prop.id);
		jq('${symbol_pound}propertyName').val(prop.name);
		_form_property_type.combobox('setValue',prop.type);
		jq('${symbol_pound}expressionValue').val(prop.expression);
		jq('${symbol_pound}variable').val(prop.variable);
		jq('${symbol_pound}default').val(prop.defaultValue);
		jq('${symbol_pound}datePattern').val(prop.datePattern);
		_form_property_readable.combobox('setValue',prop.readable);
		_form_property_writeable.combobox('setValue',prop.writeable);
		_form_property_required.combobox('setValue',prop.required);
		var fvs = prop.values;
		var _form_values_grid_data=[];
		for(var i=0;i<fvs.getSize();i++){
			var v = {
					id:fvs.get(i).id,
					name:fvs.get(i).name,
					action:''
					};
			_form_values_grid_data[i]=v;
		}
		_task_form_values_dg.datagrid('loadData',_form_values_grid_data);
	}
}
function closeTaskFormPropertyWin(){
	_form_win.window('close');
}
//-->
</script>
<table>
		<tr>
			<td align="right">Id:</td>
			<td>
				<input type="text" id="propertyId" name="propertyId" size="80" value="" required="required"/>
			</td>
		</tr>
		<tr>
			<td align="right">Name:</td>
			<td>
				<input type="text" id="propertyName" name="propertyName" size="80" value=""/>
			</td>
		</tr>
		<tr>
			<td align="right">Type:</td>
			<td>
				<select id="propertyType" name="propertyType">
					<option value=""></option>
					<option value="string">string</option>
					<option value="long">long</option>
					<option value="enum">enum</option>
					<option value="date">date</option>
					<option value="boolean">boolean</option>
				</select>
			</td>
		</tr>
		<tr>
			<td align="right">Expression:</td>
			<td>
				<input type="text" id="expressionValue" name="expressionValue" size="80" value=""/>
			</td>
		</tr>
		<tr>
			<td align="right">Variable:</td>
			<td>
				<input type="text" id="variable" name="variable" size="80" value=""/>
			</td>
		</tr>
		<tr>
			<td align="right">Default:</td>
			<td>
				<input type="text" id="default" name="default" size="80" value=""/>
			</td>
		</tr>
		<tr>
			<td align="right">Date Pattern:</td>
			<td>
				<input type="text" id="datePattern" name="datePattern" size="80" value=""/>
			</td>
		</tr>
		<tr>
			<td align="right">Readable:</td>
			<td>
				<select id="readable" name="readable">
					<option value=""></option>
					<option value="true">true</option>
					<option value="false">false</option>
				</select>
			</td>
		</tr>
		<tr>
			<td align="right">Writeable:</td>
			<td>
				<select id="writeable" name="writeable">
					<option value=""></option>
					<option value="true">true</option>
					<option value="false">false</option>
				</select>
			</td>
		</tr>
		<tr>
			<td align="right">Required:</td>
			<td>
				<select id="required" name="required">
					<option value=""></option>
					<option value="true">true</option>
					<option value="false">false</option>
				</select>
			</td>
		</tr>
		<tr>
			<td align="right">Form values:</td>
			<td>
				<table id="task-form-values-list">
					<thead>
					<tr>
					<th field="id" width="200" align="middle" sortable="false"editor="{
						type:'validatebox',
						options:{
						required:true,
						validType:'length[1,100]'
					}}">Id</th>
					<th field="name" width="200" align="middle" sortable="false" editor="{
						type:'validatebox',
						options:{
						required:true,
						validType:'length[1,100]'
					}}">Name</th>
					<th field="action" width="80" align="middle" formatter="formValuesActionFormatter">Action</th>
					</tr>
					</thead>
				</table>
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<a href="${symbol_pound}${symbol_pound}" id="formSaveBt" onclick="saveTaskFormConfig()">Save</a>
				<a href="${symbol_pound}${symbol_pound}" id="formCancelBt" onclick="closeTaskFormPropertyWin()">Cancel</a>
			</td>
		</tr>
</table>