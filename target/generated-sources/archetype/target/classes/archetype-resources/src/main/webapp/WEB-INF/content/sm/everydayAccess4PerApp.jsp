#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<script type="text/javascript">
<!--
var _advanced_search_conditions="";
${symbol_dollar}(function(){
	_search_form_obj=${symbol_dollar}('${symbol_pound}_search_form');
	_search_form_obj.validate({
		rules:{
			startDate:{
				required: true
			},
			endDate:{
				required: true
			}
		},
		showErrors:showErrors
	});
	var _filter_start_date=${symbol_dollar}('${symbol_pound}startDate').datebox({
		formatter:simpleDateFormatter,
		parser:simpleDateParser
		});
	var _filter_end_date=${symbol_dollar}('${symbol_pound}endDate').datebox({
		formatter:simpleDateFormatter,
		parser:simpleDateParser
		});
	${symbol_dollar}('${symbol_pound}application').combobox({
	    url:'${symbol_dollar}{ctx}/sm/appserver/appserver!searchAllAppName.action?dsId=${symbol_dollar}{dsId}',
	    //editable:false,
	    valueField:'code',
	    textField:'value'
	});
	_advanced_search_win_obj = ${symbol_dollar}('${symbol_pound}_advanced_search_win').window({   
	    closed:true,
	    draggable:false,
	    collapsible:false,
	    minimizable:false,
	    maximizable:false,
	    modal:true,
	    shadow:true,
	    resizable:false,
	    onClose:submitConditions,
	    onBeforeClose:validateEdit
	});
	//_advanced_search_obj = document.getElementById('_advanced_search_frame');
});
function validateEdit(){
	//alert(editcount);   
	if(editcount>0){
		${symbol_dollar}.messager.alert("<s:text name='label.common.error'></s:text>","<s:text name='message.common.notAccept'></s:text>",'error');
		return false;
	}else{
		return true;
	}
}
function submitConditions(){
	var insertRows = ${symbol_dollar}('${symbol_pound}_qstring_edit_grid').datagrid('getChanges','inserted');   
    var updateRows = ${symbol_dollar}('${symbol_pound}_qstring_edit_grid').datagrid('getChanges','updated');   
    var deleteRows = ${symbol_dollar}('${symbol_pound}_qstring_edit_grid').datagrid('getChanges','deleted');   
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

    _advanced_search_conditions = JSON.stringify(changesRows);
    //alert(_advanced_search_conditions);
}
function simpleDateFormatter(date){
	var y = date.getFullYear();
	var m = date.getMonth()+1;
	var d = date.getDate();
	return y+'-'+(m<10?'0'+m:m)+'-'+(d<10?'0'+d:d);
}
function simpleDateParser(s){
	var t = Date.parse(s);
	if (!isNaN(t)) {
		var a = s.split('-');
		var y = new Number(a[0]);
		var m = new Number(a[1]);
		var d = new Number(a[2]);
		var dd = new Date(y, m - 1, d);
		return dd;
	} else {
		return new Date();
	}
}
function searchByFilter(){
	_search_form_obj.ajaxSubmit({
			url:"${symbol_dollar}{ctx}/sm/appserver/appserver!exportEverydayAccessNum4PerAppReport.action?serverId=${symbol_dollar}{serverId}",
			type: 'POST',
			dataType:'html',
			data:{_advanced_search_conditions:_advanced_search_conditions},
			beforeSubmit:function(formData, jqForm, options){
				if(_search_form_obj.valid())
					return true;
				else
					return false;
			},
			
			success:function(responseText, statusText, xhr, jqForm){
				//alert(responseText);
				//${symbol_dollar}('${symbol_pound}chartdiv').html(responseText);
				displayReport(responseText);
			}
		});
}
function goBack(){
	window.location='${symbol_dollar}{ctx}/sm/appserver/appserver!forQuery.action';
}
function displayReport(responseText){
	${symbol_dollar}('${symbol_pound}chartdiv').html(responseText);
}
function openAdvancedSearch(){
	_advanced_search_win_obj.window('open');
	//_advanced_search_obj.src='${symbol_dollar}{ctx}/sm/appserver/appserver!forAdvancedSearch.action?serverId=${symbol_dollar}{serverId}';
}
function closeAdvancedSearch(){
	_advanced_search_win_obj.window('close');
}

//-->
</script>
<form id="_search_form" method="post">
<table>
		<tr>
			<td><s:text name='label.sm.ds.application'></s:text>：</td>
			<td><input id="application" name="application" readonly="readonly"/></td>
			<td><s:text name='label.sm.ds.start.date'></s:text>:</td>
			<td><input id="startDate" name="startDate" ></input></td>
			<td>-</td>
			<td><s:text name='label.sm.ds.end.date'></s:text>:</td>
			<td><input id="endDate" name="endDate" ></input></td>
			<td><a href="${symbol_pound}${symbol_pound}" class="easyui-linkbutton" iconCls="icon-search" onclick="searchByFilter();"><s:text name='button.common.search'></s:text></a></td>
			<td><a href="${symbol_pound}${symbol_pound}" class="easyui-linkbutton" iconCls="icon-search" onclick="openAdvancedSearch();"><s:text name='button.sm.app.advanced.search'></s:text></a></td>
			<td><a href="${symbol_pound}${symbol_pound}" class="easyui-linkbutton" iconCls="icon-undo" onclick="goBack();"><s:text name='button.common.return'></s:text></a></td>
		</tr>
</table>
</form>
<div id="chartdiv" style="height:350px;width:900px; "></div>
<div id="_advanced_search_win" href="${symbol_dollar}{ctx}/sm/appserver/appserver!forAdvancedSearch.action?serverId=${symbol_dollar}{serverId}" title="<s:text name='label.sm.app.advanced.search'></s:text>" style="width:652px;height:440px;">  
    <!-- <iframe id="_advanced_search_frame" name="_advanced_search_frame" frameborder="0" width="100%" height="100%" marginheight="0" marginwidth="0" scrolling="no"></iframe> -->
</div>