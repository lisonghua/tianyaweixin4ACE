<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<script type="text/javascript">
<!--
var listenerFieldsEditCount = 0;
jq(function(){
	
	_listener_event_type=jq('#listenerEventType').combobox({
		editable:false
	});
	
	_line_listener_fields_dg=jq('#line-listeners-fields-list').datagrid({
		//title:"Listener",
		//url:'${ctx}/wf/procdef/procdef!search.action',//加载表格数据的URL
		singleSelect:true,
		width:600,
		height:300,
		iconCls:'icon-edit',
		//fit:true,
		//idField:'id',
		//pagination:true,
		//pageSize:15,
		//pageNumber:1,
		//pageList:[10,15],
		rownumbers:true,
		//sortName:'id',
	    //sortOrder:'asc',
	    striped:true,
	    toolbar:[{
	        text:'New',
	        iconCls:'icon-add',
	        handler:function(){
		    	if(listenerFieldsEditCount>0){
					jq.messager.alert("<s:text name='label.common.error'></s:text>","<s:text name='message.common.notAdd'></s:text>",'error');
					return;
				}
				jq('#line-listeners-fields-list').datagrid('appendRow',{
					id:'',
					fieldName:'',
					type:'',
					value:'',
					action:''
				});
				var index = jq('#line-listeners-fields-list').datagrid('getRows').length-1;
				jq('#line-listeners-fields-list').datagrid('beginEdit', index);
	        }
	    }],
		
		onDblClickRow:function(rowIndex,rowData){
			editListenerField(rowIndex);
		},
		
		onBeforeEdit:function(index,row){
			row.editing = true;
			jq(this).datagrid('refreshRow', index);
			listenerFieldsEditCount++;
		},
		onAfterEdit:function(index,row){
			row.editing = false;
			jq(this).datagrid('refreshRow', index);
			listenerFieldsEditCount--;
		},
		onCancelEdit:function(index,row){
			row.editing = false;
			jq(this).datagrid('refreshRow', index);
			listenerFieldsEditCount--;
		}
	});
	jq('#fieldSaveBt').linkbutton({
		iconCls:"icon-save"
	});
	jq('#fieldCancelBt').linkbutton({
		iconCls:"icon-cancel"
	});
	jq('#selectListenerServiceClassBt').linkbutton({
		iconCls:"icon-search"
	});
	populateListenerProperties();
});
function changeListenerServiceType(obj){
	if(obj.value=='javaClass'){
		jq('#listenerServiceLabel').html('Service Class:');
		jq('#listenerServiceClass').show();
		jq('#selectListenerServiceClassBt').show();
		jq('#listenerServiceExpression').hide();
	}else if(obj.value=='expression'){
		jq('#listenerServiceLabel').html('Expression:');
		jq('#listenerServiceClass').hide();
		jq('#selectListenerServiceClassBt').hide();
		jq('#listenerServiceExpression').show();
	}
}
function listenerFieldsActionFormatter(value,rowData,rowIndex){
	var id = rowIndex;
	var s='<img onclick="saveListenerField('+id+')" src="${ctx}/image/ok.png" title="'+"<s:text name='button.common.ok'></s:text>"+'" style="cursor:hand;"/>';
	var c='<img onclick="cancelListenerField('+id+')" src="${ctx}/image/cancel.png" title="'+"<s:text name='button.common.cancel'></s:text>"+'" style="cursor:hand;"/>';
	var e='<img onclick="editListenerField('+id+')" src="${ctx}/image/modify.png" title="'+"<s:text name='button.common.modify'></s:text>"+'" style="cursor:hand;"/>';
	var d='<img onclick="deleteListenerField('+id+')" src="${ctx}/image/delete.gif" title="'+"<s:text name='button.common.delete'></s:text>"+'" style="cursor:hand;"/>';
	if(rowData.editing)
		return s;
	else
		return e+'&nbsp;'+d;
}
function cancelListenerField(id){
	_line_listener_fields_dg.datagrid('cancelEdit', id);
}
function editListenerField(id){
	_line_listener_fields_dg.datagrid('beginEdit', id);
}
function saveListenerField(id){
	//alert(id);
	_line_listener_fields_dg.datagrid('endEdit', id);
	//alert(editcount);
}
function deleteListenerField(id){
	_line_listener_fields_dg.datagrid('deleteRow',id);
	refreshAllListenerFields();
}
function refreshAllListenerFields(){
	var rs = _line_listener_fields_dg.datagrid('getRows');
	for(var i=0;i<rs.length;i++){
		var ri =_line_listener_fields_dg.datagrid('getRowIndex',rs[i]);
		_line_listener_fields_dg.datagrid('refreshRow',ri);
	}
}
function createNewListener(){
	var newListener = new draw2d.DecoratedConnection.Listener();
    return newListener;   
}
function getExsitingListener(){
	if(executionListenerId != "" && executionListenerId != null && executionListenerId!="null"&&executionListenerId!="NULL"){
		var listener = line.getListener(executionListenerId);
		return listener;
	}
}
function getListenerFieldsGridChangeRows(){
	if(listenerFieldsEditCount>0){
		jq.messager.alert("<s:text name='label.common.error'></s:text>","<s:text name='message.common.notAccept'></s:text>",'error');
		return null;
	}
    var insertRows = _line_listener_fields_dg.datagrid('getChanges','inserted');   
    var updateRows = _line_listener_fields_dg.datagrid('getChanges','updated');   
    var deleteRows = _line_listener_fields_dg.datagrid('getChanges','deleted');   
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
function saveListenerConfig(){
	if(executionListenerId != "" && executionListenerId != null && executionListenerId!="null"&&executionListenerId!="NULL"){
		var listener = getExsitingListener();
		var r = updateExistingListener(listener);
		if(!r)return;		
	}else{
		var listener = createNewListener();
		var r = insertNewListener(listener);
		if(!r)return;
	}
	_listener_win.window('close');
}
function insertNewListener(listener){
	listener.event=_listener_event_type.combobox('getValue');
	jq('input[name="listenerServiceType"]').each(function(i){
		if(this.checked){
			listener.serviceType=this.value;
			return false;
		}
	});
	listener.serviceClass=jq('#listenerServiceClass').val();
	listener.serviceExpression=jq('#listenerServiceExpression').val();
    var changesRows = getListenerFieldsGridChangeRows();
    if(changesRows == null)return false;
    var insertRows = changesRows['inserted'];   
    if (insertRows.length>0) {   
        for (var i=0;i<insertRows.length;i++) {
            var field = new draw2d.DecoratedConnection.Listener.Field();
    		field.name=insertRows[i].fieldName;
    		field.value=insertRows[i].value;
    		field.type=insertRows[i].type;
    		listener.fields.add(field);  
        }   
    }
	line.listeners.add(listener);
	loadLineListeners();
	return true;
}
function updateExistingListener(listener){
	listener.event=_listener_event_type.combobox('getValue');
	jq('input[name="listenerServiceType"]').each(function(i){
		if(this.checked){
			listener.serviceType=this.value;
			return false;
		}
	});
	listener.serviceClass=jq('#listenerServiceClass').val();
	listener.serviceExpression=jq('#listenerServiceExpression').val();
	var changesRows = getListenerFieldsGridChangeRows();
    if(changesRows == null)return false;
    var insertRows = changesRows['inserted'];   
    var updateRows = changesRows['updated'];   
    var deleteRows = changesRows['deleted'];
    if (insertRows.length>0) {   
        for (var i=0;i<insertRows.length;i++) {   
        	var field = new draw2d.DecoratedConnection.Listener.Field();
    		field.name=insertRows[i].fieldName;
    		field.value=insertRows[i].value;
    		field.type=insertRows[i].type;
    		listener.fields.add(field);
        }   
    }   

    if (updateRows.length>0) {   
        for (var k=0;k<updateRows.length;k++) {   
        	var field = listener.getField(updateRows[k].id);
    		field.name=updateRows[k].fieldName;
    		field.value=updateRows[k].value;
    		field.type=updateRows[k].type;
        }   
    }   
       
    if (deleteRows.length>0) {   
        for (var j=0;j<deleteRows.length;j++) {   
        	listener.deleteField(deleteRows[j].id);
        }   
    }
    loadLineListeners();
    return true;
}

function populateListenerProperties(){
	if(executionListenerId != "" && executionListenerId != null && executionListenerId!="null"&&executionListenerId!="NULL"){
		var listener = line.getListener(executionListenerId);
		_listener_event_type.combobox('select',listener.event);
		var serviceType = listener.serviceType;
		jq('input[name="listenerServiceType"]').each(function(i){
			if(this.value==serviceType){
				this.checked=true;
				changeListenerServiceType(this);
				if(this.value=='javaClass'){
					jq('#listenerServiceClass').val(listener.serviceClass);
				}else if(this.value=='expression'){
					jq('#listenerServiceExpression').val(listener.serviceExpression);
				}
				return false;
			}
		});
		var fields = listener.fields;
		var _listener_fields_grid_data=[];
		for(var i=0;i<fields.getSize();i++){
			var field = {
					id:fields.get(i).id,
					fieldName:fields.get(i).name,
					type:fields.get(i).type,
					value:fields.get(i).value,
					action:''
					};
			_listener_fields_grid_data[i]=field;
		}
		_line_listener_fields_dg.datagrid('loadData',_listener_fields_grid_data);
	}
}
function closeLineListenerWin(){
	_listener_win.window('close');
}
//-->
</script>
<table>
		<tr>
			<td align="right">Event:</td>
			<td>
				<select id="listenerEventType" name="listenerEventType">
					<option value="take">Take</option>
				</select>
			</td>
		</tr>
		<tr>
			<td></td>
			<td align="left">
				<input type="radio" id="listenerServiceType" name="listenerServiceType" value="javaClass" checked="checked" onclick="changeListenerServiceType(this)">Java Class
				<input type="radio" id="listenerServiceType" name="listenerServiceType" value="expression" onclick="changeListenerServiceType(this)">Express
			</td>
		</tr>
		<tr>
			<td id="listenerServiceLabel" align="right">Service Class:</td>
			<td>
				<input type="text" id="listenerServiceClass" name="listenerServiceClass" size="80" value="" readonly="readonly"/>
				<input type="text" id="listenerServiceExpression" name="listenerServiceExpression" size="80" style="display: none;" value=""/>
				<a href="##" id="selectListenerServiceClassBt" onclick="">Select</a>
			</td>
		</tr>
		<tr>
			<td align="right">Fields:</td>
			<td>
				<table id="line-listeners-fields-list">
					<thead>
					<tr>
					<th field="id" hidden="true"></th>
					<th field="fieldName" width="200" align="middle" sortable="false" editor="{
						type:'validatebox',
						options:{
						required:true,
						validType:'length[1,100]'
					}}">Field Name</th>
					<th field="type" width="100" align="middle" sortable="false" editor="{
						type:'combobox',
						options:{
							editable:false,
							data:[{id:'string',text:'String',selected:true},{id:'expression',text:'Expression'}],
							valueField:'id',
							textField:'text'
					}}">Type</th>
					<th field="value" width="200" align="middle" sortable="false" editor="{
						type:'validatebox',
						options:{
						validType:'length[1,100]'
					}}">Value</th>
					<th field="action" width="80" align="middle" formatter="listenerFieldsActionFormatter"><s:text name='label.common.action'></s:text></th>
					</tr>
					</thead>
				</table>
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<a href="##" id="fieldSaveBt" onclick="saveListenerConfig()">Save</a>
				<a href="##" id="fieldCancelBt" onclick="closeLineListenerWin()">Cancel</a>
			</td>
		</tr>
</table>