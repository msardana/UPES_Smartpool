package dbaccess;

import java.sql.Timestamp;

public class ActiveRouteInfo {
	
 String source=null;
 String destinaton = null;
 String email = null;
 Double distance=null;
 Timestamp startTime=null;
 String mobileno=null;
 String name=null;
 
 public String getSource()
 {
	 return source;
 }
 public String getDestination()
 {
	 return destinaton;
	 
 }
 public String getEmail()
 {
	 return email;
 }
 public Double getDistance()
 {
	 return distance;
 }
 public Timestamp getStartTime()
 {
	 return startTime;
 }
 public String getMobileno()
 {
	 return mobileno;
 }
 public String getName()
 {
	 return name;
 }
 }


