package dbaccess;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.HashSet;
import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ibm.json.java.JSONArray;
import com.ibm.json.java.JSONObject;

/**
 * Servlet implementation class FindActiveRouteInfo
 */
@WebServlet("/FindActiveRouteInfo")
public class FindActiveRouteInfo extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FindActiveRouteInfo() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		    
		    DataLoader d = new DataLoader();
		    Timestamp leecherStartTime = Timestamp.valueOf(request.getParameter("leecherStartTime"));
		    int tolerance = Integer.parseInt(request.getParameter("tolerance"));
		    int seats = Integer.parseInt(request.getParameter("seats"));
		    
		    Calendar cal = Calendar.getInstance();
		    cal.setTimeInMillis(leecherStartTime.getTime());
		    
		    cal.add(Calendar.HOUR_OF_DAY, tolerance);
		    
		    Timestamp newTime = new Timestamp(cal.getTimeInMillis());
		    
		    cal.setTimeInMillis(leecherStartTime.getTime());
		    cal.add(Calendar.HOUR_OF_DAY, -tolerance);
		   
		    Timestamp oldTime =  new Timestamp(cal.getTimeInMillis());
		    
		    HashSet<ActiveRouteInfo> info= d.getActiveRouteInfo(oldTime, newTime, seats);
		    Iterator<ActiveRouteInfo> itr=info.iterator();
		    
		    JSONArray jsonArray = new JSONArray();
		    JSONObject finalJson = new JSONObject();
		    
		    while(itr.hasNext())
		    {
		    System.out.println("json doc");	
		    ActiveRouteInfo routeInfo = itr.next();
		    JSONObject json = new JSONObject();
		    json.put("source", routeInfo.getSource());
		    json.put("destination", routeInfo.getDestination());
		    json.put("email", routeInfo.getEmail());
		    json.put("starttime", String.valueOf(routeInfo.getStartTime()));
		    json.put("distance", routeInfo.getDistance());
		    json.put("mobileno", routeInfo.getMobileno());
		    json.put("name", routeInfo.getName());
		    jsonArray.add(json);
		    }
		    
		    finalJson.put("routeInfo", jsonArray);
		    response.setContentType("application/json");
		    response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate, post-check=0, pre-check=0");
		    response.setHeader("Pragma","no-cache");
		    PrintWriter writer =response.getWriter();
		    writer.print(finalJson.serialize());
	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
