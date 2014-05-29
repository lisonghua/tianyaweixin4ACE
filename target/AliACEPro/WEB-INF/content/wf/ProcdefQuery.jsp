<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title></title>
	<%@ include file="/common/header.jsp" %>
</head>
<script type="text/javascript">
<!--
$(function(){
	_list_panel_obj=$('#_list_panel').panel({
			//height:600,
			border:false,
			noheader:true,
			top:0,
			left:0
		});
	_list_grid_obj=$('#_list_table').datagrid({
		title:"<s:text name='lable.wf.process.definition.table.title'></s:text>",
		url:'${ctx}/wf/procdef/procdef!search.action',//加载表格数据的URL
		singleSelect:true,
		height:500,
		idField:'id',
		pagination:true,
		pageSize:15,
		pageNumber:1,
		pageList:[10,15],
		rownumbers:true,
		sortName:'key,version',
	    sortOrder:'asc,desc',
	    striped:true
	});
	_wf_diagram_win_obj = $('#_wf_diagram_win').window({   
	    closed:true,
	    draggable:false,
	    collapsible:false,
	    minimizable:false,
	    maximizable:false,
	    modal:true,
	    shadow:true,
	    resizable:true
	});
});

function  viewProcinst(id){
	window.location='${ctx}/wf/procdef/procdef!forInstance.action?id='+id;
}

function  viewProcDiag(id){
	//_wf_diagram_win_obj.window('open');
	//_wf_diagram_win_obj.window('refresh','${ctx}/wf/procdef/procdef!forDiagram.action?id='+id);
	window.open('${ctx}/wf/procdef/procdef!forDiagram.action?id='+id,"diagram","width=1500px,height=800px,directories=0,menubar=0,resizable=0,status=0,titlebar=0,toolbar=0");
}
//输出每一行末尾的操作按钮
function actionFormatter(value,rowData,rowIndex){
	var id = rowData.id;
	var v = '<img onclick="viewProcinst(\''+id+'\')" src="${ctx}/image/zoom.png" title="'+"<s:text name='button.wf.process.instance.view'></s:text>"+'" style="cursor:hand;"/>';   
    var vd = '<img onclick="viewProcDiag(\''+id+'\')" src="${ctx}/image/picture_go.png" title="'+"<s:text name='button.wf.process.diagram.view'></s:text>"+'" style="cursor:hand;"/>';
    return v+'&nbsp;'+vd;
}
//点击查询按钮的操作函数
function searchByFilter(){
	var name=document.getElementById("filter_EQS_name").value;
	var version=document.getElementById("filter_EQS_version").value;
	_list_grid_obj.datagrid('reload',{
		filter_EQS_name:name,
		filter_EQI_version:version
	});
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
			<td><s:text name='lable.wf.process.definition.name'></s:text>:</td>
			<td><input type="text" name="filter_EQS_name" value="" size="9"/></td>
			<td><s:text name='lable.wf.process.definition.version'></s:text>:</td>
			<td><input type="text" name="filter_EQS_version" value="" size="9"/></td>
			<td><a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="searchByFilter();"><s:text name='button.common.search'></s:text></a></td>
		</tr>
	</table>
	</div>
<!--***************************查询部分结束*************************************-->
<!--***************************表格部分开始*************************************-->
<div id="content">
<table id="_list_table">
	<thead>
		<tr>
			<th field="category" width="200" align="middle" sortable="true"><s:text name='lable.wf.process.definition.category'></s:text></th>
			<th field="name" width="200" align="middle" sortable="true"><s:text name='lable.wf.process.definition.name'></s:text></th>
			<th field="key" width="200" align="middle" sortable="true"><s:text name='lable.wf.process.definition.key'></s:text></th>
			<th field="version" width="50" align="middle" ><s:text name='lable.wf.process.definition.version'></s:text></th>
			<th field="action" width="100" align="middle" formatter="actionFormatter"><s:text name='label.sm.common.action'></s:text></th>
		</tr>
	</thead>
</table>
</div>
<!--***************************表格部分结束*************************************-->
</div>
<div id="_wf_diagram_win" href="" title="<s:text name='lable.wf.process.diagram.win.title'></s:text>" style="width:652px;height:440px;">  
    <!-- <iframe id="_advanced_search_frame" name="_advanced_search_frame" frameborder="0" width="100%" height="100%" marginheight="0" marginwidth="0" scrolling="no"></iframe> -->
</div> 
</body>
</html>
