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
	
	    String name="123";
		out.print(x);
		storeData("Software");
		storeData("Hardware1");
		storeData("Programming");
		
	%>
	
	<p><%out.print(name); %></p>
</body>
</html>

	<%!boolean x = false;
int counter=0;
	boolean storeData(String category) {
		try {
			Scanner reader = new Scanner(new File(category+".txt"));
			while (reader.hasNext()) {
	
				updateDataStore(reader.nextLine(), new Text(reader.nextLine()), category ); 
			}
		} catch (Exception e) {
			System.out.print("error whilst reading data1.txt");
		}
		return true;
	}

	boolean updateDataStore(String title, Text def, String category ) {
		 DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		 Key definitionsKey = KeyFactory.createKey("definitions", "mykey");
		 Date date = new Date();
		 Entity definition = new Entity("Definitions", definitionsKey);
		  
		 definition.setProperty("category", category);
		    definition.setProperty("title", title);
		 definition.setProperty("definition", def);
		 definition.setProperty("id", counter);
		 counter++;
		    datastore.put(definition);
		return false;
	}
	

	Text printDefinitions() {
		Text toReturn = new Text("");
		 DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		 Key definitionsKey = KeyFactory.createKey("definitions", "mykey");
		  Query query = new Query("Definitions", definitionsKey);
		    List<Entity> greetings = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(100));
		    if (greetings.isEmpty()) {
		    return new Text("No items found");
		    }

		    
		return toReturn;
	}
	
	
	%>