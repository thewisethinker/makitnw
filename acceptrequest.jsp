<%@ page import="java.sql.*" %>
<%@ include file="connection.jsp"%>
<%@ include file="sessionmgt.jsp"%>
<%@ page import="java.io.*" %> 
<%@ page import="java.lang.*" %>
<%@page import ="javax.servlet.*" %>
<%@page import= "javax.servlet.jsp.*" %>
<%@ page language="java" %>
<%@ page import="java.net.*" %>

<%@ page import="java.util.*" %>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.text.SimpleDateFormat"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script language="javascript" type="text/javascript">
function submitForm(){
document.returninfo.submit();
}

</script>
<style type="text/css">
<!--
a.button{
background:url(images/button1.png);
display:block;
color:#F0F8FF;
font-weight:bold;
height:30px;
line-height:29px;
margin-bottom:14px;
text-decoration:none;
text-align:center;
width:150px;
}
a:hover.button{
color:#19D119;
}
.style2 {color: #0066FF}
.style1 {
	color: #000000;
	font-family: Georgia, "Times New Roman", Times, serif;
}
body {
	background-image: url(images/mainorange.jpg);
}
-->
</style>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"></head>
<body>
  <%
Connection conn = null;

try
{
        Class.forName("oracle.jdbc.driver.OracleDriver");

        DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());

        conn=DriverManager.getConnection(url,user,pass);
      
        Calendar currentDate = Calendar.getInstance();
        SimpleDateFormat formatter= new SimpleDateFormat("yyyyMMddHHmmss");
        String dateNow = formatter.format(currentDate.getTime());
        
	
         
        PreparedStatement stmt=conn.prepareStatement("insert into communityinfo values(?,?,?)");
        PreparedStatement stmt1=conn.prepareStatement("insert into communityinfo values(?,?,?)");
        PreparedStatement stmt2=conn.prepareStatement("delete from pendingrequest where mynwid='"+nwid1+"' and requests=?");         
        PreparedStatement stmt3=conn.prepareStatement("insert into notification values(?,?,'y',sysdate)");     
        PreparedStatement stmt4=conn.prepareStatement("insert into notification values(?,?,'y',sysdate)");     

        String nwid2=request.getParameter("hidden3");

        String typer1 = nwid1+dateNow+nwid2+"friend";
        String typer2 = nwid2+dateNow+nwid1+"friend";

        String nw1=nwid1.replaceAll("[0-9]","");

        String str1 = nwid2.replaceAll("[0-9]", ""); 
        String str2 = str1.toUpperCase()+"  is now in your community.";

        String str3 = nwid1.replaceAll("[0-9]", ""); 
        String str4 = str3.toUpperCase()+"  is now in your community.";

        stmt.setString(1,nwid2+nwid1);
        stmt.setString(2,nwid2);
        stmt.setString(3,nwid1);
        stmt1.setString(1,nwid1+nwid2);
        stmt1.setString(2,nwid1);
        stmt1.setString(3,nwid2);
        stmt2.setString(1,nwid2);
        stmt3.setString(1,nwid1);
        stmt3.setString(2,str2);
        stmt4.setString(1,nwid2);
        stmt4.setString(2,str4);
        
        Statement stmt5u = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
        ResultSet rs5u = stmt5u.executeQuery("insert into notif2(nwid,uniqid,description,time2,othernwid,activityid,type111) values('"+nwid1+"','"+typer1+"','"+str1.toUpperCase()+" can communicate with "+nw1.toUpperCase()+"',sysdate,'"+nwid2+"','"+typer1+"','"+"friend"+"')");
        Statement stmt6u = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
        ResultSet rs6u = stmt6u.executeQuery("insert into notif2(nwid,uniqid,description,time2,othernwid,activityid,type111) values('"+nwid2+"','"+typer2+"','"+str1.toUpperCase()+" can communicate with "+nw1.toUpperCase()+"',sysdate,'"+nwid1+"','"+typer2+"','"+"friend"+"')");
	
	//stmt3.setString(1,nwid3);

        ResultSet rs = stmt.executeQuery();
        ResultSet rs1=stmt1.executeQuery();   
        ResultSet rs2=stmt2.executeQuery();     
        ResultSet rs3=stmt3.executeQuery();
        ResultSet rs4=stmt4.executeQuery();
		
		//social points
	Statement stmtsoc1 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
    ResultSet rssoc1 = stmtsoc1.executeQuery("update socpoint set points=points+20 where nwid='"+nwid1+"'");	  
 
	//social points
	Statement stmtsoc2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
    ResultSet rssoc2 = stmtsoc1.executeQuery("update socpoint set points=points+20 where nwid='"+nwid2+"'");	  
 
		
        response.sendRedirect(superurl+"notifyfriendrequests.jsp");
 
    }
 catch(SQLException e)
  {
     //out.println(e); //not enough value exception exists
      response.sendRedirect(superurl+"notifyfriendrequests.jsp");
   }
catch(ClassNotFoundException e)
{
     out.println(e);
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
