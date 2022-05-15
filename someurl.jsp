<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.* " %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page trimDirectiveWhitespaces="true" %>
<HTML>
<center>
            <%
try{
               	String id=request.getParameter("id");
			String ben=request.getParameter("Beneficiary");
			String rel=request.getParameter("Relation");
			String asset=request.getParameter("Asset");
			String per=request.getParameter("Percent");
			String operator=request.getParameter("oper");
			
			
		
		String driver = "org.postgresql.Driver";
		String url = "jdbc:postgresql://localhost:5432/testdb";
		String username = "postgres";
		String password = "suguna";
		String myDataField = null;
		Connection myConnection = null;
		ResultSet myResultSet = null;
		PreparedStatement myPreparedStatement = null;
				
		String myQuery = "";
		if(operator.compareToIgnoreCase("add")==0)
			{
			id="26";
			String str=id+","+"'"+ben+"'"+","+"'"+rel+"'"+","+"'"+asset+"'"+","+per;
			out.println(str);
			myQuery="INSERT INTO beneficiary(id, beneficiary, relation, asset, percentage) VALUES ("+str+")";
			}
		else
		if(operator.compareToIgnoreCase("edit")==0)
		{
			int percentage=(int)(Double.parseDouble(per));
			myQuery="UPDATE beneficiary SET beneficiary = "+"'"+ben+"'"+", relation = "+"'"+rel+"'"+", asset = "+"'"+asset+"'"+", percentage = "+percentage+" WHERE id="+id; 
			out.println(myQuery);
		}	
		else
		if(operator.compareToIgnoreCase("del")==0)
		{
			myQuery="DELETE from beneficiary where id="+id;
			out.println(myQuery);
		}
		
		Class.forName(driver).newInstance();
		myConnection = DriverManager.getConnection(url,username,password);
		myPreparedStatement = myConnection.prepareStatement(myQuery);
		myResultSet = myPreparedStatement.executeQuery();
		myConnection.close();
	}
	catch(Exception e)
	{
		out.println("Exception Seen");
		out.print("SQLException: "+e.getMessage());
	}
            %>
         </table>
</H1>
</HTML>