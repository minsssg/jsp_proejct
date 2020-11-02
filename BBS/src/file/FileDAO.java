package file;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class FileDAO {

	private Connection conn;
	private ResultSet result;
	
	public FileDAO() {
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
	
	public int upload(String userID, String fileName, String fileRealName) {
		String SQL = "INSERT INTO FILE VALUES(?, ?, ?)";
		try {
			if (fileName == null) {
				return 0;
			}
			
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setNString(1, userID);
			pstmt.setNString(2, fileName);
			pstmt.setNString(3, fileRealName);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public ArrayList<FileDTO> getList(String userID) {
		String SQL = "SELECT * FROM file WHERE userID = ?";
		ArrayList<FileDTO> list = new ArrayList<FileDTO>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setNString(1, userID);
			result = pstmt.executeQuery();
			System.out.println(SQL);
			while(result.next()) {
				FileDTO file = new FileDTO();
				file.setUserID(result.getNString(1));
				file.setFileName(result.getNString(2));
				file.setFileRealName(result.getNString(3));
				list.add(file);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
}
