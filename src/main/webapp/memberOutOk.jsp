<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 탈퇴 처리 </title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
		
		String mid = request.getParameter("outid"); // 탈퇴할 아이디
		
		// DB 에 삽입할 데이터 준비 완료
	
		
		// DB 커넥션 준비
		
		String driverName = "com.mysql.jdbc.Driver"; // MySQL 의 JDBC 드라이버 이름
		String url = "jdbc:mysql://localhost:3306/jspdb"; //MySQL이 설치된 서버의 주소(IP)와 연결할 DB(스키마) 이름
		// jdbc:mysql://172.30.1.55:3306 강사님 주소
		String username = "root"; // DB 로그인한 아이디
		String password = "12345"; // DB 비밀번호

		//SQL문 제작 
		String sql = "DELETE FROM members WHERE memberid = '"+mid+"'";
		//MySQL에서 이해할 수 있는 문법으로 작성해야함
		
		Connection conn = null; // 커넥션 인터페이스로 선언 후 null로 초기값 선언
		Statement stmt = null; // sql문을 관리해주는 객체를 선언해주는 인터페이스로 stmt 선언
		
		try{ // 에러 날 가능성이 높기때문에 예외처리 필수 트라이 캣치
			Class.forName(driverName); // MySQL 드라이버 클래스 불러오기
			conn = DriverManager.getConnection(url, username, password);
			//conn 커넥션이 메모리에 생성이됨 (DB와의 연결 커넥션 conn 생성)
			stmt = conn.createStatement(); // stmt 객체 생성
			
			int sqlResult = stmt.executeUpdate(sql); // SQL문을 DB에서 실행 -> 성공하면 1이 반환
			System.out.println("수정된 값 : " + sqlResult);
			if(sqlResult == 1){ // 1 이 반환되면 삭제 성공
				out.println(mid + "회원 탈퇴 성공");
			} else{
				out.println(mid + "회원 탈퇴 실패 , 존재하지 않는 아이디입니다.");
			}
			
		} catch (Exception e) {
			out.println("DB 에러났다요 회원 가입 실패 ㅋㅋㅋㅋㅋ");
			e.printStackTrace(); // 에러 내용 출력
		} finally { // 에러 발생 여부와 상관없이 커넥션 닫아줘야함
			try{
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