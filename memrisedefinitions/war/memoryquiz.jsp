<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.Scanner"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.io.File"%>
<%@ page import="com.google.appengine.api.datastore.DatastoreService" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.Entity" %>
<%@ page import="com.google.appengine.api.datastore.FetchOptions" %>
<%@ page import="com.google.appengine.api.datastore.Key" %>
<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>
<%@ page import="com.google.appengine.api.datastore.Query" %>
<%@ page import="com.google.appengine.api.datastore.Text" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>


	<%
	//http://localhost:8888/_ah/admin/datastore
	    String name="ashraf1";
		List<Entity> data = getDefinitions();
	    out.print(getList(data).getValue());
		
	%>
	
	<p><%out.print(data.size()); %></p>
</body>
</html>

	<%!
	
	List<Entity> getDefinitions() {
		Text toReturn = new Text("");
		 DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		 Key definitionsKey = KeyFactory.createKey("definitions", "mykey");
		  Query query = new Query("Definitions", definitionsKey);
		    List<Entity> greetings = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(500));
		return greetings;
	}//end getDefinitions
	
	Text getList(List<Entity> d){
		Text toReturn = new Text("");
		for(Entity r : d) {
	       toReturn = new Text(toReturn.getValue()+r.getProperty("title")+":<br> "+((Text)r.getProperty("definition")).getValue()+"<br><br>");
	    }
		return toReturn;
	}//end printList
	
	%>