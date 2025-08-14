<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JDBC 연결 테스트</title>
</head>
<body>
	<%
		String driverName = "com.mysql.jdbc.Driver"; // MySQL 의 JDBC 드라이버 이름
		String url = "jdbc:mysql://localhost:3306/jspdb"; //MySQL이 설치된 서버의 주소(IP)와 연결할 DB(스키마) 이름
		// jdbc:mysql://172.30.1.55:3306 강사님 주소
		String username = "root";
		String password = "12345";
		
		
		Connection conn = null; // 커넥션 인터페이스로 선언 후 null로 초기값 선언
		
		try{ // 에러 날 가능성이 높기때문에 예외처리 필수 트라이 캣치
			Class.forName(driverName); // MySQL 드라이버 클래스 불러오기
			conn = DriverManager.getConnection(url, username, password);
			//conn 커넥션이 메모리에 생성이됨 (DB와의 연결 커넥션 conn 생성)
			out.println(conn); // 커넥션이 성공적으로 생성이 되었을때 -> 커넥션 이름 출력
		} catch (Exception e) {
			out.println("DB 커넥션 생성 실패 ㅋ");
			e.printStackTrace(); // 에러 내용 출력
		} finally { // 에러 발생 여부와 상관없이 커넥션 닫아줘야함
			try{
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