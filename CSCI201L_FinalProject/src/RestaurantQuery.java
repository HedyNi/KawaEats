import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

/**
 * Servlet implementation class RestaurantQuery
 */
@WebServlet("/RestaurantQuery")
public class RestaurantQuery extends HttpServlet {
	//add external jar
	//build path!
	private static final long serialVersionUID = 1L;
    
	public static void addToList(ArrayList<Restaurant> al, ResultSet rs)
	{
		try {
			String name = rs.getString("name");
			String address = rs.getString("address");
			String des = rs.getString("Description");
			double distance = rs.getDouble("distance");
			double lat = rs.getDouble("lat");
			double lng = rs.getDouble("lng");
			System.out.println(lat);
			System.out.println(lng);
			String type = rs.getString("foodtype");
			Restaurant rest = new Restaurant(name, type, distance, des, address, lat, lng);
			al.add(rest);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	protected void service (HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		ArrayList<Restaurant> toSend = new ArrayList<Restaurant>();
		response.setContentType("text/plain");
		PreparedStatement ps;
		ResultSet rs;
		Connection conn;
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			//FILL OUT YOUR PASSWORD
			conn = DriverManager.getConnection("jdbc:mysql://localhost/yelp_usc?user=root&password=CHANGETOYOURPASSWORD&useSSL=false");
			//get parameter from front end
			String searchType  = request.getParameter("searchType");
			String searchText = request.getParameter("searchText");
			
			//CASE 1: find name that matches
			if (searchType.equals("Name"))
			{
				System.out.println(searchText);
				ps = conn.prepareStatement("SELECT * FROM Import_2 WHERE name=?");//? mark -> user input, escpae control character
				ps.setString(1,  searchText);//place the first question mark with the control character
				rs = ps.executeQuery();
				PrintWriter pw = response.getWriter();
				while(rs.next()) {
					addToList(toSend, rs);
				}
				Gson gson = new Gson();
				String json = gson.toJson(toSend); 
			    System.out.println(json);
				pw.write(json);
			}
			
			else if(searchType.equals("Type")) {
				System.out.println(searchText);
				ps = conn.prepareStatement("SELECT * FROM Import_2 WHERE foodtype=?");//? mark -> user input, escpae control character
				ps.setString(1,  searchText);//place the first question mark with the control character
				rs = ps.executeQuery();
				PrintWriter pw = response.getWriter();
				while(rs.next()) {
					addToList(toSend, rs);
				}
				Gson gson = new Gson();
				String json = gson.toJson(toSend); 
			    System.out.println(json);
				pw.write(json);
			}
			else if(searchType.equals("Address")) {
				System.out.println(searchText);
				String statement = "SELECT * FROM Import_2 WHERE address LIKE ?";
				System.out.println(statement);
				ps = conn.prepareStatement(statement);//? mark -> user input, escpae control character
				ps.setString(1,  "%" + searchText + "%");//place the first question mark with the control character
				rs = ps.executeQuery();
				PrintWriter pw = response.getWriter();
				while(rs.next()) {
					addToList(toSend, rs);
				}
				Gson gson = new Gson();
				String json = gson.toJson(toSend); 
			    System.out.println(json);
				pw.write(json);
			}
			//CASE 2: find type that matches
//			if (type !="null")
//			{
//				ps = conn.prepareStatement("SELECT * FROM Import_2 WHERE foodtype=?");
//				ps.setString(1,  type);
//
//				rs = ps.executeQuery();
//				while (rs.next())
//				{
//					//i print out the variables here
//					//may store these variables in session or array for later use
//					
//					String name = rs.getString("name");
//					String address = rs.getString("address");
//					String des = rs.getString("Description");
//					
//					pw.println("Name: "+name+" <br/>");
//					pw.println("Address: "+address+" <br/>");
//					pw.println("Desprition: "+des+" <br/>");
//					
//				
//				}
//				
//			}
			
			//CASE 3: get nearby restaurants
//			if (!nearby.equals("null"))
//			{
//				System.out.println("here");
//				ps = conn.prepareStatement("SELECT * FROM Import_2 WHERE distance <= ?");
//				ps.setFloat(1,  dis);
//				rs = ps.executeQuery();
//
//				//starts oneline before the first line
//				//next() return true if there is data in the rows
//				while (rs.next())
//				{
//					String name = rs.getString("name");
//					String address = rs.getString("address");
//					String des = rs.getString("Description");
//					
//					pw.println("Name: "+name+" <br/>");
//					pw.println("Address: "+address+" <br/>");
//					pw.println("Desprition: "+des+" <br/>");
//				
//				}
//				//should close in finally
//					rs.close();
//				    ps.close();
//					conn.close();
//			}
			
			
			
		}
		catch (SQLException sqle)
		{
			System.out.println("sqle: " + sqle.getMessage());
		}
		catch(ClassNotFoundException cnfe)
		{
			System.out.println("cnfe: "+ cnfe.getMessage());
		}
		
//		pw.println("</body>");
//		pw.println("</html>");
	}

}