#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script type="text/javascript">
<!--
${symbol_dollar}(function(){
	menuObj=${symbol_dollar}('${symbol_pound}menu').tree({
		url:'${symbol_dollar}{ctx}/pm/user/user!displayAccessedModulesByUser.action',
		animate:true,
		onClick:function(node){
				//alert(node.isLeaf);
				var attributes = node.attributes;
				if(attributes.isLeaf=="1"){
					if(!isExistTab(node.text)){
						//alert(attributes.path);
						var url = "${symbol_dollar}{ctx}"+attributes.path;
						//alert(url);
						addTab(node.text,url);
					}else{
						selectedTab(node.text);
					}
				}else{
					
				}
			},
		onDblClick:function(node){
				var attributes = node.attributes;
				if(attributes.isLeaf=="0"){
					${symbol_dollar}(this).tree('expand',node.target);
				}
			}
	});
});
//-->
</script>

<ul id="menu"></ul>
