#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML ${version} Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title></title>
	<%@ include file="/common/header.jsp" %>
</head>
<script type="text/javascript">
<!--
${symbol_dollar}(function(){
	_list_panel_obj=${symbol_dollar}('${symbol_pound}_list_panel').panel({
			//height:600,
			border:false,
			noheader:true,
			top:0,
			left:0
		});
	_list_grid_obj=${symbol_dollar}('${symbol_pound}_list_table').datagrid({
		title:"<s:text name='lable.wf.process.instance.table.title'></s:text>",
		url:'${symbol_dollar}{ctx}/wf/procinst/procinst!search.action?procdefId=${symbol_dollar}{id}',//加载表格数据的URL
		singleSelect:true,
		height:500,
		idField:'id',
		pagination:true,
		pageSize:15,
		pageNumber:1,
		pageList:[10,15],
		rownumbers:true,
		sortName:'startTime',
	    sortOrder:'desc',
	    striped:true,
	    toolbar:[{
	    	text:"<s:text name='button.common.return'></s:text>",
	        iconCls:'icon-undo',
	        handler:function(){
	        	//点击添加按钮的URL
	    		window.location='${symbol_dollar}{ctx}/wf/procdef/procdef!forQuery.action';
	    		return false;
	        }
	    }]
	});
	_wf_diagram_win_obj = ${symbol_dollar}('${symbol_pound}_wf_diagram_win').window({   
	    closed:true,
	    draggable:false,
	    collapsible:false,
	    minimizable:false,
	    maximizable:false,
	    modal:true,
	    shadow:true,
	    resizable:false
	});
	_wf_hitory_win_obj = ${symbol_dollar}('${symbol_pound}_wf_hitory_win').window({   
	    closed:true,
	    draggable:false,
	    collapsible:false,
	    minimizable:false,
	    maximizable:false,
	    modal:true,
	    shadow:true,
	    resizable:false,
	    onClose:clearHistoryWin
	});
	_wf_hitory_frame_obj = ${symbol_dollar}('${symbol_pound}_wf_hitory_frame');
	var _filter_start_date=${symbol_dollar}('${symbol_pound}filter_GED_startTime').datebox({
		formatter:simpleDateFormatter,
		parser:simpleDateParser
		});
	var _filter_end_date=${symbol_dollar}('${symbol_pound}filter_LED_endTime').datebox({
		formatter:simpleDateFormatter,
		parser:simpleDateParser
		});
});
function clearHistoryWin(){
	_wf_hitory_frame_obj.attr({src:"about:blank"});
}
//点击历史按钮转向的URL
function  viewDiagram(id){
	//_wf_diagram_win_obj.window("setTitle","<s:text name='lable.wf.process.diagram.win.title'></s:text>");
	//_wf_diagram_win_obj.window('open');
	//_wf_diagram_win_obj.window('refresh','${symbol_dollar}{ctx}/wf/procinst/procinst!forDiagram.action?procdefId=${symbol_dollar}{id}&id='+id);
	window.open("${symbol_dollar}{ctx}/wf/procinst/procinst!forDiagram.action?procdefId=${symbol_dollar}{id}&id="+id,"diagram","width=1500px,height=800px,directories=0,menubar=0,resizable=0,status=0,titlebar=0,toolbar=0");
}
//点击浏览流程图按钮的URL
function  viewHistory(id){
	_wf_hitory_win_obj.window("setTitle","<s:text name='lable.wf.process.history.win.title'></s:text>");
	_wf_hitory_win_obj.window('open');
	//_wf_hitory_win_obj.window('refresh','${symbol_dollar}{ctx}/wf/procinst/procinst!forHistory.action?procdefId=${symbol_dollar}{id}&id='+id);
	_wf_hitory_frame_obj.attr({src:"${symbol_dollar}{ctx}/wf/procinst/procinst!forHistory.action?procdefId=${symbol_dollar}{id}&id="+id});
}
function killInstance(id){
	${symbol_dollar}.messager.confirm("Confirm","<s:text name='message.common.delete.confirm'></s:text>",function(flag){
		if(flag){
			${symbol_dollar}.ajax({
					url:'${symbol_dollar}{ctx}/wf/procinst/procinst!delete.action?id='+id,
					type: 'GET',
					dataType:'json',
					error:function(){
						${symbol_dollar}.messager.alert('Error',"<s:text name='message.common.delete.failure'></s:text>",'error');
					},
					success:function(data){
						if(data.success){
							_list_grid_obj.datagrid('reload',{});
							${symbol_dollar}.messager.alert('Success',data.message,'info');
						}else{
							${symbol_dollar}.messager.alert('Error',data.message,'error');
						}
					}
				}
			);
		}
	});
}
//输出每一行末尾的操作按钮
function actionFormatter(value,rowData,rowIndex){
	var id = rowData.id;
	var v = '<img onclick="viewHistory(${symbol_escape}''+id+'${symbol_escape}')" src="${symbol_dollar}{ctx}/image/zoom.png" title="'+"<s:text name='button.wf.process.history.view'></s:text>"+'" style="cursor:hand;"/>';   
    var vd = '<img onclick="viewDiagram(${symbol_escape}''+id+'${symbol_escape}')" src="${symbol_dollar}{ctx}/image/picture_go.png" title="'+"<s:text name='button.wf.process.diagram.view'></s:text>"+'" style="cursor:hand;"/>';
    var k = '<img onclick="killInstance(${symbol_escape}''+id+'${symbol_escape}')" src="${symbol_dollar}{ctx}/image/cancel.png" title="'+"<s:text name='button.wf.process.instance.cancel'></s:text>"+'" style="cursor:hand;"/>';
    return v+'&nbsp;'+vd+"&nbsp;"+k;
}
//点击查询按钮的操作函数
function searchByFilter(){
	var id=document.getElementById("filter_EQS_procInstId").value;
	var start= ${symbol_dollar}('${symbol_pound}filter_GED_startTime').datebox("getValue");
	var end=${symbol_dollar}('${symbol_pound}filter_LED_endTime').datebox("getValue");
	_list_grid_obj.datagrid('reload',{
		filter_EQS_procInstId:id,
		filter_GED_startTime:start,
		filter_LED_endTime:end
	});
}
function simpleDateFormatter(date){
	var y = date.getFullYear();
	var m = date.getMonth()+1;
	var d = date.getDate();
	return y+'-'+(m<10?'0'+m:m)+'-'+(d<10?'0'+d:d);
}
function simpleDateParser(s){
	if(s) {
		var a = s.split('-');
		var y = new Number(a[0]);
		var m = new Number(a[1]);
		var d = new Number(a[2]);
		var dd = new Date(y, m - 1, d);
		return dd;
	}else {
		return new Date();
	}
}
//-->
</script>
<body>
<div id="_list_panel" style="padding:5px;">
<!--***************************查询部分开始*************************************-->
<!--
查询操作符规则如下：
	属性比较类型：EQ(=), LIKE(like), LT(<), GT(>), LE(<=), GE(>=)
	属性数据类型：S(String.class), I(Integer.class), L(Long.class), N(Double.class), D(Date.class), B(Boolean.class)
-->
	<div id="filter">
	<table border="0">
		<tr>
			<td>Id:</td>
			<td><input type="text" id="filter_EQS_procInstId" name="filter_EQS_procInstId" value="" size="9"/></td>
			<td>Start Time:</td>
			<td><input class="easyui-datebox"  id="filter_GED_startTime" name="filter_GED_startTime" value="" size="9"/></td>
			<td>End Time:</td>
			<td><input class="easyui-datebox"  id="filter_LED_endTime" name="filter_LED_endTime" value="" size="9"/></td>
			<td><a href="${symbol_pound}" class="easyui-linkbutton" iconCls="icon-search" onclick="searchByFilter();"><s:text name='button.common.search'></s:text></a></td>
		</tr>
	</table>
	</div>
<!--***************************查询部分结束*************************************-->
<!--***************************表格部分开始*************************************-->
<div id="content">
<table id="_list_table">
	<thead>
		<tr>
			<th field="procInstId" width="100" align="middle" ><s:text name='lable.wf.process.instance.id'></s:text></th>
			<th field="procdefName" width="200" align="middle" ><s:text name='lable.wf.process.definition.name'></s:text></th>
			<th field="startTime" width="150" align="middle" sortable="true"><s:text name='lable.wf.process.instance.start.time'></s:text></th>
			<th field="endTime" width="150" align="middle" sortable="true"><s:text name='lable.wf.process.instance.end.time'></s:text></th>
			<th field="startActId" width="200" align="middle" ><s:text name='lable.wf.process.instance.start.act.id'></s:text></th>
			<th field="endActId" width="200" align="middle" ><s:text name='lable.wf.process.instance.end.act.id'></s:text></th>
			<th field="action" width="100" align="middle" formatter="actionFormatter"><s:text name='label.sm.common.action'></s:text></th>
		</tr>
	</thead>
</table>
</div>
<!--***************************表格部分结束*************************************-->
</div> 
<div id="_wf_diagram_win" href="" title="" style="width:652px;height:440px;">  
</div> 
<div id="_wf_hitory_win" href="" title="" style="width:652px;height:440px;">  
	<iframe id="_wf_hitory_frame" name="_wf_hitory_frame" frameborder="0" width="100%" height="100%" marginheight="0" marginwidth="0" scrolling="no"></iframe>
</div> 
</body>
</html>
