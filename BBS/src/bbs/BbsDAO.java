package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsDAO {
	
	private Connection conn;
	private ResultSet result;
	
	public BbsDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/BBS?serverTimezone=UTC";
			String dbID = "root";
			String dbPassword = "root";
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public String getDate() {
		
		String SQL = "SELECT NOW()";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			result = pstmt.executeQuery();
			if (result.next()) {
				return result.getNString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return ""; 
	}
	
	public int getNext() {
		
		String SQL = "SELECT bbsID FROM BBS ORDER BY bbsID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			result = pstmt .executeQuery();
			if (result.next()) {
				return result.getInt(1) + 1;
			}
			
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	// uploadAction jsp
	public int write(String bbsTitle, String userID, String userName,
					 String bbsContent, String latitude, String longitude, String date) {
		String SQL = "INSERT INTO bbs VALUES(?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  getNext());
			pstmt.setString(2, bbsTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, userName);
			pstmt.setString(5, date);
			pstmt.setString(6, bbsContent);
			pstmt.setString(7, latitude);
			pstmt.setNString(8, longitude);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public ArrayList<Bbs> getList(int pageNumber) {
		String SQL = "SELECT * FROM BBS WHERE bbsID < ? ORDER BY bbsID DESC LIMIT 6";
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 6);
			result = pstmt.executeQuery();
			while(result.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(result.getInt(1));
				bbs.setBbsTitle(result.getString(2));
				bbs.setUserID(result.getString(3));
				bbs.setUserName(result.getString(4));
				bbs.setBbsDate(result.getString(5));
				bbs.setBbsContent(result.getNString(6));
				bbs.setLatitude(result.getNString(7));
				bbs.setLongitude(result.getNString(8));
				list.add(bbs);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public ArrayList<Bbs> getList(String userID) {
		String SQL = "SELECT * FROM BBS WHERE userID = ? ORDER BY bbsID DESC LIMIT 6";
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  userID);
			result = pstmt.executeQuery();
			while(result.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(result.getInt(1));
				bbs.setBbsTitle(result.getString(2));
				bbs.setUserID(result.getString(3));
				bbs.setUserName(result.getString(4));
				bbs.setBbsDate(result.getNString(5));
				bbs.setBbsContent(result.getString(6));
				bbs.setLatitude(result.getString(7));
				bbs.setLongitude(result.getString(8));
				list.add(bbs);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public ArrayList<Bbs> searchList(String userName) {
		String SQL = "SELECT * FROM BBS WHERE userName = ? ORDER BY bbsID DESC LIMIT 6";
		ArrayList<Bbs> list = new ArrayList<Bbs>(); 
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userName);
			result = pstmt.executeQuery();
			while(result.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(result.getInt(1));
				bbs.setUserID(result.getString(2));
				bbs.setUserName(result.getString(3));
				bbs.setLatitude(result.getString(4));
				bbs.setLongitude(result.getString(5));
				bbs.setBbsTitle(result.getString(6));
				bbs.setBbsContent(result.getString(7));
				bbs.setBbsDate(result.getString(8));
				list.add(bbs);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public ArrayList<Bbs> searchList(String userName, int pageNumber) {
		String SQL = "SELECT * FROM bbs WHERE userName = ? AND bbsID < ? ORDER BY bbsID DESC LIMIT 6";
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setNString(1,  userName);
			pstmt.setInt(2,  getNext()- (pageNumber - 1) * 6);
			result = pstmt.executeQuery();
			while(result.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID((result.getInt(1)));
				bbs.setUserID(result.getNString(2));
				bbs.setUserName(result.getNString(3));
				bbs.setLatitude(result.getNString(4));
				bbs.setLongitude(result.getNString(5));
				bbs.setBbsTitle(result.getNString(6));
				bbs.setBbsContent(result.getNString(7));
				bbs.setBbsDate(result.getNString(8));
				list.add(bbs);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM bbs WHERE bbsID < ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  getNext() - (pageNumber - 1) * 6);
			result = pstmt.executeQuery();
			if (result.next()) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public int bbsCount() {
		String SQL  = "SELECT COUNT(*) FROM bbs";
		int count;
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			result = pstmt.executeQuery();
			if (result.next()) {
				count = result.getInt(1);
				return count;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return -1;
	}
	
	public int bbsCount(String userName) {
		String SQL = "SELECT COUNT(*) FROM bbs WHERE userName = ?";
		int count;
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setNString(1,  userName);
			result = pstmt.executeQuery();
			if (result.next()) {
				count = result.getInt(1);
				return count;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return -1;
	}
	
	public Bbs getBbs(int bbsID) {
		String SQL = "SELECT * FROM bbs WHERE bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  bbsID);
			result = pstmt.executeQuery();
			if (result.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(result.getInt(1));
				bbs.setUserID(result.getNString(2));
				bbs.setUserName(result.getNString(3));
				bbs.setLatitude(result.getNString(4));
				bbs.setLongitude(result.getNString(5));
				bbs.setBbsTitle(result.getNString(6));
				bbs.setBbsContent(result.getNString(7));
				bbs.setBbsDate(result.getNString(8));
				return bbs;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
	public int update(int bbsID, String bbsTitle, String bbsContent, String date) {
		String SQL = "UPDATE bbs SET bbsTitle = ?, bbsContent = ?, date = ? WHERE bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setNString(1, bbsTitle);
			pstmt.setNString(2, bbsContent);
			pstmt.setNString(3, date);
			pstmt.setInt(4, bbsID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int nameUpdate(String userID, String userName) {
		String SQL = "UPDATE bbs SET userName = ?, WHERE userID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setNString(1, userName);
			pstmt.setNString(2, userID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int delete(int bbsID) {
		String SQL = "DELETE FROM bbs WHERE bbsID = ?";
		try  {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
}
