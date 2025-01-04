import java.util.Vector;
import java.util.regex.*;
import java.io.*;
import java.net.*;
import java.awt.event.*;
import java.awt.print.*;
import javax.swing.*;


public class GatherSpam implements ActionListener{

	Mapstog gui;
//	PrintSpam ps;
	String[] temp_List;


	public GatherSpam(Mapstog in) {
		gui = in;
	}
	public void actionPerformed(ActionEvent evt) {
		String command = evt.getActionCommand();
		if(command == "New Search")
			clearitall();
		if(command == "Exit")
			killit();
		if(command == "HTML")
			write_HTML(temp_List, (gui.address.getText()));
		if(command == "About Mapstog")
			About_Mapstog();
		if(command == "Text")
			WriteTo_a_Textfile(temp_List, (gui.address.getText()));
		if(command == "Go!")
			GetSpam(gui.address.getText());
		if(command == "Clear Contents")
			clearitall();
		if(command == "Print"){
//			ps.PrintSpam();
		}
		if((evt.getSource()) == gui.address)
			GetSpam(gui.address.getText());
	}
	
	public void killit() {
		temp_List = null;
		System.runFinalization();
		System.gc();
		System.exit(0);
	}

	public void clearitall() {
		gui.list_of_emails.setText(null);
		gui.address.setText(null);
		gui.Export.setEnabled(false);
		temp_List = null;
	}

	public void GetSpam(String address){

		Vector v = new Vector();
		String the_NeW_Email_address = null;

		try {
			boolean test_address;
			String http_pattern = new String("http");
			Pattern p = Pattern.compile(http_pattern, Pattern.CASE_INSENSITIVE);
			Matcher m = p.matcher(address);
			test_address = m.find();
				
			if(!test_address){
				address = ("http://" + address);
			}else{
			}
			URL url = new URL(address);

			BufferedReader thePage = new BufferedReader(new InputStreamReader(url.openStream()));
			
			String patternStr = "mailto:(.+)@(.+)>";
			Pattern pattern = Pattern.compile(patternStr, Pattern.CASE_INSENSITIVE);
			Matcher matcher = pattern.matcher("");

			String line = null;
			while ((line = thePage.readLine()) != null) {
				matcher.reset(line);
				if(matcher.find()){
					String ifoundaMatch = matcher.group(0);
					int Patternlength = ifoundaMatch.length();
					int closestpacman = ifoundaMatch.indexOf(">");
					ifoundaMatch = ifoundaMatch.substring(0,closestpacman);
					int placeofquote = ifoundaMatch.indexOf("\"");
					if(placeofquote != -1){
						the_NeW_Email_address = ifoundaMatch.substring(7,(closestpacman -1));
					}else{
						the_NeW_Email_address = ifoundaMatch.substring(7,closestpacman);
					}
					v.add(the_NeW_Email_address);
				}//matcher.find
			}//while

			thePage.close();
		} catch (IOException e) {
			System.out.println(e.getMessage());
		} //try/catch

		String[] emailz = (String[])v.toArray(new String[v.size()]);
				int lengthofarray = emailz.length;
				gui.list_of_emails.setText("The URL is " + address +"\n---------------------\n");
				if (emailz.length != 0){
				for(int i = 0; i <= (emailz.length - 1); i++){
					gui.list_of_emails.append((i + 1) + ".) " + emailz[i]+ "\n");
					gui.Export.setEnabled(true);
				}}else{
					gui.list_of_emails.append("There were no valid email addresses found on this page");
					gui.Export.setEnabled(false);
				}
		temp_List = emailz;
									

	}

	public void WriteTo_a_Textfile(String[] emailz, String address){

		String inputValue = JOptionPane.showInputDialog("Where would you like to save this file?\nPlease include the trailing slash\n(i.e. c:\\my_spam_directory\\)");
		String filename;
		File file = new File(inputValue + "List_To_Spam.txt");
		filename = new String(inputValue + "List_To_Spam.txt");
		try {
			
		        
    
		        // Create file if it does not exist
		        boolean success = file.createNewFile();

		        if (success) {
		            // File did not exist and was created
			    BufferedWriter out = new BufferedWriter(new FileWriter(file));
			    out.write("-----------------\r\nURL:  http://" + address + "\r\n-----------------\r\n");
			    for(int i = 0; i <= (emailz.length -1); i++){
			    out.write(emailz[i] + "\r\n");
			    }
			    out.write("-----------------");
			    out.close();

		        } else {
		            // File already exists
			    BufferedWriter out = new BufferedWriter(new FileWriter(file, true));
			    out.write("-----------------\r\nURL:  http://" + address + "\r\n-----------------\r\n");
			    for(int i = 0; i <= (emailz.length -1); i++){
			    out.write(emailz[i] + "\r\n");
			    }
			    out.write("-----------------");
			    out.close();

		        }
		    } catch (IOException e) {
		    }
		    JOptionPane.showMessageDialog(null,"The list was saved to " + filename,"File Saved",JOptionPane.INFORMATION_MESSAGE);

		
	}

	public void write_HTML(String[] emailz, String address){
		String html_inputValue = JOptionPane.showInputDialog("Where would you like to save this file?\nPlease include the trailing slash\n(i.e. c:\\my_spam_directory\\)");
		String html_filename;
		File html_file = new File(html_inputValue + "List_To_Spam.html");
		html_filename = new String(html_inputValue + "List_To_Spam.html");
		try {
		        // Create file if it does not exist
		        boolean success = html_file.createNewFile();
			if (success) {
		            // File did not exist and was created
			    BufferedWriter out = new BufferedWriter(new FileWriter(html_file));
			    out.write("<html>\n<head>\n<title>Email Addresses for " + address +"\n</title></head><body>");
			    for(int i = 0; i <= (emailz.length -1); i++){
			    out.write("<a href=\"mailto:" + emailz[i] + "\">"+ emailz[i]+"</a>\n<br>\n");
			    }
			    out.write("</body>\n</html>");
			    out.close();

		        } else {
		        }

		}catch(IOException e){
		}
		JOptionPane.showMessageDialog(null,"The list was saved to " + html_filename,"File Saved",JOptionPane.INFORMATION_MESSAGE);
			
	}

	public void About_Mapstog(){
		String about_info = new String("Mapstog the Gatherer.\nMapstog was borne from the mind of Druid628 on 13 March, 2003.\nMapstog is used for instructional purposes only. He should only be used to demonstrate how Spammers get email addresses.\nThe creator asks you don't use this for harm. Thank you.\n--Druid628\n\nFor more information visit\nwww.druid628.com\n");
		JOptionPane.showMessageDialog(null, about_info, "About Mapstog", JOptionPane.INFORMATION_MESSAGE);

	}


}
