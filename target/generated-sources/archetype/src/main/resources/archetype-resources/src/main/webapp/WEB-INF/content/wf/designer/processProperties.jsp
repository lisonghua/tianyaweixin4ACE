#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<script type="text/javascript">
<!--
var pid = "<%=request.getParameter("processId")%>";
var process = workflow.process;
var processVariablesEditCount = 0;
jq(function(){
	
	_listener_win = jq('${symbol_pound}listener-win').window({
		//href:'${symbol_dollar}{ctx}/wf/procdef/procdef!forTaskListenerConfig.action',   
	    closed:true,
	    //cache:false,
	    draggable:false,
	    collapsible:false,
	    minimizable:false,
	    maximizable:false,
	    modal:true,
	    shadow:true
	});
	jq('${symbol_pound}process-listeners-list').datagrid({
		//title:"Listener",
		//url:'${symbol_dollar}{ctx}/wf/procdef/procdef!search.action',//加载表格数据的URL
		singleSelect:true,
		//width:500,
		height:300,
		//idField:'id',
		//pagination:true,
		//pageSize:15,
		//pageNumber:1,
		//pageList:[10,15],
		rownumbers:true,
		//sortName:'id',
	    //sortOrder:'asc',
	    striped:true,
	    fitColumns:true,
	    toolbar:[{
	        text:'New',
	        iconCls:'icon-add',
	        handler:function(){
	    		_listener_win.window('open');
	    		//_listener_frame.src="";
	    		executionListenerId=null;
	    		_listener_win.window('refresh','${symbol_dollar}{ctx}/wf/procdef/procdef!forProcessListenerConfig.action');
	    		//alert(_listener_frame.document.body.innerHTML);
	        }
	    }]
	});
	_process_variables_dg=jq('${symbol_pound}process-variables-table').datagrid({
		//title:"Listener",
		//url:'${symbol_dollar}{ctx}/wf/procdef/procdef!search.action',//加载表格数据的URL
		singleSelect:true,
		//width:600,
		height:300,
		iconCls:'icon-edit',
		//fit:true,
		//idField:'id',
		rownumbers:true,
	    striped:true,
	    fitColumns:true,
	    toolbar:[{
	        text:'New',
	        iconCls:'icon-add',
	        handler:function(){
		    	if(processVariablesEditCount>0){
					jq.messager.alert("<s:text name='label.common.error'></s:text>","<s:text name='message.common.notAdd'></s:text>",'error');
					return;
				}
				jq('${symbol_pound}process-variables-table').datagrid('appendRow',{
					id:'',
					name:'',
					type:'',
					scope:'',
					action:''
				});
				var index = jq('${symbol_pound}process-variables-table').datagrid('getRows').length-1;
				jq('${symbol_pound}process-variables-table').datagrid('beginEdit', index);
	        }
	    }],
		
		onDblClickRow:function(rowIndex,rowData){
			editProcessVariable(rowIndex);
		},
		
		onBeforeEdit:function(index,row){
			row.editing = true;
			jq(this).datagrid('refreshRow', index);
			processVariablesEditCount++;
		},
		onAfterEdit:function(index,row){
			row.editing = false;
			jq(this).datagrid('refreshRow', index);
			processVariablesEditCount--;
		},
		onCancelEdit:function(index,row){
			row.editing = false;
			jq(this).datagrid('refreshRow', index);
			processVariablesEditCount--;
		}
	});
	populateProcessProperites();
});
function listenerActionBt(value,rowData,rowIndex){
	var id = rowData.id;
	var e = '<img onclick="editListener(${symbol_escape}''+id+'${symbol_escape}')" src="${symbol_dollar}{ctx}/image/edit.gif" title="'+"<s:text name='button.common.modify'></s:text>"+'" style="cursor:hand;"/>';   
    var d = '<img onclick="deleteListener(${symbol_escape}''+id+'${symbol_escape}')" src="${symbol_dollar}{ctx}/image/delete.gif" title="'+"<s:text name='button.common.delete'></s:text>"+'" style="cursor:hand;"/>';
	return e+'&nbsp;'+d;
}
function editListener(id){
	executionListenerId=id;
	_listener_win.window('open');
	_listener_win.window('refresh','${symbol_dollar}{ctx}/wf/procdef/procdef!forProcessListenerConfig.action?listenerId='+id);
}
function deleteListener(id){
	process.deleteListener(id);
	executionListenerId=null;
	loadTaskListeners();
}
function saveProcessProperties(){
	process.id=jq('${symbol_pound}id').val();
	process.name=jq('${symbol_pound}name').val();
	process.category=jq('${symbol_pound}category').val();
	process.documentation=jq('${symbol_pound}documentation').val();
	jq.messager.alert('Info','Save Successfully!','info');
}
function populateProcessProperites(){
	jq('${symbol_pound}id').val(process.id);
	jq('${symbol_pound}name').val(process.name);
	jq('${symbol_pound}category').val(process.category);
	jq('${symbol_pound}documentation').val(process.documentation);
	loadProcessListeners();
	loadProcessVariables();
}
function loadProcessListeners(){
	var listeners = process.listeners;
	var listener_grid_rows=[];
	//alert(listeners.getSize());
	for(var i=0;i<listeners.getSize();i++){
		var listener = listeners.get(i);
		var nlistener = {
					id:listener.getId(),
					listenerImplimentation:listener.getServiceImplementation(),
					type:listener.serviceType,
					event:listener.event,
					fields:listener.getFieldsString(),
					action:''
				};
		listener_grid_rows[i]=nlistener;
	};
	//alert(listener_grid_rows);
	var listener_grid_data={
			total:listeners.getSize(),
			rows:listener_grid_rows
	};
	jq('${symbol_pound}process-listeners-list').datagrid('loadData',listener_grid_data);
}
function loadProcessVariables(){
	var variables = process.variables;
	var variables_grid_rows=[];
	for(var i=0;i<variables.getSize();i++){
		var variable = variables.get(i);
		var v = {
					id:variable.id,
					name:variable.name,
					type:variable.type,
					scope:variable.scope,
					defaultValue:variable.defaultValue,
					remark:variable.remark,
					action:''
				};
		variables_grid_rows[i]=v;
	};
	var variables_grid_data={
			total:variables.getSize(),
			rows:variables_grid_rows
	};
	_process_variables_dg.datagrid('loadData',variables_grid_data);
}
function cancelProcessVariable(id){
	_process_variables_dg.datagrid('cancelEdit', id);
}
function editProcessVariable(id){
	_process_variables_dg.datagrid('beginEdit', id);
}
function saveProcessVariable(id){
	_process_variables_dg.datagrid('endEdit', id);
	var rows = _process_variables_dg.datagrid('getRows');
	var rowData = rows[id];
	var variable = new draw2d.Process.variable();
	variable.name=rowData.name;
	variable.type=rowData.type;
	variable.scope=rowData.scope;
	variable.defaultValue=rowData.defaultValue;
	variable.remark=rowData.remark;
	process.addVariable(variable);
}
function deleteProcessVariable(id){
	var rows = _process_variables_dg.datagrid('getRows');
	var rowData = rows[id];
	process.deleteVariable(rowData.id);
	_process_variables_dg.datagrid('deleteRow',id);
	refreshAllProcessVariables();
}
function refreshAllProcessVariables(){
	var rs = _process_variables_dg.datagrid('getRows');
	for(var i=0;i<rs.length;i++){
		var ri =_process_variables_dg.datagrid('getRowIndex',rs[i]);
		_process_variables_dg.datagrid('refreshRow',ri);
	}
}
function processVariablesActionFormatter(value,rowData,rowIndex){
	var id = rowIndex;
	var name = rowData.name;
	var s='<img onclick="saveProcessVariable('+id+')" src="${symbol_dollar}{ctx}/image/ok.png" title="'+"<s:text name='button.common.ok'></s:text>"+'" style="cursor:hand;"/>';
	var c='<img onclick="cancelProcessVariable('+id+')" src="${symbol_dollar}{ctx}/image/cancel.png" title="'+"<s:text name='button.common.cancel'></s:text>"+'" style="cursor:hand;"/>';
	var e='<img onclick="editProcessVariable('+id+')" src="${symbol_dollar}{ctx}/image/modify.png" title="'+"<s:text name='button.common.modify'></s:text>"+'" style="cursor:hand;"/>';
	var d='<img onclick="deleteProcessVariable('+id+')" src="${symbol_dollar}{ctx}/image/delete.gif" title="'+"<s:text name='button.common.delete'></s:text>"+'" style="cursor:hand;"/>';
	if(rowData.editing)
		return s;
	else
		return e+'&nbsp;'+d;
}
//-->
</script>
<div id="process-properties-layout" class="easyui-layout" fit="true">
	<div id="task-properties-toolbar-panel" region="north" border="false" style="height:30px;background:${symbol_pound}E1F0F2;">
		<a href="${symbol_pound}${symbol_pound}" id="sb2" class="easyui-linkbutton" plain="true" iconCls="icon-save" onclick="saveProcessProperties()">Save</a>
	</div>
	<div id="process-properties-panel" region="center" border="true">
		<div class="easyui-accordion" fit="true" border="false">
			<div id="general" title="General" selected="true" class="properties-menu">
				<table id="general-properties">
					<tr>
						<td align="right">Id:</td>
						<td><input type="text" id="id" name="id" size="50" value=""/></td>
					</tr>
					<tr>
						<td align="right">Name:</td>
						<td><input type="text" id="name" name="name" size="50" value=""/></td>
					</tr>
					<tr>
						<td align="right">Category:</td>
						<td><input type="text" id="category" name="category" size="50" value=""/></td>
					</tr>
					<tr>
						<td align="right">Documentation:</td>
						<td><textarea id="documentation" name="documentation" cols="20" rows="5"></textarea></td>
					</tr>
				</table>
			</div>
			<div id="variables" title="Variables" class="properties-menu">
				<table id="process-variables-table" style="padding:5px;">
					<thead>
					<tr>
					<th field="id" hidden="true"></th>
					<th field="name" width="200" align="middle" sortable="false" editor="{
						type:'validatebox',
						options:{
						required:true,
						validType:'length[1,100]'
					}}">Variable Name</th>
					<th field="type" width="100" align="middle" sortable="false" editor="{
						type:'combobox',
						options:{
							editable:false,
							data:[
							{id:'string',text:'string',selected:true},
							{id:'double',text:'number'},
							{id:'boolean',text:'boolean'}
							],
							valueField:'id',
							textField:'text'
					}}">Type</th>
					<th field="scope" width="100" align="middle" sortable="false" editor="{
						type:'combobox',
						options:{
							editable:false,
							data:[
							{id:'request',text:'request',selected:true},
							{id:'session',text:'session'},
							{id:'application',text:'application'}
							],
							valueField:'id',
							textField:'text'
					}}">Scope</th>
					<th field="defaultValue" width="100" align="middle" sortable="false" editor="{
						type:'validatebox',
						options:{
						required:false,
						validType:'length[1,150]'
					}}">Default Value</th>
					<th field="remark" width="100" align="middle" sortable="false" editor="{
						type:'validatebox',
						options:{
						required:false,
						validType:'length[1,150]'
					}}">Remark</th>
					<th field="action" width="80" align="middle" formatter="processVariablesActionFormatter"><s:text name='label.common.action'></s:text></th>
					</tr>
					</thead>
				</table>
			</div>
			<div id="listeners" title="Listeners" style="overflow: hidden;padding:5px;">
				<table id="process-listeners-list">
					<thead>
					<tr>
					<th field="listenerImplimentation" width="200" align="middle" sortable="false">Listener Implimentation</th>
					<th field="type" width="70" align="middle" sortable="false">Type</th>
					<th field="event" width="70" align="middle" sortable="false">Event</th>
					<th field="fields" width="100" align="middle" >Fields</th>
					<th field="action" width="100" align="middle" formatter="listenerActionBt">Action</th>
					</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
</div>