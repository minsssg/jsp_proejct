
<%@ page import="user.User" %>
<%@ page import="user.UserDAO" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.nio.file.Files" %>
<%@ page import="java.nio.file.Path" %>
<%@ page import="java.nio.file.Paths" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="bbs" class="bbs.Bbs" scope="page"/>
<jsp:setProperty name="bbs" property="latitude"/>
<jsp:setProperty name="bbs" property="longitude"/>
<jsp:setProperty name="bbs" property="bbsTitle"/>
<jsp:setProperty name="bbs" property="bbsContent"/>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
	<title>FILE UPLOAD ACTION</title>
</head>
<body>
	<%
		String userID = null;
		User user = new User();
		if (session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
			user = new UserDAO().getUser(userID);
		}
		
		if (userID == null)	{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		} else {
			System.out.println(userID);
			String image_folder = application.getRealPath("/images/")+userID;
			SimpleDateFormat date = new SimpleDateFormat("yyyyMMddkkmmss");
			Date today = new Date();
			String now = date.format(today);
			String directory = image_folder +"/"+ now;	// userID/파일업로드한 시간
			Path path =  Paths.get(directory);
			System.out.println("Path: " + path);
			Files.createDirectories(path);
			// File dic = new File(directory);//
			// boolean chk = dic.mkdir(); // 폴더 만들기!
			
			// System.out.println(chk);
			int maxSize = 1024 * 1024 * 100; // 총 100MB
			String encoding = "UTF-8";
			DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();
			MultipartRequest multipartRequest = new MultipartRequest(
					request, directory, maxSize, encoding,
					policy);
					
			if (multipartRequest.getParameter("bbsTitle").isEmpty() || multipartRequest.getParameter("bbsContent").isEmpty()
					|| multipartRequest.getParameter("lat").isEmpty() || multipartRequest.getParameter("lng").isEmpty()) {
				
				System.out.println(request.getParameter("bbsTitle"));
				System.out.println(request.getParameter("bbsContent"));
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else  {
			
				/*
				MultipartRequest multipartRequest = new MultipartRequest(
						request, directory, maxSize, encoding,
						new DefaultFileRenamePolicy()); //파일 업로드 실행
				*/
				
				System.out.println(multipartRequest.getParameter("bbsTitle"));
				System.out.println(multipartRequest.getParameter("bbsContent"));
				Enumeration fileNames =multipartRequest.getFileNames();
		
				while(fileNames.hasMoreElements()){
					//System.out.println(fileNames.hasMoreElements());
					String parameter = (String) fileNames.nextElement();
					String fileName = multipartRequest.getOriginalFileName(parameter);// 사용자가 업로드 하고자 하는 파일 네임
					String fileRealName = multipartRequest.getFilesystemName(parameter); // 시스템에 저장된 파일 이름
					if(fileName == null) continue;
					
					if(!fileName.endsWith(".jpg") && !fileName.endsWith(".jpeg") && !fileName.endsWith(".png")){
						out.write("업로드 할 수 없는 확장자입니다.");
					}
					//FileDAO fileDao = new FileDAO();
					//int check = fileDao.upload(userID, fileName, fileRealName);
					out.write("유저ID: " + userID + "<br>");
					out.write("파일명: " + fileName + "<br>");
					out.write("실제 파일명: " + fileRealName + "<br>");	
				}
				
				BbsDAO bbsDAO = new BbsDAO();
				System.out.println(multipartRequest.getParameter("lat"));
				int result = bbsDAO.write(multipartRequest.getParameter("bbsTitle"), userID, user.getUserName(), multipartRequest.getParameter("bbsContent"), multipartRequest.getParameter("lat"), multipartRequest.getParameter("lng"), now);
				
				if (result == -1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글쓰기에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				} else {	// 글쓰기 성공!
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'profile.jsp?userID=" + userID +"'");
					script.println("</script>");
				}
			}
		}
	%>
	<h2>업로드 내용</h2>
</body>
</html>