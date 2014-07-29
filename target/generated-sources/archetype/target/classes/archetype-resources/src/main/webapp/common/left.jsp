#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ page import="org.springside.modules.security.springsecurity.SpringSecurityUtils" %>
<%@ include file="/common/taglibs.jsp" %>
	<div id="menu">
		<ul>
			<li><a href="${symbol_dollar}{ctx}/account/user-ajax.action">帐号列表</a></li>
			<li><a href="${symbol_dollar}{ctx}/account/role.action">角色列表</a></li>
			<li><a href="${symbol_dollar}{ctx}/j_spring_security_logout">退出登录</a></li>
		</ul>
	</div>
