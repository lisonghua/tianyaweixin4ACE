#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<script type="text/javascript">
<!--
//tid = "<%=request.getParameter("taskId")%>";
//task = workflow.getFigure(tid);

jq(function(){
	jq('${symbol_pound}task-properties-accordion').accordion({
		onSelect:function(title,index){
				if(title=='General'){
					var pp = jq('${symbol_pound}task-properties-accordion').accordion('getSelected');
					if (pp){
    				pp.panel('refresh','${symbol_dollar}{ctx}/wf/procdef/procdef!forTaskGeneralPage.action');
					}
				}else if(title=='Multi Instance'){
					var pp = jq('${symbol_pound}task-properties-accordion').accordion('getSelected');
					if (pp){
    				pp.panel('refresh','${symbol_dollar}{ctx}/wf/procdef/procdef!forTaskMultiInstancePage.action');
					}
				}
			}
		});
	jq('${symbol_pound}performerType').combobox({
			editable:false,
			onChange:function(newValue, oldValue){
				switchTaskCandidatesList(newValue);
			}
		});
	_form_win = jq('${symbol_pound}form-win').window({
		//href:'${symbol_dollar}{ctx}/wf/procdef/procdef!forTaskListenerConfig.action',   
	    closed:true,
	    //cache:false,
	    draggable:true,
	    collapsible:false,
	    minimizable:false,
	    maximizable:false,
	    modal:true,
	    shadow:true
	});
	_listener_win = jq('${symbol_pound}listener-win').window({
		//href:'${symbol_dollar}{ctx}/wf/procdef/procdef!forTaskListenerConfig.action',   
	    closed:true,
	    //cache:false,
	    draggable:true,
	    collapsible:false,
	    minimizable:false,
	    maximizable:false,
	    modal:true,
	    shadow:true
	});
	jq('${symbol_pound}task-listeners-list').datagrid({
		title:"Task Listeners",
		//url:'${symbol_dollar}{ctx}/wf/procdef/procdef!search.action',//加载表格数据的URL
		singleSelect:true,
		//width:500,
		height:200,
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
	    		listenerId=null;
	    		_listener_win.window('refresh','${symbol_dollar}{ctx}/wf/procdef/procdef!forTaskListenerConfigPage.action');
	    		//alert(_listener_frame.document.body.innerHTML);
	        }
	    }]
	});
	jq('${symbol_pound}execution-listeners-list').datagrid({
		title:"Execution Listeners",
		//url:'${symbol_dollar}{ctx}/wf/procdef/procdef!search.action',//加载表格数据的URL
		singleSelect:true,
		//width:500,
		height:200,
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
	    		_listener_win.window('refresh','${symbol_dollar}{ctx}/wf/procdef/procdef!forExecutionListenerConfigPage.action');
	    		//alert(_listener_frame.document.body.innerHTML);
	        }
	    }]
	});
	jq('${symbol_pound}task-form-properties-list').datagrid({
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
	    toolbar:[{
	        text:'New',
	        iconCls:'icon-add',
	        handler:function(){
	        	_form_win.window('open');
	        	formPropertyId=null;
	    		_form_win.window('refresh','${symbol_dollar}{ctx}/wf/procdef/procdef!forTaskFormConfigPage.action');
	        }
	    }]
	});
	task_candidate_panel=jq('${symbol_pound}task-candidate-panel').panel({
		border:false,
		//minimized:true,
		height:200,
		width:350
		//fit:true
	});
	populateTaskProperites();
	//switchTaskCandidatesList(jq('${symbol_pound}performerType').combobox('getValue'));
});
function switchIsExpression(obj){
	if(obj.value=='true'){
		jq('${symbol_pound}expressionTr').show();
		task_candidate_panel.panel("close");
	}else if(obj.value=='false'){
		jq('${symbol_pound}expressionTr').hide();
		var performerType=jq('${symbol_pound}performerType').combobox('getValue');
		if(performerType == 'candidateUsers'){
			task_candidate_panel.panel("close");
			task_candidate_panel.panel("open");
			task_candidate_panel.panel("refresh","procdef!forCandidateUsersConfigPage.action");
		}else if(performerType == 'candidateGroups'){
			task_candidate_panel.panel("close");
			task_candidate_panel.panel("open");
			task_candidate_panel.panel("refresh","procdef!forCandidateGroupsConfigPage.action");
		}
	}
}
function switchTaskCandidatesList(performerType){
	if(jq('${symbol_pound}nonExpression').attr('checked')){
		if(performerType == 'candidateUsers'){
			task_candidate_panel.panel("close");
			task_candidate_panel.panel("open");
			task_candidate_panel.panel("refresh","procdef!forCandidateUsersConfigPage.action");
		}else if(performerType == 'candidateGroups'){
			task_candidate_panel.panel("close");
			task_candidate_panel.panel("open");
			task_candidate_panel.panel("refresh","procdef!forCandidateGroupsConfigPage.action");
		}
	}
}
function executionListenerActionBt(value,rowData,rowIndex){
	var id = rowData.id;
	var e = '<img onclick="editListener(${symbol_escape}''+id+'${symbol_escape}')" src="../../image/edit.gif" title="'+"修改"+'" style="cursor:hand;"/>';   
    var d = '<img onclick="deleteListener(${symbol_escape}''+id+'${symbol_escape}')" src="../../image/delete.gif" title="'+"删除"+'" style="cursor:hand;"/>';
	return e+'&nbsp;'+d;
}
function taskListenerActionBt(value,rowData,rowIndex){
	var id = rowData.id;
	var e = '<img onclick="editTaskListener(${symbol_escape}''+id+'${symbol_escape}')" src="../../image/edit.gif" title="'+"修改"+'" style="cursor:hand;"/>';   
    var d = '<img onclick="deleteTaskListener(${symbol_escape}''+id+'${symbol_escape}')" src="../../image/delete.gif" title="'+"删除"+'" style="cursor:hand;"/>';
	return e+'&nbsp;'+d;
}
function editListener(id){
	executionListenerId=id;
	_listener_win.window('open');
	_listener_win.window('refresh','procdef!forExecutionListenerConfigPage.action?listenerId='+id);
}
function deleteListener(id){
	task.deleteListener(id);
	executionListenerId=null;
	loadTaskListeners();
}
function editTaskListener(id){
	listenerId=id;
	_listener_win.window('open');
	_listener_win.window('refresh','procdef!forTaskListenerConfigPage.action?listenerId='+id);
}
function deleteTaskListener(id){
	task.deleteTaskListener(id);
	listenerId=null;
	loadTaskListeners();
}
function formActionBt(value,rowData,rowIndex){
	var id = rowData.id;
	var e = '<img onclick="editForm('+id+')" src="../../image/edit.gif" title="'+"修改"+'" style="cursor:hand;"/>';   
    var d = '<img onclick="deleteForm('+id+')" src="../../image/delete.gif" title="'+"删除"+'" style="cursor:hand;"/>';
	return e+'&nbsp;'+d;
}
function editForm(id){
	formPropertyId=id;
	_form_win.window('open');
	_form_win.window('refresh','${symbol_dollar}{ctx}/wf/procdef/procdef!forTaskFormConfigPage.action');
}
function deleteForm(id){
	task.deleteFormProperties(id);
	formPropertyId=null;
	loadTaskFormProperties();
}
function saveTaskProperties(){
	saveTaskGeneral();
	if(typeof saveTaskMultiInstance == 'function')
		saveTaskMultiInstance();
	task.performerType=jq('${symbol_pound}performerType').combobox('getValue');
	task.expression=jq('${symbol_pound}expression').val();
	if(jq('${symbol_pound}isExpression').attr('checked')){
		task.isUseExpression=jq('${symbol_pound}isExpression').val();
	}else if(jq('${symbol_pound}nonExpression').attr('checked')){
		task.isUseExpression=jq('${symbol_pound}nonExpression').val();
	}
	task.formKey=jq('${symbol_pound}formKey').val();
	task.dueDate=jq('${symbol_pound}dueDate').val();
	task.priority=jq('${symbol_pound}priority').val();
	task.documentation=jq('${symbol_pound}documentation').val();
	jq.messager.alert('Info','Save Successfully!','info');
}
function populateTaskProperites(){
	//jq('${symbol_pound}id').val(task.taskId);
	//jq('${symbol_pound}name').val(task.taskName);
	//alert(task.isUseExpression);
	jq('${symbol_pound}performerType').combobox('select',task.performerType);
	//alert(task.isUseExpression);
	if(task.isUseExpression=='true'){
		jq('${symbol_pound}isExpression').attr('checked','checked')
		jq('${symbol_pound}expressionTr').show();
		jq('${symbol_pound}expression').val(task.expression);
	}else{
		jq('${symbol_pound}nonExpression').attr('checked','checked');
		jq('${symbol_pound}expressionTr').hide();
	}
	switchTaskCandidatesList(task.performerType);
	jq('${symbol_pound}formKey').val(task.formKey);
	jq('${symbol_pound}dueDate').val(task.dueDate);
	jq('${symbol_pound}priority').val(task.priority);
	jq('${symbol_pound}documentation').val(task.documentation);
	loadTaskListeners();
	loadTaskFormProperties();
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
	jq('${symbol_pound}execution-listeners-list').datagrid('loadData',listener_grid_data);
	
	var taskListeners = task.taskListeners;
	var task_listener_grid_rows=[];
	//alert(listeners.getSize());
	for(var i=0;i<taskListeners.getSize();i++){
		var listener = taskListeners.get(i);
		var nlistener = {
					id:listener.getId(),
					listenerImplimentation:listener.getServiceImplementation(),
					type:listener.serviceType,
					event:listener.event,
					fields:listener.getFieldsString(),
					action:''
				};
		task_listener_grid_rows[i]=nlistener;
	};
	//alert(listener_grid_rows);
	var task_listener_grid_data={
			total:taskListeners.getSize(),
			rows:task_listener_grid_rows
	};
	jq('${symbol_pound}task-listeners-list').datagrid('loadData',task_listener_grid_data);
}
function loadTaskFormProperties(){
	var props = task.formProperties;
	var prop_grid_rows=[];
	//alert(props.getSize());
	for(var i=0;i<props.getSize();i++){
		var prop = props.get(i);
		var nprop = {
					id:prop.id,
					name:prop.name,
					type:prop.type,
					expression:prop.expression,
					variable:prop.variable,
					defaultValue:prop.defaultValue,
					datePattern:prop.datePattern,
					readable:prop.readable,
					writeable:prop.writeable,
					required:prop.required,
					formValues:prop.getValuesString(),
					action:''
				};
		prop_grid_rows[i]=nprop;
	};
	//alert(listener_grid_rows);
	var prop_grid_data={
			total:props.getSize(),
			rows:prop_grid_rows
	};
	jq('${symbol_pound}task-form-properties-list').datagrid('loadData',prop_grid_data);
}
//-->
</script>
<div id="task-properties-layout" class="easyui-layout" fit="true">
	<div id="task-properties-toolbar-panel" region="north" border="false" style="height:30px;background:${symbol_pound}E1F0F2;">
		<a href="${symbol_pound}${symbol_pound}" id="sb2" class="easyui-linkbutton" plain="true" iconCls="icon-save" onclick="saveTaskProperties()">Save</a>
	</div>
	<div id="task-properties-panel" region="center" border="true">
		<div id="task-properties-accordion" class="easyui-accordion" fit="true" border="false">
			<div id="general" title="General" selected="true" class="properties-menu">
				
			</div>
			<div id="main-config" title="Main Config">
				<table id="main-properties">
					<tr>
						<td align="right">Performer Type:</td>
						<td width="80%">
							<select id="performerType" name="performerType">
<!--								<option value="assignee">Assignee</option>-->
								<option value="">请选择</option>
								<option value="candidateUsers">Candidate Users</option>
								<option value="candidateGroups">Candidate Groups</option>
							</select>
						</td>
					</tr>
					<tr>
						<td align="right">Use Expression:</td>
						<td>
							<input type="radio" id="isExpression" name="useExpression" value="true" onclick="switchIsExpression(this)"/>Yes
							<input type="radio" id="nonExpression" name="useExpression" value="false" onclick="switchIsExpression(this)" checked/>No
						</td>
					</tr>
					<tr id="expressionTr" style="display:none;">
						<td align="right">Expression:</td>
						<td>
							<input type="text" id="expression" name="expression" size="50"/>
						</td>
					</tr>
					<tr>
						<td align="right">Form Key:</td>
						<td><input type="text" id="formKey" name="formKey" value=""/></td>
					</tr>
					<tr>
						<td align="right">Due Date:</td>
						<td><input type="text" id="dueDate" name="dueDate" value=""/></td>
					</tr>
					<tr>
						<td align="right">Priority:</td>
						<td><input type="text" id="priority" name="priority" value=""/></td>
					</tr>
					<tr>
						<td align="right">Documentation:</td>
						<td><textarea id="documentation" name="documentation" cols="20" rows="5"></textarea></td>
					</tr>
					<tr>
						<td></td>
						<td>
							<div id="task-candidate-panel">
							</div>
						</td>
					</tr>
				</table>
			</div>
			<div id="formProperties" title="Form Properties" style="overflow: hidden;">
				<table id="task-form-properties-list">
					<thead>
					<tr>
					<th field="id" width="100" align="middle" sortable="false">Id</th>
					<th field="name" width="100" align="middle" sortable="false">Name</th>
					<th field="type" width="100" align="middle" sortable="false">Type</th>
					<th field="expression" width="100" align="middle" sortable="false">Expression</th>
					<th field="variable" width="100" align="middle" sortable="false">Variable</th>
					<th field="defaultValue" width="100" align="middle" sortable="false">Default</th>
					<th field="datePattern" width="100" align="middle" sortable="false">Date Pattern</th>
					<th field="readable" width="100" align="middle" sortable="false">Readable</th>
					<th field="writeable" width="100" align="middle" sortable="false">Writeable</th>
					<th field="required" width="100" align="middle" sortable="false">Required</th>
					<th field="formValues" width="100" align="middle" sortable="false">Form Values</th>
					<th field="action" width="100" align="middle" formatter="formActionBt">Action</th>
					</tr>
					</thead>
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
					<th field="action" width="100" align="middle" formatter="taskListenerActionBt">Action</th>
					</tr>
					</thead>
				</table>
				<br/>
				<table id="execution-listeners-list">
					<thead>
					<tr>
					<th field="listenerImplimentation" width="200" align="middle" sortable="false">Listener Implimentation</th>
					<th field="type" width="70" align="middle" sortable="false">Type</th>
					<th field="event" width="70" align="middle" sortable="false">Event</th>
					<th field="fields" width="100" align="middle" >Fields</th>
					<th field="action" width="100" align="middle" formatter="executionListenerActionBt">Action</th>
					</tr>
					</thead>
				</table>
			</div>
			<div id="multi-instance" title="Multi Instance" class="properties-menu">
				
			</div>
		</div>
	</div>
</div>