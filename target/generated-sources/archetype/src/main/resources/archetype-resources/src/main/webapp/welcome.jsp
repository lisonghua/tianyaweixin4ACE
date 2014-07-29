#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
<%--
<% response.sendRedirect("account/user.action"); %>
<% response.sendRedirect("account/user-ajax.action"); %>

<% response.sendRedirect("login/forword!forwardLoginPage.action"); %>
--%>
<%
response.sendRedirect("login/forword!forwardFirstPage.action"); 
%>