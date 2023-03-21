package test.api;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;

import net.datafaker.Faker;

public class DataGenerator {
	/**
	 * We can use Java class and methods in Karate framework each Java methods
	 * should be static in order to use or call them in Karate Framework. for Data
	 * Generator. we will create separate static methods to return Data for each
	 * JSON key.
	 */
	
	public static String getEmail() {
		Faker faker = new Faker();
		String email = faker.name().firstName()+faker.name().lastName()+"@tekschool.us";
		return email;
		
	}
	
	public static String getFirstName() {
		Faker faker = new Faker();
		return faker.name().firstName();
	}
	
	public static String getLastName() {
		Faker faker = new Faker();
		return faker.name().lastName();
	}
	
	public static String getTitle() {
		Faker faker = new Faker();
		return faker.name().prefix().toUpperCase();
	}
	
	public static String getDOB() {
		Faker faker = new Faker();
		Date date = new Date(); // java.util
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd"); // java.text.SimpleDateFormat 
		return format.format(date);
	}
	
	public static String getEmploymentStatus() {
		Faker faker = new Faker();
		return faker.job().position();
	}
	
	public static String getGender() {
		Faker faker = new Faker();
		return faker.dog().gender().toUpperCase();
	}
	
	public static String getMaritalStatus() {
		ArrayList<String> status = new ArrayList<String>();
		status.add("SINGLE");
		status.add("MARRIED");
		status.add("DIVORCED");
		status.add("WIDOW");
		status.add("WIDOWER");
		Collections.shuffle(status);
		return status.get(0);
		
	}

}
