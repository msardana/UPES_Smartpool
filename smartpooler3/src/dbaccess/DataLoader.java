package dbaccess;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Time;
import java.sql.Timestamp;
import java.util.AbstractSet;
import java.util.HashSet;

public class DataLoader {
	
	String URL = "jdbc:db2://awh-yp-small03.services.dal.bluemix.net:50000/BLUDB";
	String userName="dash104839";
	String password="vu10vuRgbcDH";
 //	DataLoader d = null;

	 public void loadParticipantData(String mailID, String mobileNo, String name, String Gender)
	{
		 try {
			 Class.forName("com.ibm.db2.jcc.DB2Driver");
			 
         Connection con1 = DriverManager.getConnection(URL, userName, password);
         System.out.println("connected to user database");
         
         String genchar;
         
         if(Gender.equals("female"))
         {
        	 genchar="F";
         }
         else
         {
        	 genchar="M";
         }
         
         String sql = "Insert into participant values(?,?,?,?)";
         PreparedStatement st = con1.prepareStatement(sql);
         
         st.setString(1,mailID);
         st.setString(2, mobileNo);
         st.setString(3,name);
         st.setString(4,genchar);
         
         System.out.println("SQL is "+sql); 
         st.executeUpdate();
         
         con1.close();
         
		 } catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	}
	
	
	
	public void loadRouteData1(String routeID, String mailID, String source, String destination, String vehicleNo, Double distance)
	{
		 try {
			 Class.forName("com.ibm.db2.jcc.DB2Driver");
			 
         Connection con1 = DriverManager.getConnection(URL, userName, password);
         System.out.println("connected to user database");
         
         
         String selectSQL="select routeid from route_seeder where routeid = '"+routeID +"'";
         
         Statement stmt =con1.createStatement();
         ResultSet rs =stmt.executeQuery(selectSQL);
         
         if (!rs.next())
         {
         String sql = "Insert into route_seeder values(?,?,?,?,?,?)";
         PreparedStatement st = con1.prepareStatement(sql);
         
         st.setString(1,routeID);
         st.setString(2, mailID);
         st.setString(3,source);
         st.setString(4,destination);
         st.setString(5,vehicleNo);
         st.setDouble(6,distance);
       
         
         System.out.println("SQL is "+sql); 
         st.executeUpdate();
         }
         rs.close();
         con1.close();
         
		 } catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	}
	
	 public void loadRouteActive(String routeID, Timestamp startTime, String endTime, int seats)
	{
		 try {
			 Class.forName("com.ibm.db2.jcc.DB2Driver");
			
         Connection con1 = DriverManager.getConnection(URL, userName, password);
         System.out.println("connected to user database");
         
         String selectSQL="select routeid,startTime from route_active where routeid='"+routeID +"'";
         
         Statement stmt =con1.createStatement();
         ResultSet rs =stmt.executeQuery(selectSQL);
         
         if (!rs.next())
         {	 
         String sql = "Insert into route_active values(?,?,?,?)";
         
         PreparedStatement st = con1.prepareStatement(sql);
         
         // we need to calculate the estimated end time if we want to save it in DB.
         // As of now we are inserting null
         Timestamp t2 = null;
         
         st.setString(1,routeID);
    //     st.setString(2, mailID);
         st.setTimestamp(2,startTime);
         st.setTimestamp(3,t2);
         st.setInt(4,seats);
        
         System.out.println("SQL is "+sql); 
         st.executeUpdate();
         }
         else
         {
        	 Timestamp time = rs.getTimestamp(2);
        	 if( ! startTime.equals(time))
        	 {
        		 String sql = "Insert into route_active values(?,?,?,?)";
                 
                 PreparedStatement st = con1.prepareStatement(sql);
                 
                 // we need to calculate the estimated end time if we want to save it in DB.
                 // As of now we are inserting null
                 Timestamp t2 = null;
                 
                 st.setString(1,routeID);
            //     st.setString(2, mailID);
                 st.setTimestamp(2,startTime);
                 st.setTimestamp(3,t2);
                 st.setInt(4,seats);
                
                 System.out.println("SQL is "+sql); 
                 st.executeUpdate();
        		 
        	 }
         }
         
         rs.close();
         con1.close();
         
		 } catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	}
	
	public String findParticipant(String mailID)
	{
		 try {
			 Class.forName("com.ibm.db2.jcc.DB2Driver");
			 
         Connection con1 = DriverManager.getConnection(URL, userName, password);
         System.out.println("connected to user database");
         
         String sql = "Select name from participant where mailID= '" + mailID +"'";
         Statement st = con1.createStatement();
         
         System.out.println("SQL is "+sql); 
         ResultSet rs = st.executeQuery(sql);
         
         while (rs.next())
         {
        	return rs.getString(1); 
         }
        	 
         con1.close();
         
		 } catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		return null;
	
	}
	
	public HashSet<ActiveRouteInfo> getActiveRouteInfo(Timestamp starttime, Timestamp endtime, int seats){
	
		HashSet<ActiveRouteInfo> info = new HashSet<ActiveRouteInfo>();
		
		try {	 
			 Class.forName("com.ibm.db2.jcc.DB2Driver");
			 
         Connection con1 = DriverManager.getConnection(URL, userName, password);
         System.out.println("connected to user database");
         
         String sql = "Select rs.mailID, ra.startTime, source, destination, distance, mobileno, name from route_active as ra, route_seeder as rs, participant as p where rs.routeid=ra.routeid and rs.mailID=p.mailID and ra.startTime >= '"+ starttime +"' and ra.startTime <= '"+ endtime +"' and seats >="+ seats +"";
         Statement st = con1.createStatement();
         
         System.out.println("SQL is "+sql); 
         ResultSet rs = st.executeQuery(sql);
         
         while (rs.next())
         {
        	ActiveRouteInfo routeInfo= new ActiveRouteInfo();
        	System.out.println(rs.getString(1));
            routeInfo.email=rs.getString(1);   
            routeInfo.startTime = rs.getTimestamp(2);
            routeInfo.source=rs.getString(3);
            routeInfo.destinaton=rs.getString(4);
            routeInfo.distance=rs.getDouble(5);
            routeInfo.mobileno=rs.getString(6);
            routeInfo.name = rs.getString(7);
           
           info.add(routeInfo);
         }
        	 
         con1.close();
         
		 } catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		return info;
   }
	
	 public void loadFeedbackData(String mailID, String feedback)
		{
			 try {
				 Class.forName("com.ibm.db2.jcc.DB2Driver");
				 
	         Connection con1 = DriverManager.getConnection(URL, userName, password);
	         System.out.println("connected to user database");
	         
	         String sql = "Insert into feedback values(?,?)";
	         PreparedStatement st = con1.prepareStatement(sql);
	         
	         st.setString(1,mailID);
	         st.setString(2, feedback);
	         
	         System.out.println("SQL is "+sql); 
	         st.executeUpdate();
	         
	         con1.close();
	         
			 } catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
		}
		
	
}
