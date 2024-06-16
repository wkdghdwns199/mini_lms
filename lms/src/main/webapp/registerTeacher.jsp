<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>교수 회원가입</title>
    <script>
        let isUserIdChecked = false;
        let isUserEmailChecked = false;

        function checkUserId() {
            const userId = document.getElementById("userId").value;
            fetch('checkUserId', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: new URLSearchParams({ userId })
            })
            .then(response => response.json())
            .then(data => {
                if (data.available) {
                    alert("아이디가 사용 가능합니다.");
                    isUserIdChecked = true;
                } else {
                    alert("아이디가 이미 사용 중입니다.");
                    isUserIdChecked = false;
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert("아이디 중복 검사에 실패했습니다.");
            });
        }

        function checkUserEmail() {
            const userEmail = document.getElementById("userEmail").value;
            fetch('checkUserEmail', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: new URLSearchParams({ userEmail })
            })
            .then(response => response.json())
            .then(data => {
                if (data.available) {
                    alert("이메일이 사용 가능합니다.");
                    isUserEmailChecked = true;
                } else {
                    alert("이메일이 이미 사용 중입니다.");
                    isUserEmailChecked = false;
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert("이메일 중복 검사에 실패했습니다.");
            });
        }

        function validateForm() {
            if (!isUserIdChecked) {
                alert("아이디 중복 검사를 완료해주세요.");
                return false;
            }
            if (!isUserEmailChecked) {
                alert("이메일 중복 검사를 완료해주세요.");
                return false;
            }
            const password = document.getElementById("password").value;
            const passwordConfirm = document.getElementById("passwordConfirm").value;
            if (password !== passwordConfirm) {
                alert("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
    <h2>교수로 회원가입</h2>
    <form action="registerTeacher" method="post" onsubmit="return validateForm()">
        <label for="userId">아이디 :</label>
        <input type="text" id="userId" name="userId" required>
        <button type="button" onclick="checkUserId()">아이디 중복 검사</button><br>
        
        <label for="password">비밀번호 :</label>
        <input type="password" id="password" name="password" required><br>
        
        <label for="passwordConfirm">비밀번호 확인 :</label>
        <input type="password" id="passwordConfirm" name="passwordConfirm" required><br>
        
        <label for="userName">이름 :</label>
        <input type="text" id="userName" name="userName" required><br>
        
        <label for="userEmail">이메일 :</label>
        <input type="text" id="userEmail" name="userEmail" required>
        <button type="button" onclick="checkUserEmail()">이메일 중복 검사</button><br>
        
        <input type="submit" value="Register">
    </form>
    <a href="registerStudent.jsp"><label>학생으로 회원가입</label></a>
    <label>교수로 회원가입</label>
</body>
</html>
