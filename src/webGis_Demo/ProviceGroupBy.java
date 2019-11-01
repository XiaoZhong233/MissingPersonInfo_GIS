package webGis_Demo;

public class ProviceGroupBy {
	String province;
	String count;
	
	public ProviceGroupBy() {
		// TODO Auto-generated constructor stub
	}
	
	public ProviceGroupBy(String province,String count) {
		// TODO Auto-generated constructor stub
		this.province = province;
		this.count = count;
	}
	
	public String getCount() {
		return count;
	}
	
	public String getProvince() {
		return province;
	}
	
	public void setCount(String count) {
		this.count = count;
	}
	
	public void setProvince(String province) {
		this.province = province;
	}
	
	
}
