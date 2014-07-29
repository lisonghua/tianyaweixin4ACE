#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
	<script language="javascript" type="text/javascript" src="${symbol_dollar}{ctx}/js/jqplot/plugins/jqplot.logAxisRenderer.js"></script>
	<script language="javascript" type="text/javascript" src="${symbol_dollar}{ctx}/js/jqplot/plugins/jqplot.canvasTextRenderer.js"></script>
	<script language="javascript" type="text/javascript" src="${symbol_dollar}{ctx}/js/jqplot/plugins/jqplot.canvasAxisLabelRenderer.js"></script>
	<script language="javascript" type="text/javascript" src="${symbol_dollar}{ctx}/js/jqplot/plugins/jqplot.canvasAxisTickRenderer.js"></script>
	<script language="javascript" type="text/javascript" src="${symbol_dollar}{ctx}/js/jqplot/plugins/jqplot.dateAxisRenderer.js"></script>
	<script language="javascript" type="text/javascript" src="${symbol_dollar}{ctx}/js/jqplot/plugins/jqplot.categoryAxisRenderer.js"></script>
	<script language="javascript" type="text/javascript" src="${symbol_dollar}{ctx}/js/jqplot/plugins/jqplot.barRenderer.js"></script>
<script type="text/javascript">
<!--
	var _everyday_permonth_report_data=<%=request.getAttribute("_everyday_permonth_report_data")%>;
	<%
		String applicationName = request.getParameter("application")==null?"":request.getParameter("application");
		applicationName = applicationName.replace("/","");
	%>
	var applicationName = "<%=applicationName%>";
	try{
		${symbol_dollar}.jqplot.config.enablePlugins = true;
		everyday_chart_obj=${symbol_dollar}.jqplot('chartdiv',  
				[_everyday_permonth_report_data],
				{
				title: applicationName+" <s:text name='label.sm.ds.report.everydayUserCount'></s:text>",
				//dataRenderer: ${symbol_dollar}.jqplot.ciParser,
			    series:[{renderer:${symbol_dollar}.jqplot.BarRenderer}],
			    axes: {
			      xaxis: {
					//renderer:${symbol_dollar}.jqplot.DateAxisRenderer,
					//tickInterval: '1 day',
			        renderer: ${symbol_dollar}.jqplot.CategoryAxisRenderer,
			          label: "<s:text name='label.sm.ds.report.everydayUserCount.X'></s:text>",
			        // labelRenderer: ${symbol_dollar}.jqplot.CanvasAxisLabelRenderer,
			        tickRenderer: ${symbol_dollar}.jqplot.CanvasAxisTickRenderer,
			        tickOptions: {
					  //formatString:'%Y-%m-%d',
			          enableFontSupport: true,
			          angle: -30
			        }
			        
			      },
			      yaxis: {
			        autoscale:true,
			          label: "<s:text name='label.sm.ds.report.everydayUserCount.Y'></s:text>",
			        // labelRenderer: ${symbol_dollar}.jqplot.CanvasAxisLabelRenderer,
			        tickRenderer: ${symbol_dollar}.jqplot.CanvasAxisTickRenderer,
			        tickOptions: {
			          enableFontSupport: true,
			            angle: -30
			        }
			      }
			    }
			}
		);
	}catch(e){
			alert(e.message);
	};
//-->
</script>
