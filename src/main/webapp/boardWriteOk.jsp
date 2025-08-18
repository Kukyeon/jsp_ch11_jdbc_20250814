<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글작성 </title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
	
		String btitle = request.getParameter("btitle"); //게시글 제목
		String bcontent = request.getParameter("bcontent"); //게시글 내용
		String bid = request.getParameter("memberid"); //게시글 쓴 아이디
		//DB에 삽입할 데이터 준비 완료!
		
		//DB 커넥션 준비
		String driverName = "com.mysql.jdbc.Driver"; //MySQL JDBC 드라이버 이름
		String url = "jdbc:mysql://localhost:3306/jspdb"; //MySQL이 설치된 서버의 주소(ip)와 연결할 DB(스키마) 이름		
		String username = "root";
		String password = "12345";
		
		//SQL문 만들기
		// String sql = "INSERT INTO board(btitle, bcontent, memberid) VALUES ('"+btitle+"','"+bcontent+"','"+bid+"')";
		String sql = "INSERT INTO board(btitle, bcontent, memberid) VALUES (?,?,?)";
		//String sql = "SELECT * FROM board"; //모든 회원 리스트 반환
		
		int result = 0; //글 삽입 성공 여부 저장할 변수
		
		
		Connection conn = null; //커넥션 인터페이스로 선언 후 null로 초기값 설정
		//Statement stmt = null; //sql문을 관리해주는 객체를 선언해주는 인터페이스로 stmt 선언
		PreparedStatement pstmt = null;
		// ResultSet rs = null; //select문 실행 시 DB에서 반환해주는 레코드 결과를 받아주는 자료타입 rs 선언
		// List<BoardDto> boardList = new ArrayList<BoardDto>();
		//1명의 회원정보 Dto객체들이 여러 개 저장될 리스트 선언
		
		try {
			Class.forName(driverName); //MySQL 드라이버 클래스 불러오기			
			conn = DriverManager.getConnection(url, username, password);
			//커넥션이 메모리 생성(DB와 연결 커넥션 conn 생성)
			//stmt = conn.createStatement(); //stmt 객체 생성
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, btitle);
			pstmt.setString(2, bcontent);
			pstmt.setString(3, bid);
			result = pstmt.executeUpdate(); //성공하면 1이 반환, 실패하면 0이 반환
			
		} catch (Exception e) {
			out.println("DB 에러 발생! 게시판 가져오기 실패!");
			e.printStackTrace(); //에러 내용 출력
		} finally { //에러의 발생여부와 상관 없이 Connection 닫기 실행 
			try {			
				if(pstmt != null) { //stmt가 null 이 아니면 닫기(conn 닫기 보다 먼저 실행)
					pstmt.close();
				}				
				if(conn != null) { //Connection이 null 이 아닐 때만 닫기
					conn.close();
				}
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		if(result == 1) { //참이면 글쓰기 성공->글 목록 출력 화면으로 이동
			RequestDispatcher dispatcher = request.getRequestDispatcher("boardWriteList.jsp");
			dispatcher.forward(request, response);
		}
	
	%>
</body>
</html>