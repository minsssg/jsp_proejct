package file;

public class FileDTO {
	
	private String userID;
	private String fileName;
	private String fileRealName;
	private float latitude;
	private float longitude;
	
	public FileDTO(String fileName, String fileRealName) {
		super();
		this.fileName = fileName;
		this.fileRealName = fileRealName;
	}
	
	public FileDTO(String fileName) {
		super();
		this.fileName = fileName;
	}
	
	public FileDTO() {
		super();
	}
	
	public String getFileName() {
		return fileName;
	}
	
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	
	public String getFileRealName() {
		return fileRealName;
	}
	
	public void setFileRealName(String fileRealName) {
		this.fileRealName = fileRealName;
	}
	
	public String getUserID() {
		return userID;
	}
	
	public void setUserID(String userID)  {
		this.userID = userID;
	}
	
	public float getLatitude() {
		return latitude;
	}
	
	public void setLatitude(float latitude) {
		this.latitude = latitude;
	}
	
	public float getlongitude() {
		return longitude;
	}
	
	public void setLongitude(float longitude) {
		this.longitude = longitude;
	}
}
