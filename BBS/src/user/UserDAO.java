package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class UserDAO {
	
	private Connection conn;
	private ResultSet result;
	
	public UserDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/BBS?serverTimezone=UTC";
			String dbID = "root";
			String dbPassword = "root";
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			System.out.println("MySql 연결 안됨!!");
			e.printStackTrace();
		}
	}
	
	public int login(String userID, String userPassword) {
		String SQL = "SELECT userPassword FROM user WHERE userID = ?";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setNString(1, userID);
			result = pstmt.executeQuery();
			if (result.next()) {
				if (result.getNString(1).equals(userPassword)) {
					System.out.println("Successed login!!");
					return 1;	// 로그인 성공
				}
				else
					return 0;	// 비밀번호 불일치
			}
			return -1;	// 아이디 없음
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return -2;	// 데이터베이스 오류
	}
	
	public int join(User user) {
		String SQL = "INSERT INTO user VALUES (?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setNString(1, user.getUserID());
			pstmt.setNString(2, user.getUserPassword());
			pstmt.setNString(3, user.getUserName());
			pstmt.setNString(4, user.getUserGender());
			pstmt.setNString(5, user.getUserPhoneNumber());
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return -1; // 데이터베이스 오류
	}
	
	public int update(String userName, String userPassword, String userGender, String userPhoneNumber, String userID) {
		String SQL = "UPDATE user SET userName = ?, userPassword = ?, userGender = ?, userPhoneNumber = ? WHERE userID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setNString(1, userName);
			pstmt.setNString(2, userPassword);
			pstmt.setNString(3, userGender);
			pstmt.setNString(4, userPhoneNumber);
			pstmt.setNString(5, userID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return -1;
	}
	
	public User getUser(String userID) {
		String SQL = "SELECT * FROM user WHERE userID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setNString(1, userID);
			result = pstmt.executeQuery();
			if (result.next()) {
				User user = new User();
				user.setUserID(result.getNString(1));
				user.setUserPassword(result.getNString(2));
				user.setUserName(result.getNString(3));
				user.setUserGender(result.getNString(4));
				user.setUserPhoneNumber(result.getNString(5));
				
				return user;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
	public ArrayList<String> getUserID(String userName) {
		String SQL = "SELECT userID FROM user WHERE userName = ?";
		
		ArrayList<String> userID_list = new ArrayList<String>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setNString(1,  userName);
			result = pstmt.executeQuery();
			while (result.next()) {
				String userID  = result.getNString(1);
				userID_list.add(userID);
			}
		} catch (Exception e)  {
			e.printStackTrace();
		}
		
		return userID_list;
	}
}
