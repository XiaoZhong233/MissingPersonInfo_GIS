package webGis_Demo;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class JsonHelper {
	public static String convertObject(Object person) {
        //1��ʹ��JSONObject
//        JSONObject json = JSONObject.fromObject(person);
        //2��ʹ��JSONArray
        JSONArray array=JSONArray.fromObject(person);
//        String strJson=json.toString();
        String strArray=array.toString();
        return strArray;
        }
	
	
	public static void jsonStrToJava() {
		
	}
	
	public static void main(String[] args) {
		
		
		
		Person p1 = new Person("�Ӻ�ΰ1", "��", "1998-1-1", "31", "����ũҵ��ѧ", "231,43", "cute boy", "handsome","2","2014");
		Person p2 = new Person("�Ӻ�ΰ2", "��", "1998-1-1", "31", "����ũҵ��ѧ", "231,43", "cute boy", "handsome","3","2314");
		JSONObject json1 = JSONObject.fromObject(p1);
		JSONObject json2= JSONObject.fromObject(p2);
        JSONArray array=new JSONArray();
        //array.add(0,p2);
        //array.add(1,p1);
        Person[] persons = {p1,p2};
        array.add(persons);
        System.out.println("strArray:"+array);

	}
}
