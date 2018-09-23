
public class Restaurant {
	private String name;
	private String foodtype;
	private double distance;
	private String description;
	private String address;
	private double lat;
	private double lng;
	
	public Restaurant(String name, String foodtype, double distance, String description, String address, double lat, double lng)
	{
		this.name = name;
		this.foodtype = foodtype;
		this.distance = distance;
		this.description = description;
		this.address = address;
		this.lat = lat;
		this.lng = lng;
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getFoodtype() {
		return foodtype;
	}
	public void setFoodtype(String foodtype) {
		this.foodtype = foodtype;
	}
	public double getDistance() {
		return distance;
	}
	public void setDistance(double distance) {
		this.distance = distance;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public double getLat() {
		return lat;
	}
	public void setLat(long lat) {
		this.lat = lat;
	}
	public double getLng() {
		return lng;
	}
	public void setLng(long lng) {
		this.lng = lng;
	}
	
	
}
