#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<script type="text/javascript">
<!--
//var tid = "";
//var listenerId="";
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
	jq('${symbol_pound}task-listeners-list').datagrid({
		title:"Execution Listeners",
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
	    		_listener_win.window('refresh','${symbol_dollar}{ctx}/wf/procdef/procdef!forExecutionListenerConfigPage.action');
	    		//alert(_listener_frame.document.body.innerHTML);
	        }
	    }]
	});
	
	populateTaskProperites();
	//switchTaskCandidatesList(jq('${symbol_pound}performerType').combobox('getValue'));
});

function listenerActionBt(value,rowData,rowIndex){
	var id = rowData.id;
	var e = '<img onclick="editListener(${symbol_escape}''+id+'${symbol_escape}')" src="../../image/edit.gif" title="'+"修改"+'" style="cursor:hand;"/>';   
    var d = '<img onclick="deleteListener(${symbol_escape}''+id+'${symbol_escape}')" src="../../image/delete.gif" title="'+"删除"+'" style="cursor:hand;"/>';
	return e+'&nbsp;'+d;
}
function editListener(id){
	executionListenerId=id;
	_listener_win.window('open');
	_listener_win.window('refresh','${symbol_dollar}{ctx}/wf/procdef/procdef!forExecutionListenerConfigPage.action');
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
	task.to=jq('${symbol_pound}to').val();
	task.from=jq('${symbol_pound}from').val();
	task.subject=jq('${symbol_pound}subject').val();
	task.cc=jq('${symbol_pound}cc').val();
	task.bcc=jq('${symbol_pound}bcc').val();
	task._charset=jq('${symbol_pound}charset').val();
	task._text=jq('${symbol_pound}nonhtmlText').val();
	task._html=jq('${symbol_pound}htmlText').val();
}
function populateTaskProperites(){
	loadTaskMainConfig();
	loadTaskListeners();
}
function loadTaskMainConfig(){
	jq('${symbol_pound}to').val(task.to);
	jq('${symbol_pound}from').val(task.from);
	jq('${symbol_pound}subject').val(task.subject);
	jq('${symbol_pound}cc').val(task.cc);
	jq('${symbol_pound}bcc').val(task.bcc);
	jq('${symbol_pound}charset').val(task._charset);
	jq('${symbol_pound}nonhtmlText').val(task._text);
	jq('${symbol_pound}htmlText').val(task._html);
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
	jq('${symbol_pound}task-listeners-list').datagrid('loadData',listener_grid_data);
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