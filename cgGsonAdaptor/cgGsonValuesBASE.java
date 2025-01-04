package net.code_grove.json.gson;

/**
 * @author: Micah Breedlove <Micah@BlueShamrockDev.com> .::. <DruiD@Code-Grove.net>;
 * @package: net.code_grove.json.gson;
 *
 * This class exists for the sole purpose of instantiating variables and 
 * defining getters and setters.
 *
 * www.code-grove.net
 *
 **/
 
abstract public class cgGsonValuesBASE 
{
  /**
   * Define your values which are destined to be in your json String here
   *
   **/
  private String savedValues = "";
  private String name = "";
  private String tree1 = "";
  private String tree2 = "";
  private String tree3 = "";
 
  /**
   * Define your Getters and Setters 
   *
   **/
  /**
   * Getters-n-Setters
   * lumped by value 
   * not lumped by action
   **/

  // savedValues - not really sure wtf this attribute is carry over from testing
  // that never went away
  public void setSavedValues(String value)
  {
    savedValues = value;
  }

  public String getSavedValues()
  {
    return savedValues;
  }

  // Name
  public void setName(String value)
  {
    name = value;
  }

  public String getName()
  {
    return name;
  }
  // noShares
  public void setTree1(String value)
  {
    tree1 = value;
  }

  public String getTree1()
  {
    return tree1;
  }

  // tree2
  public void setTree2(String value)
  {
    tree2 = value;
  }

  public String getTree2()
  {
    return tree2;
  }

  // tree3
  public void setTree3(String value)
  {
    tree3 = value;
  }

  public String getTree3()
  {
    return tree3;
  }
 }
