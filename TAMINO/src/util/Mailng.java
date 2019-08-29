package util;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class Mailng {

	public static void naverMailSend(String reciver,String title,String text) { 
		String host = "smtp.naver.com"; // 네이버일 경우 네이버 계정, gmail경우 gmail 계정 
		String user = "qkrwldms0425"; // 
		String password = "pk@2151820";
		 // SMTP 서버 정보를 설정한다. 
		Properties props = new Properties(); 
		props.put("mail.smtp.host", host);
		 props.put("mail.smtp.port", 587);
		 props.put("mail.smtp.auth", "true");
		 Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
			 protected PasswordAuthentication getPasswordAuthentication() { 
			 return new PasswordAuthentication(user, password); 
			} 
		}); 
		 
		try { 
		System.out.println("try1 들어옴");
		MimeMessage message = new MimeMessage(session);
		System.out.println("try2 들어옴");
		 message.setFrom(new InternetAddress(user));
		 System.out.println("try3 들어옴");
		 message.addRecipient(Message.RecipientType.TO, new InternetAddress(reciver));
		 System.out.println("try4 들어옴");
		 // 메일 제목 
		message.setSubject(title);
		System.out.println("try5 들어옴");
		 // 메일 내용 
		message.setText(text);
		System.out.println("try6 들어옴");
		
		 // send the message 
		Transport.send(message); 
		System.out.println("Success Message Send"); 
		} catch (MessagingException e) { 
		System.out.println("Fail Message Send"); 
		e.printStackTrace(); 
		} 
	}

	
}
