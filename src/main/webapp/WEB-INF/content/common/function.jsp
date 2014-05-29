<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
<!--
$(function(){
	funcTab=$('#functionGroup').tabs({
		fit:true
		});
});
function goHome(){
	var homeTitle = "<s:text name='label.common.homepage'></s:text>";
	if(!isExistTab(homeTitle)){
		funcTab.tabs('add',{
			title: homeTitle,
			fit:true,
			href:'${ctx}/login/forword!forwardFramePage.action?_f_url=${ctx}/login/forword!forwardHomePage.action',
			iconCls:'homepage-banner-bt-home',
			closable:false
		});
	}else{
		selectedTab(homeTitle);
	}
}
function addTab(title,path){
	funcTab.tabs('add',{
		title: title,
		fit:true,
		href:'${ctx}/login/forword!forwardFramePage.action?_f_url='+path,
		iconCls:'icon-save',
		closable:true
	});
}
function isExistTab(title){
	return funcTab.tabs('exists',title);
}
function selectedTab(title){
	funcTab.tabs('select',title);
}
function forward(path){
	//alert(path);
	var tab = funcTab.tabs('getSelected');
	funcTab.tabs('update',{
		tab: tab,
		options:{
			href:path
		}
	});
	tab.panel('refresh');
}
//-->
</script>
<div id="functionGroup">
    <div title="<s:text name='label.common.homepage'></s:text>" iconCls="homepage-banner-bt-home" closable="false" style="overflow:hidden;padding:0px;">
       <iframe frameborder="0" height="100%" marginheight="0" marginwidth="0" width="100%" src="${ctx}/login/forword!forwardHomePage.action" onload="onloadSwitchStyle()"></iframe>
    </div>
</div>
