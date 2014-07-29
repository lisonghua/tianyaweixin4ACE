<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<script type="text/javascript">
<!--
//var tid = "";
//var listenerId="";
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
	saveTaskGeneral();
	saveTaskMainConfig();
	if(typeof saveTaskMultiInstance == 'function')
		saveTaskMultiInstance();
	jq.messager.alert('Info','Save Successfully!','info');
}
function saveTaskMainConfig(){
	task.to=jq('#to').val();
	task.from=jq('#from').val();
	task.subject=jq('#subject').val();
	task.cc=jq('#cc').val();
	task.bcc=jq('#bcc').val();
	task._charset=jq('#charset').val();
	task._text=jq('#nonhtmlText').val();
	task._html=jq('#htmlText').val();
}
function populateTaskProperites(){
	loadTaskMainConfig();
	loadTaskListeners();
}
function loadTaskMainConfig(){
	jq('#to').val(task.to);
	jq('#from').val(task.from);
	jq('#subject').val(task.subject);
	jq('#cc').val(task.cc);
	jq('#bcc').val(task.bcc);
	jq('#charset').val(task._charset);
	jq('#nonhtmlText').val(task._text);
	jq('#htmlText').val(task._html);
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
						<td align="right">To:</td>
						<td>
							<input type="text" id="to" name="to" size="50"/>
						</td>
					</tr>
					<tr>
						<td align="right">From:</td>
						<td>
							<input type="text" id="from" name="from" size="50"/>
						</td>
					</tr>
					<tr>
						<td align="right">Subject:</td>
						<td>
							<input type="text" id="subject" name="subject" size="50"/>
						</td>
					</tr>
					<tr>
						<td align="right">Cc:</td>
						<td>
							<input type="text" id="cc" name="cc" size="50"/>
						</td>
					</tr>
					<tr>
						<td align="right">Bcc:</td>
						<td>
							<input type="text" id="bcc" name="bcc" size="50"/>
						</td>
					</tr>
					<tr>
						<td align="right">Charset:</td>
						<td>
							<input type="text" id="charset" name="charset" size="50"/>
						</td>
					</tr>
					<tr>
						<td align="right">Html Text:</td>
						<td>
							<textarea id="htmlText" name="htmlText" cols="40" rows="5"></textarea>
						</td>
					</tr>
					<tr>
						<td align="right">Non-Html Text:</td>
						<td>
							<textarea id="nonhtmlText" name="nonhtmlText" cols="40" rows="5"></textarea>
						</td>
					</tr>
				</table>
			</div>
			<div id="listeners" title="Listeners" style="overflow: hidden;padding:5px;">
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