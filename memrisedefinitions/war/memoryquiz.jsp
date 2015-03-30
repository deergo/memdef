<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.Scanner"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.io.File"%>
<%@ page import="com.google.appengine.api.datastore.DatastoreService"%>
<%@ page
	import="com.google.appengine.api.datastore.DatastoreServiceFactory"%>
<%@ page import="com.google.appengine.api.datastore.Entity"%>
<%@ page import="com.google.appengine.api.datastore.FetchOptions"%>
<%@ page import="com.google.appengine.api.datastore.Key"%>
<%@ page import="com.google.appengine.api.datastore.KeyFactory"%>
<%@ page import="com.google.appengine.api.datastore.Query"%>
<%@ page import="com.google.appengine.api.datastore.Text"%>
<%@ page import="com.google.appengine.api.datastore.Query.Filter"%>
<%@ page
	import="com.google.appengine.api.datastore.Query.FilterPredicate"%>
<%@ page
	import="com.google.appengine.api.datastore.Query.FilterOperator"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Vector"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>


	<%
		//http://localhost:8888/_ah/admin/datastore
		String name = "ashraf1";
		String category = "software";
		List<Entity> data = getAllDefinitions();
		out.print(getList(data).getValue());
	%>

	<p>Adding elements with high indexes can create undefined "holes"
		in an array.</p>

	<button onclick="myFunction()">Try it</button>

	<p id="demo"></p>

	<script>
		var fruits = [ "Banana", "Orange", "Apple", "Mango" ];
		document.getElementById("demo").innerHTML = fruits;

		function myFunction() {
			fruits[10] = "Lemon";
			document.getElementById("demo").innerHTML = fruits[2];
		}
	</script>

</body>
</html>

<%!List<Entity> getAllDefinitions() {
		Text toReturn = new Text("");
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		Key definitionsKey = KeyFactory.createKey("definitions", "mykey");
		Query query = new Query("Definitions", definitionsKey);
		List<Entity> greetings = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(500));
		return greetings;
	}//end getDefinitions

	Text getList(List<Entity> d) {
		Text toReturn = new Text("");
		for (Entity r : d) {
			toReturn = new Text(toReturn.getValue() + r.getProperty("title") +"  "+r.getProperty("id")+":<br> " + ((Text) r.getProperty("definition")).getValue()
					+ "<br><br>");
		}
		return toReturn;
	}//end printList

	Text getQuizQuestionsArray(String category) {
		Text toReturn = new Text("");
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		Key definitionsKey = KeyFactory.createKey("definitions", "mykey");
		Filter categoryFilter = new FilterPredicate("category", FilterOperator.EQUAL, category);
		Query query = new Query("Definitions", definitionsKey).setFilter(categoryFilter);
		List<Entity> dataDefs = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(200));
		Vector v = new Vector();
		for (Entity r : dataDefs) {
			
		}
		return toReturn;

	}%>