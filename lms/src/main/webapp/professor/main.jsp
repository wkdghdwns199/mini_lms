<!DOCTYPE html>
<html>
<head>
    <title>Main Page</title>
    <script type="text/javascript">
        function openTodoList() {
            var screenWidth = window.screen.width;
            var screenHeight = window.screen.height;
            var popupUrl = "todo.jsp"; // 팝업으로 열고 싶은 페이지 URL

            // 팝업 창 옵션 설정
            var options = "toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,width=" + screenWidth + ",height=" + screenHeight;
            
            // 팝업 창 열기
            window.open(popupUrl, "popupWindow", options);
        }
    </script>
</head>
<body>
    <h1>Welcome to the Main Page</h1>
    <button onclick="openTodoList()">Open To-Do List</button>
</body>
</html>
