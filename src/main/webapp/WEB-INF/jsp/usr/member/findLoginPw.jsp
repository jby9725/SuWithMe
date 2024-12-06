<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="비밀번호 찾기"></c:set>
<%@ include file="../common/head_NonOption.jspf"%>

<!-- 배경 -->
<div id="background" style="position: fixed; width: 100%; height: 100%; top: 0; left: 0; z-index: -1;"></div>

<section class="mt-8 text-xl px-4">
    <div class="mx-auto">
        <h1>비밀번호 찾기</h1>
        <!-- 에러 메시지 -->
        <c:if test="${not empty msg}">
            <p style="color: red;">${msg}</p>
        </c:if>

        <!-- 비밀번호 찾기 폼 -->
        <form action="/usr/member/doFindLoginPw" method="POST">
            <div>
                <label for="loginId">아이디</label>
                <input type="text" id="loginId" name="loginId" placeholder="아이디를 입력해주세요" required>
            </div>
            <div>
                <label for="email">이메일</label>
                <input type="text" id="email" name="email" placeholder="이메일을 입력해주세요" required>
            </div>
            <button type="submit">임시 비밀번호 발급</button>
        </form>
    </div>
</section>

<%@ include file="../common/foot.jspf"%>