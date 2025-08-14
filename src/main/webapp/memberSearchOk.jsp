<%@page import="java.sql.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 조회</title>
</head>
<body>
	<h2>회원 정보 조회</h2>
	<hr>
	<%
		request.setCharacterEncoding("utf-8");
		
		String mid = request.getParameter("sid"); // 조회할 아이디
		
		// DB 에 삽입할 데이터 준비 완료
	
		
		// DB 커넥션 준비
		
		String driverName = "com.mysql.jdbc.Driver"; // MySQL 의 JDBC 드라이버 이름
		String url = "jdbc:mysql://localhost:3306/jspdb"; //MySQL이 설치된 서버의 주소(IP)와 연결할 DB(스키마) 이름
		// jdbc:mysql://172.30.1.55:3306 강사님 주소
		String username = "root"; // DB 로그인한 아이디
		String password = "12345"; // DB 비밀번호

		//SQL문 제작 
		String sql = "SELECT * FROM members";
		//MySQL에서 이해할 수 있는 문법으로 작성해야함
		
		
		Connection conn = null; // 커넥션 인터페이스로 선언 후 null로 초기값 선언
		Statement stmt = null; // sql문을 관리해주는 객체를 선언해주는 인터페이스로 stmt 선언
		ResultSet rs = null; // SELECT문 실행시 DB에서 반환해주는 레코드 결과를 받아주는 자료타입 rs선언
		
		
		try{ // 에러 날 가능성이 높기때문에 예외처리 필수 트라이 캣치
			Class.forName(driverName); // MySQL 드라이버 클래스 불러오기
			conn = DriverManager.getConnection(url, username, password);
			//conn 커넥션이 메모리에 생성이됨 (DB와의 연결 커넥션 conn 생성)
			stmt = conn.createStatement(); // stmt 객체 생성
			rs = stmt.executeQuery(sql);
			// select문 실행 -> 결과가 DB로부터 반환-> 그 결과(레코드(행))을 받아주는 ResultSet 타입 객체로 받아야함
		//	String sid = null;
				
				if(rs.next()){ // 참이면 레코드가 1개 이상 존재 -> 아이디가 존재
					do { // rs에서 레코드를 추출하는 방법 hasnext
					 	String sid = rs.getString("memberid");
						String spw = rs.getString("memberpw");
						String sname = rs.getString("membername");
						String semail = rs.getString("memberemail");
						String sdate = rs.getString("memberdate");
						
						out.println("******조회 회원 정보*******<br>");
						out.println(sid + " / " + spw + " / " + sname + " / " + semail + " / " + sdate  + "<br>");
						}while(rs.next());
				} else { // 레코드가 0개 일경우 -> 아이디 존재하지않음
					out.println("******정보가 존재하지 않습니다.*******<br>");
				}
				
			//if(sid == null){
				//out.println("******정보가 존재하지 않습니다.*******<br>");
			//}
				
			// int sqlResult = stmt.executeUpdate(sql); // SQL문을 DB에서 실행 -> 성공하면 1이 반환
			//System.out.println("수정된 값 : " + sqlResult);
			//if(sqlResult == 1){ // 1 이 반환되면 삭제 성공
				//out.println(mid + "회원 탈퇴 성공");
			//} else{
				//out.println(mid + "회원 탈퇴 실패 , 존재하지 않는 아이디입니다.");
		//	}
			
		} catch (Exception e) {
			out.println("DB 에러 실패");
			e.printStackTrace(); // 에러 내용 출력
		} finally { // 에러 발생 여부와 상관없이 커넥션 닫아줘야함
			try{
				if(rs != null){
					rs.close();
				}
				if(stmt != null){ // stmt가 null 아니면 닫기 (conn 보다 먼저 실행되어야함)
					stmt.close();
				}
				if(conn != null){ // 커넥션이 null이 아닐때만 닫기
					conn.close();
				}
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		
	%>
</body>
</html>