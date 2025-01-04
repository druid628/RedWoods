import java.awt.*;
import javax.swing.*;

/*
 * Created by Druid628
 * Created by Micah Breedlove
 * 
 *    Last big change
 *      28.03.2003
 * 
 * 
 */

public class Mapstog extends JFrame { 

	GatherSpam gs = new GatherSpam(this);

	//Setup Row 1 -- Will be FlowLayout
	JPanel row1 = new JPanel();
	JLabel Enter_addy_Label = new JLabel("Please enter the page address:", JLabel.LEFT);
	
	//Setup Row 2 -- Will be GridLayout
	JPanel row2 = new JPanel();
	JLabel http = new JLabel("http://", JLabel.RIGHT);
	JTextField address = new JTextField(35);
	JButton Go_button = new JButton("Go!");
	
	//Setup Row 3 -- Will be GridLayout
	JPanel row3 = new JPanel();
	JLabel List_Label = new JLabel("List of email addresses", JLabel.LEFT);

	//Setup Row 3.5
	JPanel row3point5 = new JPanel();
	
	//Setup Row 4 -- will be flow
	JPanel row4 = new JPanel();
	JTextArea list_of_emails = new JTextArea(10, 43);
	JScrollPane list_emails = new JScrollPane(list_of_emails); 

	//Setup Row 5 -- will be flow
	JPanel row5 = new JPanel();
	JButton Clear_Button = new JButton("Clear Contents");

	//Creating all the junk fo' tha menu
	JMenuBar Menu_Bar = new JMenuBar();
	JMenu File_Menu = new JMenu("File");
	JMenu Edit_Menu = new JMenu("Edit");
	JMenu Help_Menu = new JMenu("Help");
	JMenuItem New_One = new JMenuItem("New Search");
	JMenuItem Exit = new JMenuItem("Exit");
	JMenuItem Print_Item = new JMenuItem("Print");
	JMenu Export = new JMenu("Export");
	JMenuItem Export_Text = new JMenuItem("Text");
	JMenuItem Export_Html = new JMenuItem("HTML");
	JMenuItem About_Item = new JMenuItem("About Mapstog");
	JMenuItem Contact = new JMenuItem("Contact");

	//the temporary list array
//	String[] temp_List;
	
	public Mapstog(){
		super("Mapstog -- The Gatherer of Email Address .::. All shall fear him");
		setSize(550,420);
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		try{
			UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
		}catch(Exception e){
		}
		FlowLayout main_layout = new FlowLayout(FlowLayout.LEFT);
	        Container pane = getContentPane();
	        pane.setLayout(main_layout);

		//building Menu
		setJMenuBar(Menu_Bar);
		New_One.addActionListener(gs);
		File_Menu.add(New_One);
		File_Menu.setMnemonic('F');
		Export_Html.addActionListener(gs);
		Export_Text.addActionListener(gs);
		Export.add(Export_Text);
		Export.add(Export_Html);
		File_Menu.add(Export);
		Export.setEnabled(false);
		File_Menu.addSeparator();
		File_Menu.add(Print_Item);
		Print_Item.addActionListener(gs);
		File_Menu.addSeparator();
		Exit.addActionListener(gs);
		Exit.setMnemonic('X');
		File_Menu.add(Exit);
		Help_Menu.setMnemonic('H');
		About_Item.addActionListener(gs);
		Help_Menu.add(About_Item);
		Help_Menu.addSeparator();
		Help_Menu.add(Contact);
		Menu_Bar.add(File_Menu);
		Menu_Bar.add(Edit_Menu);
		Menu_Bar.add(Help_Menu);

		//Temp. Disabled
		//Export_Html.setEnabled(false);
		Contact.setEnabled(false);
		Print_Item.setEnabled(false);
		//About_Item.setEnabled(false);
	

		
		//Building Row1
		FlowLayout Row1_layout = new FlowLayout(FlowLayout.LEFT);
		row1.setLayout(Row1_layout);
		row1.add(Enter_addy_Label);
		pane.add(row1);

		//Building Row2
		FlowLayout Row2_Layout = new FlowLayout();
		Row2_Layout.setAlignment(FlowLayout.LEADING);
		row2.setLayout(Row2_Layout);
		row2.add(http);
		address.addActionListener(gs);
		row2.add(address);
		Go_button.addActionListener(gs);
		row2.add(Go_button);
		pane.add(row2);

		//Building Row3
		FlowLayout Row3_Layout = new FlowLayout();
		Row3_Layout.setAlignment(FlowLayout.LEADING);
		row3.setLayout(Row3_Layout);
		row3.add(List_Label);
		pane.add(row3);

		//Building Row 4
		FlowLayout Row4_Layout = new FlowLayout();
		Row4_Layout.setAlignment(FlowLayout.LEFT);
		row4.setLayout(Row4_Layout);
		list_of_emails.setEditable(false);
		row4.add(list_emails);
		pane.add(row4);

		//Building Row 5
		FlowLayout Row5_Layout = new FlowLayout();
		Row5_Layout.setAlignment(FlowLayout.LEFT);
		row5.setLayout(Row5_Layout);
		Clear_Button.addActionListener(gs);
		row5.add(Clear_Button);
		pane.add(row5);

		setContentPane(pane);
		setVisible(true);
	}
	
	public static void main(String[] args){
		Mapstog getit = new Mapstog();
	}

}
