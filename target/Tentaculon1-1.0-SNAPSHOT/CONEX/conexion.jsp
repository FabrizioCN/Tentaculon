<% 
   Class.forName("com.mysql.cj.jdbc.Driver");
  java.sql.Connection cn=java.sql.DriverManager.getConnection("jdbc:mysql://localhost/tentaculon","root","");
  java.sql.Statement st=cn.createStatement();

%>