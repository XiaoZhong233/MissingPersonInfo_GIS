package webGis_Demo;

/**
 * @author Administrator
 *
 */
public class Person {
	String name;
	String sex;
	String birth;
	String tall;
	String adress;
	String cor;
	String describe;
	String other;
	String updateTime;
	String imgurl;
	String id;
	String missingdate;
	
	public Person(String name,String sex,String birth,String tall,String adress,String cor,String describe,String other,String id,String missingdate) {
		this.name = name;
		this.sex = sex;
		this.birth = birth;
		this.tall = tall;
		this.adress = adress;
		this.cor = cor;
		this.describe = describe;
		this.other = other;
		this.updateTime = "null";
		this.imgurl="null";
		this.missingdate = missingdate;
		this.id = id;
	}
	
	public void setMissingdate(String missingdate) {
		this.missingdate = missingdate;
	}
	
	public String getMissingdate() {
		return missingdate;
	}
	
	public void setId(String id) {
		this.id = id;
	}
	
	public String getId() {
		return id;
	}
	
	public void setImgurl(String imgurl) {
		this.imgurl = imgurl;
	}
	
	public String getImgurl() {
		return imgurl;
	}
	
	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}
	
	public String getUpdateTime() {
		return updateTime;
	}
	
	public String getName() {
		return name;
	}
	public String getSex() {
		return sex;
	}
	public String getBirth() {
		return birth;
	}
	public String getTall() {
		return tall;
	}
	public String getAdress() {
		return adress;
	}
	public String getCor() {
		return cor;
	}
	public String getDescribe() {
		return describe;
	}
	public String getOther() {
		return other;
	}
	
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		
		  return String.format("Person[name=\"%s\",sex=\"%s\",birth=\"%s\",tall=\"%s\",,adress=\"%s\",,cor=\"%s\",,describe=\"%s\",,other=\"%s\",,updateTime=\"%s\",,imgurl=\"%s\"]", 
				  this.name,this.sex,this.birth,this.tall,this.adress,this.cor,this.describe,this.other,this.updateTime,this.imgurl);
	}
}
