package net.code_grove.json.gson;
 
import com.google.gson.Gson;
 
/**
 * @author: Micah Breedlove <Micah@BlueShamrockDev.com> .::. <DruiD@Code-Grove.net>;
 * @package: net.code_grove.json.gson;
 *
 * This adaptor works with gson and handles to and from gson packages for you.
 * The cgGsonValues is a class which represents the values in the json string
 * the cgGsonAdaptor handles the "dirty work" for you.
 *
 *
 * Syntax: 
 *   cgGsonAdaptor json = new cgGsonAdaptor(new cgGsonValues);
 *
 * www.code-grove.net
 *
 **/
 
public class cgGsonAdaptor 
{
  public static cgGsonValues sv;

  public cgGsonAdaptor()
  {
     sv = new cgGsonValues();
  }

  public cgGsonAdaptor(cgGsonValues incoming)
  {
     sv = incoming;
  }

  public String toString()
  {
    return this.getJson();
  }

  public String getJson()
  {
	   Gson gson = new Gson();
	  // convert java object to JSON format
	   String json = gson.toJson(sv);
    // return json encoded String
    return json;
  }

  public cgGsonValues deSerializeJson(String serializedValue)
  {
	   Gson gson = new Gson();
     // decode json string into a populated  cgGsonValues file
     sv = gson.fromJson(serializedValue, cgGsonValues.class);
     // return a cgGsonValues object
     return sv;
  }

}
