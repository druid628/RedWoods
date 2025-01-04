package com.druid628.gmb

class Person {

	String username
	String firstName
	String lastName

	static hasMany = [badges:Badge]

	static constraints = {
		username(blank: false)
		firstName(blank: false)
		lastName(blank: false)
	}

	@Override
	public String toString()
	{
		return firstName + " " + lastName;
	}
}
