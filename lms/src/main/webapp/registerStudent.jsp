<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>학생 회원가입</title>
    <style>
        /* 전체적인 스타일 */
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f8f8;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        /* 컨테이너 스타일 */
        .container {
            width: 80%;
            max-width: 400px;
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        /* 제목 스타일 */
        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }

        /* 폼 스타일 */
        form {
            display: flex;
            flex-direction: column;
        }

        /* 레이블 스타일 */
        label {
            margin-bottom: 10px;
            color: #333;
        }

        /* 입력 필드 스타일 */
        input[type="text"],
        input[type="password"] {
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }

        /* 버튼 스타일 */
        button,
        input[type="submit"] {
            padding: 10px 20px;
            font-size: 16px;
            color: #fff;
            background-color: #4CAF50;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        /* 버튼 호버 효과 */
        button:hover,
        input[type="submit"]:hover {
            background-color: #45a049;
        }

        /* 링크 스타일 */
        .links {
            text-align: center;
            margin-top: 20px;
        }

        .links a {
            text-decoration: none;
            font-size: 16px;
            color: #333;
            padding: 10px 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            display: inline-block;
            transition: background-color 0.3s ease;
        }

        .links a:hover {
            background-color: #f0f0f0;
        }
    </style>
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
    <div class="container">
        <h2>학생 회원가입</h2>
        <form action="registerStudent" method="post" onsubmit="return validateForm()">
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
        <div class="links">
            <a href="registerTeacher.jsp"><label>교수로 회원가입</label></a>
        </div>
    </div>
</body>
</html>
