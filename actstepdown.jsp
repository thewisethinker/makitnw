<%@ page import="java.sql.*" %>
<%@ page import="java.lang.Integer"%>
<%@ include file="connection.jsp" %>
<%@ include file="sessionpopup.jsp" %>
<%@ page import="java.util.*" %>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<title>Step Down...</title>
<!-- 87xVyPKwKKMf0G6FiJoULrzGt98 -->
<script type="text/javascript">
</script>

<%
String actid1 = request.getParameter("hidden32");
String tp1=request.getParameter("tp");
String owner1=request.getParameter("owner");
%>

<META HTTP-EQUIV="REFRESH" content="1;url=<%=superurl%>expandupdates.jsp?chk=1&tp=<%=tp1%>&id=<%=actid1%>&text=y&owner=<%=owner1%>">
<link rel="stylesheet" href="NW.css" type="text/css">

</head>



<body>

<%

Connection conn = null;
try
{
        Class.forName("oracle.jdbc.driver.OracleDriver");

        DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());

        conn=DriverManager.getConnection(url,user,pass);
	
	
	
	
	PreparedStatement stmt1=conn.prepareStatement("insert into actstepper(ownerid,actid,stepper,stepdown) values('"+owner1+"',?,'"+nwid1+"','d')"); 
	stmt1.setString(1,actid1);
		
	if(tp1.equals("pic")){
	String picid2 = actid1.replaceAll(".jpg","");
	PreparedStatement stmt2=conn.prepareStatement("insert into picstepper(nwid,picid,stepper,stepdown) values('"+owner1+"',?,'"+nwid1+"','d')"); 
	stmt2.setString(1,picid2);
	ResultSet rs2 = stmt2.executeQuery();
	if(rs2.next()){
		String descn3 = nwid1.replaceAll("[0-9]","").toUpperCase()+" steps down a picture of "+owner1.replaceAll("[0-9]","").toUpperCase();
		String typen3 = "picstepdown";
		Statement stmtn3 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		ResultSet rsn3 = stmtn3.executeQuery("insert into notif3(id3,doer,victim,description,type,day2) values('"+picid2+"','"+nwid1+"','"+owner1+"','"+descn3+"','"+typen3+"',sysdate)");
		out.println();
	}
	else
		out.println();	
	}
	
	
	
	ResultSet rs1 = stmt1.executeQuery();
	
	if(rs1.next()){
	
	//social points
	Statement stmtsoc12 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
    ResultSet rssoc12 = stmtsoc12.executeQuery("update socpoint set points=points-5 where nwid='"+owner1+"'");

	//social points
	Statement stmtsoc13 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
    ResultSet rssoc13 = stmtsoc13.executeQuery("update socpoint set points=points-5 where nwid='"+nwid1+"'");	  
 
	//notif3 here
	String descn3 = nwid1.replaceAll("[0-9]","").toUpperCase()+" steps down an activity of "+owner1.replaceAll("[0-9]","").toUpperCase();
	String typen3 = "actstepdown";
	Statement stmtn3 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
    ResultSet rsn3 = stmtn3.executeQuery("insert into notif3(id3,doer,victim,description,type,day2) values('"+actid1+"','"+nwid1+"','"+owner1+"','"+descn3+"','"+typen3+"',sysdate)");

		out.println("<center><h5>"+"you stepped the activity down"+"</h5></center>");
		}
	else
		out.println("<center><h5>"+"you already stepped the activity"+"</h5></center>");
		
	
	
	
	
  }
 catch(SQLException e)
  {
     out.println("<center><h5>"+"you already stepped it"+"</h5></center>");
    //out.println(e);
   }
catch(ClassNotFoundException e)
{
     out.println("<center><h5>"+"you already stepped it"+"</h5></center>");
}

finally
{
    //Clean up resources, close the connection.
     if(conn != null){
          try
          {
	conn.close();
          }
          catch (Exception ignored) {}
     }
}
%>

</body>
</html>
