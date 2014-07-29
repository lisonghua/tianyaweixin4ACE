#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<script type="text/javascript">
<!--
jq(function(){
		loadTaskMultiInstance();
});
function saveTaskMultiInstance(){
	if(jq('${symbol_pound}sequentialYes').attr('checked')){
		task.isSequential=true;
	}
	if(jq('${symbol_pound}sequentialNo').attr('checked')){
		task.isSequential=false;
	}
	task._loopCardinality=jq("${symbol_pound}loopCardinality").val();
	task._collection=jq("${symbol_pound}collection").val();
	task._elementVariable=jq("${symbol_pound}elementVariable").val();
	task._completionCondition=jq("${symbol_pound}completionCondition").val();
}
function loadTaskMultiInstance(){
	//alert(task.isSequential);
	if(task.isSequential){
		jq('${symbol_pound}sequentialYes').attr('checked',true);
	}else{
		jq('${symbol_pound}sequentialNo').attr('checked',true);
	}
	
	jq("${symbol_pound}loopCardinality").val(task._loopCardinality);
	jq("${symbol_pound}collection").val(task._collection);
	jq("${symbol_pound}elementVariable").val(task._elementVariable);
	jq("${symbol_pound}completionCondition").val(task._completionCondition);
}
//-->
</script>
<table>
	<tr>
			<td align="right">Sequential:</td>
			<td>
				<input type="radio" id="sequentialYes" name="sequential"  value="true"/>Yes
				<input type="radio" id="sequentialNo" name="sequential"  value="false" checked/>No
			</td>
	</tr>
	<tr>
			<td align="right">Loop Cardinality:</td>
			<td>
				<input type="text" id="loopCardinality" name="loopCardinality"  value="" size="50"/>
			</td>
	</tr>
	<tr>
			<td align="right">Collection:</td>
			<td>
				<input type="text" id="collection" name="collection"  value="" size="50"/>
			</td>
	</tr>
	<tr>
			<td align="right">Element Variable:</td>
			<td>
				<input type="text" id="elementVariable" name="elementVariable"  value="" size="50"/>
			</td>
	</tr>
	<tr>
			<td align="right">Completion Condition:</td>
			<td>
				<input type="text" id="completionCondition" name="completionCondition"  value="" size="50"/>
			</td>
	</tr>
</table>