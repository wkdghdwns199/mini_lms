<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>To-Do List</title>
    <style>
        /* 모달 스타일 */
        .modal {
            display: none; /* 기본적으로 모달 숨김 */
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgb(0,0,0);
            background-color: rgba(0,0,0,0.4);
        }

        .modal-content {
            background-color: #fefefe;
            margin: 15% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
        }

        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }

        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }

        /* To-Do List 스타일 */
        .todo-container {
            margin: 20px 0;
        }

        .todo-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px;
            border: 1px solid #ccc;
            margin-top: 10px;
        }
    </style>
</head>
<body>

<h2>To-Do List Example</h2>
<button id="openModalBtn">Open To-Do List</button>

<!-- 모달 -->
<div id="todoModal" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <h2>To-Do List</h2>
        <div>
            <input type="text" id="todoInput" placeholder="Enter new task">
            <button id="addTodoBtn">Add Task</button>
        </div>
        <div class="todo-container" id="todoContainer"></div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function() {
        var modal = $("#todoModal");
        var btn = $("#openModalBtn");
        var span = $(".close");
        var todoInput = $("#todoInput");
        var todoContainer = $("#todoContainer");

        // 모달 열기
        btn.click(function() {
            modal.show();
        });

        // 모달 닫기
        span.click(function() {
            modal.hide();
        });

        // 모달 외부 클릭 시 닫기
        $(window).click(function(event) {
            if (event.target.id === "todoModal") {
                modal.hide();
            }
        });

        // To-Do List에 새로운 아이템 추가
        $("#addTodoBtn").click(function() {
            var task = todoInput.val().trim();
            if (task) {
                var todoItem = $("<div class='todo-item'></div>").text(task);
                var deleteBtn = $("<button>Delete</button>").click(function() {
                    $(this).parent().remove();
                });
                todoItem.append(deleteBtn);
                todoContainer.append(todoItem);
                todoInput.val(""); // 입력 필드 초기화
            }
        });
    });
</script>

</body>
</html>
