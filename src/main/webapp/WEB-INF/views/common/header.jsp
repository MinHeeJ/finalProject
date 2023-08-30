<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!-- bootstrap icon css -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">

<%-- 글작성 아이콘 --%>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" />

<style>
.new {
	text-decoration: none;
}
</style>



<!DOCTYPE html>
<html lang="ko">
<head>
<link rel="stylesheet"
	href="${ pageContext.request.contextPath }/resources/css/style.css" />
<title>KH소통할까?</title>
<meta charset="utf-8">
<meta name="referrer" content="origin">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<%-- 
<link type="text/css" href="/css/common.css" rel="stylesheet">
<link type="text/css" href="/css/common.partial.css" rel="stylesheet">
<link type="text/css" href="/css/container.community.css" 
--%>
	
<link href="/favicon.ico" rel="shortcut icon">
	<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/style.css" />
    <title>KH소통할까?</title>
    <meta charset="utf-8">
    <meta name="referrer" content="origin">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <%-- 
    <link type="text/css" href="/css/common.css" rel="stylesheet">
    <link type="text/css" href="/css/common.partial.css" rel="stylesheet">
    <link type="text/css" href="/css/container.community.css" rel="stylesheet"> 
    --%>
    <link href="/favicon.ico" rel="shortcut icon">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<c:if test="${not empty message }">
	<script>
		alert('${message}'); 
	</script>
</c:if>

<%-- codemirror js --%>
<script src="${ pageContext.request.contextPath }/resources/js/codemirror-5.65.14/lib/codemirror.js"></script>
<%-- codemirror sql.js addon --%>
<script src="${ pageContext.request.contextPath }/resources/js/codemirror-5.65.14/mode/sql/sql.js"></script>
<script src="${ pageContext.request.contextPath }/resources/js/codemirror-5.65.14/mode/clike/clike.js"></script>
<script src="${ pageContext.request.contextPath }/resources/js/codemirror-5.65.14/mode/javascript/javascript.js"></script>
<script src="${ pageContext.request.contextPath }/resources/js/codemirror-5.65.14/mode/htmlmixed/htmlmixed.js"></script>
<%-- codemirror css --%>
<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/js/codemirror-5.65.14/lib/codemirror.css">
<%-- codemirror theme --%>
<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/js/codemirror-5.65.14/theme/eclipse.css">
<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/js/codemirror-5.65.14/theme/dracula.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.1/sockjs.min.js" integrity="sha512-1QvjE7BtotQjkq8PxLeF6P46gEpBRXuskzIVgjFpekzFVF4yjRgrQvTG1MTOJ3yQgvTteKAcO7DSZI92+u/yZw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js" integrity="sha512-iKDtgDyTHjAitUDdLljGhenhPwrbBfqTKWO1mkhSFH3A7blITC9MhYon6SjnMhp4o0rADGw9yAC6EW4t5a4K3g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
</head>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/showForm.js"></script>
    <body>
    <nav>
        <div class="wrap">
            <div id="logo">
               <a href="${pageContext.request.contextPath}/"><img src="${pageContext.request.contextPath}/resources/images/로고.png"
                        style="width: 160px; height: 100px; z-index: 1; margin-top: -74%; margin-left: 27%;"></a>
            </div>
            <div id="account">
            	<sec:authorize access="hasAuthority('ADMIN')">
	            	<a href="${pageContext.request.contextPath}/admin/adminMain.do" target="_blank" style="text-decoration: none; width:60px; font-size: 1px;">
	            		관리자페이지
	            	</a>
            	</sec:authorize>
               <a href="${pageContext.request.contextPath}/member/memberLogin.do" title="로그인" class="icon message">로그인</a>
               <a href="${pageContext.request.contextPath}/member/memberCreate.do" title="회원가입" class="icon my">회원가입</a>

            </div>
            <ul id="menu">
                <li><a href="${pageContext.request.contextPath}" style="text-decoration: none;" style="text-decoration: none;">게시판</a></li>
                <li><a href="${pageContext.request.contextPath}/board/noticeBoardList.do" style="text-decoration: none;">공지사항</a></li>
                <li id="myClass"><a>우리반</a></li>
                <li><a href="${pageContext.request.contextPath}/board/jobSearchBoardList.do" style="text-decoration: none;">취업</a></li>
                <li><a href="${pageContext.request.contextPath}/store/storeList.do" style="text-decoration: none;">식권</a></li>
                <li><a href="${pageContext.request.contextPath}/board/promotionBoardList.do" style="text-decoration: none;">홍보</a></li>
                <li><a href="${pageContext.request.contextPath}/calendar/calendar.do?method=list" style="text-decoration: none;">스케쥴</a></li>
            </ul>
        </div>
    </nav>
    <div id="submenu">
    <!-- style="display: none;" -->
		<div class="wrap" id="boardSubmenu">
			<div class="divider"></div>
			<div class="group">
				<ul>
					<li><a
						href="${pageContext.request.contextPath}/board/freeBoardList.do"
						class="new" style="text-decoration: none;">자유게시판</a></li>
					<li><a
						href="${pageContext.request.contextPath}/board/marketBoardList.do"
						class="new"style="text-decoration: none;"> 장터게시판</a></li>
					<li><a
						href="${pageContext.request.contextPath}/board/todayFoodBoardList.do"
						class="new" style="text-decoration: none;">오늘 뭐 먹지?</a></li>
				</ul>

			</div>
			<div class="divider"></div>
			<div class="group">
				<ul>
				<li><a href="${pageContext.request.contextPath}/board/sharingInformationBoardList.do" class="new" style="text-decoration: none;">정보공유</a></li>
				<li><a href="${pageContext.request.contextPath}/board/askCodeBoardList.do" class="new" style="text-decoration: none;">코드질문</a></li>
				<li><a href="${pageContext.request.contextPath}/board/studyBoardList.do" class="new" style="text-decoration: none;">스터디</a></li>
				</ul>
			</div>
			<div class="divider"></div>
			<div class="group">
				<ul>
				<li><a href="${pageContext.request.contextPath}/board/graduateBoardList.do" class="new" style="text-decoration: none;">수료생게시판</a></li>
				<li><a href="${pageContext.request.contextPath}/board/preStudentBoardList.do" class="new" style="text-decoration: none;">예비생게시판</a></li>
				<li><a href="${pageContext.request.contextPath}/board/employeeBoardList.do" class="new" style="text-decoration: none;">직원 게시판</a></li>
				</ul>
			</div>
			<div class="divider"></div>
			<hr>
		</div>
	</div>
	<div id="jangjun">
	<sec:authentication property="principal" var="loginMember" />
	<script>
	document.querySelector('#myClass').addEventListener('click', () => {
		const _memberId = '<sec:authentication property="name"/>';
 	    const memberId = _memberId.replace(/&#64;/g, '@');
	    if(_memberId === 'anonymousUser') {
	        alert('로그인이 필요합니다.');
	    }
        else {
	        $.ajax({
	           url : "${pageContext.request.contextPath}/member/findStudentType.do",
	           data : {
	               memberId : memberId
	           },
	           success(responseData) {
	               const {student} = responseData;
	               const {curriculumId, studentType, boardId} = student;
	               if(studentType != 's' || boardId == 0) {
	                   alert('수강중인 학생만 이용가능합니다.');
	               }
	               else {
	                   window.location.href = "${pageContext.request.contextPath}/board/myClassBoardList.do?boardId=" + boardId;
	               }
	           }
	        });
        }
   });
	</script>
	<sec:authorize access="isAuthenticated()">
		<script>
			const memberId = '<sec:authentication property="principal.username"/>';
			
			const ws = new SockJS(`http://localhost:8080/kh/ws`); // endpoint
			const stompClient = Stomp.over(ws);
		
			stompClient.connect({}, (frame) => {
				console.log('open : ', frame);
				
				// 구독신청 
				stompClient.subscribe(`/topic/msgnotice/${memberId}`, (message) => {
					console.log(`/topic/msgnotice/${memberId} : `, message);
					renderMessage(message);
				});
			});
			
			const renderMessage = (message) => {
				const {type, from, to, content, createdAt} = JSON.parse(message.body);
				console.log(type, from, to, content, createdAt);
				
				
			}
			
		</script>
		
	</sec:authorize>
	