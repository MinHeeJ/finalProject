<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ include file="/WEB-INF/views/common/adminLeftBar.jsp"%>
<section>
    <div class="card" style="margin: 30px 0 0 330px; width: 1300px; height: fit-content">
        <div class="card-header" id="todayIssueHeader">
            직원 목록 
            <input id="findById" placeholder="아이디 검색" style="float: right;">
            <input id="findByName" style="float: right" placeholder="이름 검색">
        </div>
        <div class="card-body" id="todayIssueBody">
            <table class="table table-hover text-center">
                <thead>
                    <tr>
                        <th scope="col">ID</th>
                        <th scope="col">이름</th>
                        <th scope="col">전화번호</th>
                        <th scope="col">Email</th>
                        <th scope="col">쪽지보내기</th>
                    </tr>
                </thead>
                <tbody id="membersTableBody">
                    <c:if test="${empty members}">
                        <tr>
                            <td colspan="5" class="text-center">조회된 직원이 없습니다.</td>
                        </tr>
                    </c:if>
                    <c:if test="${not empty members}">
                        <c:forEach items="${members}" var="member" varStatus="vs">
                            <tr data-bs-toggle="modal" data-bs-target="#myModal"
                                data-row-id="1" data-first-id="${member.memberId}"
                                data-second-name="${member.memberName}"
                                data-phone="${member.memberPhone}"
                                data-birthday="${member.birthday}"
                                data-email="${member.memberEmail}" data-handle="@mdo">
                                <td>${member.memberId}</td>
                                <td>${member.memberName}</td>
                                <td>${member.memberPhone}</td>
                                <td>${member.memberEmail}</td>
                                <td>
                                    <button style="border: 0; background-color: transparent;">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                            fill="currentColor" class="bi bi-send" viewBox="0 0 16 16">
                                            <path
                                                d="M15.854.146a.5.5 0 0 1 .11.54l-5.819 14.547a.75.75 0 0 1-1.329.124l-3.178-4.995L.643 7.184a.75.75 0 0 1 .124-1.33L15.314.037a.5.5 0 0 1 .54.11ZM6.636 10.07l2.761 4.338L14.13 2.576 6.636 10.07Zm6.787-8.201L1.591 6.602l4.339 2.76 7.494-7.493Z" />
                                        </svg>
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:if>
                </tbody>
            </table>
            <br>
        </div>
    </div>
    <div class="modal fade" id="myModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-xl" style="width: 1200px;">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">상세 정보</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6">
                            <iframe src="${pageContext.request.contextPath}/resources/pdf/쓰리고근로계약서.pdf"
                                style="width: 100%; height: 500px;"></iframe>
                        </div>
                        <div class="col-md-6">
                            <form id="dataForm" method="post" action="process_form.jsp" style="font-size: 20px;">
                                <input type="hidden" name="rowId" id="modalRowId"> ID :
                                <input type="text" name="firstId" id="modalFirstId" readonly>
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br> 부서 : <input type="text" name="secondName"
                                    id="modalSecondName" readonly> <br> 연락처 : <input type="text" name="phone"
                                    id="modalPhone" readonly> <br> Email : <input type="text" name="email" id="modalEmail"
                                    readonly> <br> 생년월일 : <input type="date" name="birthday" id="modalBirthday"
                                    readonly> <br>
                                <hr>
                                <button type="button" id="btnEdit">수정</button> &nbsp;&nbsp;&nbsp;|&nbsp;&nbsp; <button
                                    type="button" id="btnBan">강퇴</button>
                            </form>
                        </div>
                    </div>
                </div>
                <!-- 모달의 나머지 부분은 동일하게 유지 -->
            </div>
        </div>
    </div>
</section>

<script>
const contextPath = '${pageContext.request.contextPath}';

document.addEventListener("DOMContentLoaded", function () {
    const findByIdInput = document.getElementById('findById');
    findByIdInput.addEventListener('keyup', function (event) {
        if (event.key === 'Enter') {
            handleIdSubmit();
        }
    });

    // ...
});

function handleIdSubmit() {
    const findById = document.getElementById('findById').value;
    $.ajax({
        type: 'GET',
        url: contextPath + '/admin/findById.do',
        data: { id: findById },
        success: function (response) {
            console.log(response);
            if (response && response.memberId) {
                const member = [response];
                updateMembersTable(member);
            } else {
                console.log("No member found.");
            }
        }
    });
}

function updateMembersTable(member) {
    const tableBody = document.querySelector("#membersTableBody");
    
    // 기존 테이블 내용을 지우지 않고 기존 행을 업데이트
    tableBody.innerHTML = ''; // 기존 내용을 초기화
    
    	const newRow = `
            <tr data-bs-toggle="modal" data-bs-target="#myModal"
                data-row-id="1" data-first-id="${member.memberId}"
                data-second-name="${member.memberName}"
                data-phone="${member.memberPhone}"
                data-birthday="${member.birthday}"
                data-email="${member.memberEmail}" data-handle="@mdo">
                <td>${member.memberId}</td>
                <td>${member.memberName}</td>
                <td>${member.memberPhone}</td>
                <td>${member.memberEmail}</td>
                <td>
                    <button style="border: 0; background-color: transparent;">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                            fill="currentColor" class="bi bi-send" viewBox="0 0 16 16">
                            <path
                                d="M15.854.146a.5.5 0 0 1 .11.54l-5.819 14.547a.75.75 0 0 1-1.329.124l-3.178-4.995L.643 7.184a.75.75 0 0 1 .124-1.33L15.314.037a.5.5 0 0 1 .54.11ZM6.636 10.07l2.761 4.338L14.13 2.576 6.636 10.07Zm6.787-8.201L1.591 6.602l4.339 2.76 7.494-7.493Z" />
                        </svg>
                    </button>
                </td>
            </tr>
        `;
        tableBody.innerHTML += newRow;
}
      document.addEventListener("DOMContentLoaded", function () {
        const tableRows = document.querySelectorAll("tr[data-bs-toggle='modal']");
    
        tableRows.forEach((row) => {
          row.addEventListener("click", function () {
            const rowId = row.getAttribute("data-row-id");
            const firstId = row.getAttribute("data-first-id");
            const secondName = row.getAttribute("data-second-name");
            const phone = row.getAttribute("data-phone");
            const birthday = row.getAttribute("data-birthday");
            const email = row.getAttribute("data-email");
            const subject = row.getAttribute("data-subject");
            const className = row.getAttribute("data-class");
            const lastDay = row.getAttribute("data-lastDay");
            const handle = row.getAttribute("data-handle");
    
            // 모달 내의 입력 필드에 데이터 설정
            document.getElementById("modalRowId").value = rowId;
            document.getElementById("modalFirstId").value = firstId;
            document.getElementById("modalSecondName").value = secondName;
            document.getElementById("modalPhone").value = phone;
            document.getElementById("modalBirthday").value = birthday;
            document.getElementById("modalEmail").value = email;
            document.getElementById("modalSubject").value = subject;
            document.getElementById("modalClass").value = className;
            document.getElementById("modalLastDay").value = lastDay;
            document.getElementById("modalHandle").value = handle;
          });
        });
    
        // 수정 버튼 클릭 이벤트 처리
        $("#btnEdit").on("click", function () {
          showConfirmation("edit", "edit_process.jsp");
        });
    
        // 강퇴 버튼 클릭 이벤트 처리
        $("#btnBan").on("click", function () {
          showConfirmation("ban", "ban_process.jsp");
        });
    
        // 확인 메시지 표시 후 데이터 전송 함수 호출
        function showConfirmation(action, url) {
          if (confirm("정말로 진행하시겠습니까?")) {
            sendDataToServer(action, url);
          }
        }
    
        // 서버로 데이터를 전송하는 함수
        function sendDataToServer(action, url) {
          const formData = new FormData($("#dataForm")[0]);
          formData.append("action", action);
    
          $.ajax({
            type: "POST",
            url: url, // 수정 또는 강퇴에 따라 다른 URL 지정
            data: formData,
            processData: false,
            contentType: false,
            success: function (response) {
              // 서버 응답을 처리
              // 예: 성공 메시지를 표시하거나 다른 동작 수행
            }
          });
        }
      });
    </script>
<footer></footer>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
	crossorigin="anonymous"></script>
<script>
      $(function(){
        var accordionButton = $('.list .items > .a_title');
        accordionButton.on('click', function(e){
          e.preventDefault();
          var $this = $(this);
          var target = $this.parent();
          var description = $this.siblings('.a_content');
          var other = target.siblings('.items');
          var otherDescription = other.find('.a_content');
          accordionToggle(target, description, other, otherDescription);
        });
        
        function accordionToggle(target, description, other, otherDescription){
          if (target.hasClass('active')) {
              target.removeClass('active');
              description.stop().slideUp(300);
          } else {
              target.addClass('active');
              description.stop().slideDown(300);
          }
          if (other && otherDescription) {
              other.removeClass('active');
              otherDescription.stop().slideUp(300);
          }
        };
      });
    </script>
</body>
</html>