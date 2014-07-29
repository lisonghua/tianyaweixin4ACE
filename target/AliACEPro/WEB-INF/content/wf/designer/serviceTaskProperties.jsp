<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<script type="text/javascript">
<!--
//var tid = "";
var fieldsEditCount = 0;
jq(function(){
	jq('#task-properties-accordion').accordion({
		onSelect:function(title,index){
				if(title=='General'){
					var pp = jq('#task-properties-accordion').accordion('getSelected');
					if (pp){
    				pp.panel('refresh','${ctx}/wf/procdef/procdef!forTaskGeneralPage.action');
					}
				}else if(title=='Multi Instance'){
					var pp = jq('#task-properties-accordion').accordion('getSelected');
					if (pp){
    				pp.panel('refresh','${ctx}/wf/procdef/procdef!forTaskMultiInstancePage.action');
					}
				}
			}
		});
	_listener_win = jq('#listener-win').window({
		//href:'${ctx}/wf/procdef/procdef!forTaskListenerConfig.action',   
	    closed:true,
	    //cache:false,
	    draggable:false,
	    collapsible:false,
	    minimizable:false,
	    maximizable:false,
	    modal:true,
	    shadow:true
	});
	_task_fields_dg = jq('#task-Fields-list').datagrid({
		//title:"Listener",
		//url:'${ctx}/wf/procdef/procdef!search.action',//加载表格数据的URL
		singleSelect:true,
		width:400,
		height:200,
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
	    fitColumns:true,
	    toolbar:[{
	        text:'New',
	        iconCls:'icon-add',
	        handler:function(){
		    	if(fieldsEditCount>0){
						jq.messager.alert("error","有可编辑的单元格，不能添加",'error');
					return;
				}
				jq('#task-Fields-list').datagrid('appendRow',{
					id:'',
					fieldName:'',
					type:'',
					value:'',
					action:''
				});
				var index = jq('#task-Fields-list').datagrid('getRows').length-1;
				jq('#task-Fields-list').datagrid('beginEdit', index);
	        }
	    }],
		
		onDblClickRow:function(rowIndex,rowData){
			editField(rowIndex);
		},
		
		onBeforeEdit:function(index,row){
			row.editing = true;
			jq(this).datagrid('refreshRow', index);
			fieldsEditCount++;
		},
		onAfterEdit:function(index,row){
			row.editing = false;
			jq(this).datagrid('refreshRow', index);
			fieldsEditCount--;
		},
		onCancelEdit:function(index,row){
			row.editing = false;
			jq(this).datagrid('refreshRow', index);
			fieldsEditCount--;
		}
	});
	
	jq('#task-listeners-list').datagrid({
		title:"Execution Listeners",
		//url:'${ctx}/wf/procdef/procdef!search.action',//加载表格数据的URL
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
	    		_listener_win.window('refresh','${ctx}/wf/procdef/procdef!forExecutionListenerConfigPage.action');
	    		//alert(_listener_frame.document.body.innerHTML);
	        }
	    }]
	});
	
	populateTaskProperites();
	//switchTaskCandidatesList(jq('#performerType').combobox('getValue'));
});
	function cancelField(id){
	_task_fields_dg.datagrid('cancelEdit', id);
	}
	function editField(id){
		_task_fields_dg.datagrid('beginEdit', id);
	}
	function saveField(id){
		//alert(id);
		_task_fields_dg.datagrid('endEdit', id);
	}
	function deleteField(id){
		_task_fields_dg.datagrid('deleteRow',id);
		refreshAllFields();
	}
	function refreshAllFields(){
		var rs = _task_fields_dg.datagrid('getRows');
		for(var i=0;i<rs.length;i++){
			var ri =_task_fields_dg.datagrid('getRowIndex',rs[i]);
			_task_fields_dg.datagrid('refreshRow',ri);
		}
	}
	function fieldsActionFormatter(value,rowData,rowIndex){
	var id = rowIndex;
	var s='<img onclick="saveField('+id+')" src="../../image/ok.png" title="'+"确定"+'" style="cursor:hand;"/>';
	var c='<img onclick="cancelField('+id+')" src="../../image/cancel.png" title="'+"取消"+'" style="cursor:hand;"/>';
	var e='<img onclick="editField('+id+')" src="../../image/modify.png" title="'+"修改"+'" style="cursor:hand;"/>';
	var d='<img onclick="deleteField('+id+')" src="../../image/delete.gif" title="'+"删除"+'" style="cursor:hand;"/>';
	if(rowData.editing)
		return s;
	else
		return e+'&nbsp;'+d;
	}
function getFieldsGridChangeRows(){
	if(fieldsEditCount>0){
		jq.messager.alert("error","请先保存可编辑表格！",'error');
		return null;
	}
    var insertRows = _task_fields_dg.datagrid('getChanges','inserted');   
    var updateRows = _task_fields_dg.datagrid('getChanges','updated');   
    var deleteRows = _task_fields_dg.datagrid('getChanges','deleted');   
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
function saveTaskFields(){
		var changesRows = getFieldsGridChangeRows();
    if(changesRows == null)return false;
    var insertRows = changesRows['inserted'];   
    var updateRows = changesRows['updated'];   
    var deleteRows = changesRows['deleted'];
    if (insertRows.length>0) {   
        for (var i=0;i<insertRows.length;i++) {   
        	var field = new draw2d.Task.Listener.Field();
    		field.name=insertRows[i].fieldName;
    		field.value=insertRows[i].value;
    		field.type=insertRows[i].type;
    		task.fields.add(field);
        }   
    }   

    if (updateRows.length>0) {   
        for (var k=0;k<updateRows.length;k++) {   
        	var field = task.getField(updateRows[k].id);
    		field.name=updateRows[k].fieldName;
    		field.value=updateRows[k].value;
    		field.type=updateRows[k].type;
        }   
    }   
       
    if (deleteRows.length>0) {   
        for (var j=0;j<deleteRows.length;j++) {   
        	task.deleteField(deleteRows[j].id);
        }   
    }
    return true;
}
function listenerActionBt(value,rowData,rowIndex){
	var id = rowData.id;
	var e = '<img onclick="editListener(\''+id+'\')" src="../../image/edit.gif" title="'+"修改"+'" style="cursor:hand;"/>';   
    var d = '<img onclick="deleteListener(\''+id+'\')" src="../../image/delete.gif" title="'+"删除"+'" style="cursor:hand;"/>';
	return e+'&nbsp;'+d;
}
function editListener(id){
	executionListenerId=id;
	_listener_win.window('open');
	_listener_win.window('refresh','${ctx}/wf/procdef/procdef!forExecutionListenerConfigPage.action');
}
function deleteListener(id){
	task.deleteListener(id);
	executionListenerId=null;
	loadTaskListeners();
}
function saveTaskProperties(){
	//alert(tid);
	saveTaskGeneral();
	if(typeof saveTaskMultiInstance == 'function')
		saveTaskMultiInstance();
	var r = saveTaskMainConfig();
	if(r)
		jq.messager.alert('Info','Save Successfully!','info');
}
function saveTaskMainConfig(){
	if(jq('#javaClassType').attr('checked')){
		task._type=jq('#javaClassType').val();
		task._javaClass=jq('#serviceClass').val();
	}else if(jq('#expressionType').attr('checked')){
		task._type=jq('#expressionType').val();
		task._expression=jq('#_expression').val();
	}else if(jq('#delegateExpressionType').attr('checked')){
		task._type=jq('#delegateExpressionType').val();
		task.delegateExpression=jq('#delegateExpression').val();
	}
	task.resultVariable=jq('#resultVariable').val();
	task.documentation=jq('#documentation').val();
	return saveTaskFields();
}
function populateTaskProperites(){
	loadTaskMainConfig();
	loadTaskListeners();
}
function loadTaskMainConfig(){
	controlTaskTypeDisplay(task._type);
	if(task._type=='javaClass'){
			jq('#serviceClass').val(task._javaClass);
	}else if(task._type=='expression'){
			jq('#_expression').val(task._expression);
	}else if(task._type=='delegateExpression'){
			jq('#delegateExpression').val(task.delegateExpression);
	}
	jq('#resultVariable').val(task.resultVariable);
	loadTaskFields();
	jq('#documentation').val(task.documentation);
}
function loadTaskFields(){
	var fields = task.fields;
	var fields_grid_rows=[];
	for(var i=0;i<fields.getSize();i++){
		var field = fields.get(i);
		var nfield = {
					id:field.id,
					fieldName:field.name,
					type:field.type,
					value:field.value,
					action:''
				};
		fields_grid_rows[i]=nfield;
	};
	var field_grid_data={
			total:fields.getSize(),
			rows:fields_grid_rows
	};
	jq('#task-Fields-list').datagrid('loadData',field_grid_data);
}
function loadTaskListeners(){
	var listeners = task.listeners;
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
	jq('#task-listeners-list').datagrid('loadData',listener_grid_data);
}
function selectServiceTaskType(obj){
	if(obj.checked){
		controlTaskTypeDisplay(obj.value)
	}
}
function controlTaskTypeDisplay(t){
		if(t=='javaClass'){
			jq('#serviceClassTr').show();
			jq('#expressionTr').hide();
			jq('#delegateExpressionTr').hide();
		}else if(t=='expression'){
			jq('#serviceClassTr').hide();
			jq('#expressionTr').show();
			jq('#delegateExpressionTr').hide();
		}else if(t=='delegateExpression'){
			jq('#serviceClassTr').hide();
			jq('#expressionTr').hide();
			jq('#delegateExpressionTr').show();
		}
}
//-->
</script>
<div id="task-properties-layout" class="easyui-layout" fit="true">
	<div id="task-properties-toolbar-panel" region="north" border="false" style="height:30px;background:#E1F0F2;">
		<a href="##" id="sb2" class="easyui-linkbutton" plain="true" iconCls="icon-save" onclick="saveTaskProperties()">Save</a>
	</div>
	<div id="task-properties-panel" region="center" border="true">
		<div id="task-properties-accordion" class="easyui-accordion" fit="true" border="false">
			<div id="general" title="General" selected="true" class="properties-menu">
				
			</div>
			<div id="mainConfig" title="Main Config" class="properties-menu">
				<table id="main-properties">
					<tr>
						<td align="right">Type:</td>
						<td>
							<input type="radio" id="javaClassType" name="_type" value="javaClass"  onclick="selectServiceTaskType(this)" checked/>Java Class
							<input type="radio" id="expressionType" name="_type" value="expression" onclick="selectServiceTaskType(this)"/>Expression
							<input type="radio" id="delegateExpressionType" name="_type" value="delegateExpression" onclick="selectServiceTaskType(this)"/>Delegate Expression
						</td>
					</tr>
					<tr id="serviceClassTr">
						<td align="right">Service Class:</td>
						<td>
							<input type="text" id="serviceClass" name="serviceClass" value="" size="50"/>
						</td>
					</tr>
					<tr id="expressionTr" style="display:none;">
						<td align="right">Expression:</td>
						<td>
							<input type="text" id="_expression" name="_expression" value="" size="50"/>
						</td>
					</tr>
					<tr id="delegateExpressionTr" style="display:none;">
						<td align="right">Delegate Expression:</td>
						<td>
							<input type="text" id="delegateExpression" name="delegateExpression" value="" size="50"/>
						</td>
					</tr>
					<tr>
						<td align="right">Result Variable:</td>
						<td>
							<input type="text" id="resultVariable" name="resultVariable" value="" size="50"/>
						</td>
					</tr>
					<tr>
						<td align="right">Fields:</td>
						<td>
							<div id="task-Fields-panel">
								<table id="task-Fields-list">
									<thead>
									<tr>
									<th field="id" hidden="true"></th>
									<th field="fieldName" width="100" align="middle" sortable="false" editor="{
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
									<th field="value" width="150" align="middle" sortable="false" editor="{
										type:'validatebox',
										options:{
										validType:'length[1,100]'
									}}">Value</th>
									<th field="action" width="80" align="middle" formatter="fieldsActionFormatter">Action</th>
									</tr>
									</thead>
								</table>
							</div>
						</td>
					</tr>
					<tr>
						<td align="right">Documentation:</td>
						<td><textarea id="documentation" name="documentation" cols="50" rows="5"></textarea></td>
					</tr>
				</table>
			</div>
			<div id="listeners" title="Listeners" style="padding:5px;">
				<table id="task-listeners-list">
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
			<div id="multi-instance" title="Multi Instance" class="properties-menu">
				
			</div>
		</div>
	</div>
</div>