<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="file.FileDAO" %>
<%@ page import="file.FileDTO" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Hello 게시판만들기!</title>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		if (userID == null)	{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		}
		int bbsID = 0;
		if (request.getParameter("bbsID") != null) {
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
			System.out.println("bbsid: " + bbsID);
		}
		if	(bbsID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");
		}
		Bbs bbs = new BbsDAO().getBbs(bbsID);
		if (!userID.equals(bbs.getUserID())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else {
			
			System.out.println(userID);
			/*-----------------------파일 수정 시 기존 파일 삭제-------------------------*/
			String image_folder = application.getRealPath("/images/")+userID;
			File file = new File(image_folder+"/"+bbs.getBbsDate());
			File[] tempFile = file.listFiles();
			for(int i = 0; i < tempFile.length; i++){
				tempFile[i].delete();
			}
			file.delete();
			/*-----------------------------------------------------------------*/
			
			SimpleDateFormat date = new SimpleDateFormat("yyyyMMddkkmmss");
			Date today = new Date();
			String now = date.format(today);
			System.out.println(now);
			String directory = image_folder +"/"+ now;	// userID/파일업로드한 시간
			File dic = new File(directory);//
			boolean chk = dic.mkdir(); // 폴더 만들기!
			System.out.println(chk);
			int maxSize = 1024 * 1024 * 100; // 총 100MB
			String encoding = "UTF-8";
		
			MultipartRequest multipartRequest = new MultipartRequest(
					request, directory, maxSize, encoding,
					new DefaultFileRenamePolicy()); // 

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
					FileDAO fileDao = new FileDAO();
					int check = fileDao.upload(userID, fileName, fileRealName);
					out.write("유저ID: " + userID + "<br>");
					out.write("파일명: " + fileName + "<br>");
					out.write("실제 파일명: " + fileRealName + "<br>");	
				}
				
				BbsDAO bbsDAO = new BbsDAO();
				int result = bbsDAO.update(bbsID, multipartRequest.getParameter("bbsTitle"), multipartRequest.getParameter("bbsContent"), now);
				
				if (result == -1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글쓰기 수정에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				} else {	// 글쓰기 성공!
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글쓰기 수정에 성공했습니다.')");
					script.println("location.href = 'profile.jsp?userID=" + userID + "'");
					script.println("</script>");
				}
			}
		}
		
	%>
</body>
</html>