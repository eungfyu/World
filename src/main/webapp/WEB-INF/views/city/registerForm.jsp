<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %><!-- 다국어처리 -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %><!-- 폼처리, 에러처리 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>registerForm.jsp</title>

<%@ include file="/WEB-INF/views/common.jspf" %>

<style type="text/css">
	.form-center{
		border: 1px solid orange;
		border-radius: 10px;
		width: 400px;
		padding: 10px;
		margin-left: 50px;
	}
	.box {
		width: 100px;
		height: 100px;
		border-radius: 10px;
		background-color: crimson;
	}
</style>
</head>
<body>
<h1><spring:message code="city.register.title" arguments="[World]"/></h1><!-- 아규먼트:메시지 파라미터. []오브젝트 배열 -->
<form:form commandName="city" action="register" method="post" cssClass="form-center">

	<!-- 글로벌 에러가 있다면 출력한다. -->
	<div class="text-danger text-center">
		<form:errors/>
	</div>
	
	<!-- city.name -->
	<div class="form-group">
		<label for="name"><spring:message code="city.name"/></label>
		<form:input path="name" cssClass="form-control"/>
		<form:errors path="name" cssClass="text-primary bg-danger"/>
	</div>

	<!-- city.countryCode -->
	<div class="form-group">
		<label for="countryCode"><spring:message code="city.countryCode"/></label>
<%-- 		<form:input path="countryCode" cssClass="form-control"/> --%>
		<form:select path="countryCode" cssClass="form-control">
			<form:option value="">-- 선택 --</form:option>
			<form:options items="${countryCode}" itemValue="code" itemLabel="name"/>
		</form:select>
		<form:errors path="countryCode" cssClass="text-primary bg-danger"/>
	</div>

	<!-- city.district -->
	<div>
		<label for="district"><spring:message code="city.district"/></label>
<%-- 		<form:input path="district" cssClass="form-control"/> --%>
		<form:select path="district" cssClass="form-control">
			<form:option value="">-- 선택 --</form:option>
			<form:options items="${districts}" />
		</form:select>
		<form:errors path="district" cssClass="text-primary bg-danger"/>
	</div>
	
	<!-- city.population -->
	<div>
		<label for="population"><spring:message code="city.population"/></label>
		<form:input path="population" cssClass="form-control"/>
		<form:errors path="population" cssClass="text-primary bg-danger"/><!-- population에 바인딩된 에러가 있다면 출력한다 -->
	</div>

	<!-- Submit -->
	<input class="btn btn-primary" type="submit" value="도시추가"/>

</form:form>

<c:forEach var="i" begin="0" end="10">
	<div class="box"><strong>${i}</strong></div>
</c:forEach>

<!-- 	jQuery()를 얼라이언스 해놓은게 $()임.  $('.box') 와 jQuery('.box')는 같다 -->
<script type="text/javascript">
	var form = jQuery('.form-center');
	form.draggable();
	form.mousedown(function() {
		console.log("form.mousedown()...");
		$(this).css('box-shadow','20px 20px 10px orange');
	});
	
	form.mouseup(function() {
		console.log("form.mouseup()...");
		$(this).css('box-show', '10px 10px');
	});
	
	$('.box').draggable();
	
	$('#countryCode').change(function() {
// 		alert("change event-called...value = " + $(this).val());
		var countryCode = $(this).val();
		console.log("change event called..value = " + countryCode);
		
		//Ajax(Asyncronous javascript and XML 비동기자바스크립트)
		$.get('district/'+countryCode, function(data, status) {
			console.log("data = "+data+"\n"+"status="+status);
			$('#district').html(data);
		});
	});//change()는 익명의 무명클래스. change이벤트 발생시 펑션 실행됨. 이건 이벤트 처리임
	
</script>
</body>
</html>