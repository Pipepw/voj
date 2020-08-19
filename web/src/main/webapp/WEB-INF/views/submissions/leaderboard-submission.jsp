<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<spring:eval expression="@propertyConfigurer.getProperty('url.cdn')" var="cdnUrl" />
<spring:eval expression="@propertyConfigurer.getProperty('build.version')" var="version" />
<!DOCTYPE html>
<html lang="${language}">
<head>
    <meta charset="UTF-8">
    <title>${contest.contestName} <spring:message code="voj.contests.leaderboard.leaderboard" text="Leaderboard" /> | ${websiteName}</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="${description}">
    <meta name="author" content="Haozhe Xie">
    <!-- Icon -->
    <link href="${cdnUrl}/img/favicon.ico?v=${version}" rel="shortcut icon" type="image/x-icon">
    <!-- StyleSheets -->
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/bootstrap.min.css?v=${version}" />
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/bootstrap-responsive.min.css?v=${version}" />
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/flat-ui.min.css?v=${version}" />
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/font-awesome.min.css?v=${version}" />
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/style.css?v=${version}" />
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/submissions/leaderboard.css?v=${version}" />
    <!-- JavaScript -->
    <script type="text/javascript" src="${cdnUrl}/js/jquery-1.11.1.min.js?v=${version}"></script>
    <script type="text/javascript" src="${cdnUrl}/js/bootstrap.min.js?v=${version}"></script>
    <script type="text/javascript" src="${cdnUrl}/js/md5.min.js?v=${version}"></script>
    <!--[if lte IE 9]>
        <script type="text/javascript" src="${cdnUrl}/js/jquery.placeholder.min.js?v=${version}"></script>
    <![endif]-->
    <!--[if lte IE 7]>
        <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/font-awesome-ie7.min.css?v=${version}" />
    <![endif]-->
    <!--[if lte IE 6]>
        <script type="text/javascript"> 
            window.location.href='<c:url value="/not-supported" />';
        </script>
    <![endif]-->
</head>
<body>
    <!-- Header -->
    <%@ include file="/WEB-INF/views/include/header.jsp" %>
    <!-- Content -->
    <div id="content" class="container">
        <div class="row-fluid">
            <div class="span12">
                <div class="leaderboard">
                    <div class="header">
                        AC <spring:message code="voj.contests.leaderboard.leaderboard" text="Leaderboard" />
                    </div> <!-- .header -->
                    <div class="body">
                        <table class="table table-striped">
                            <thead>
                                <th class="rank"><spring:message code="voj.submissions.leaderBoard-submission.rank" text="Rank" /></th>
                                <th class="userName"><spring:message code="voj.submissions.leaderBoard-submission.userName" text="UserName" /></th>
                                <th class="ACProblemNum"><spring:message code="voj.submissions.leaderBoard-submission.ACProblemNum" text="ACProblemNum" /></th>
                                <th class="submissionTimes"><spring:message code="voj.submissions.leaderBoard-submission.submissionTimes" text="submissionTimes" /></th>
                                <th class="ACSubmissionTimes"><spring:message code="voj.submissions.leaderBoard-submission.ACSubmissionTimes" text="ACSubmissionTimes" /></th>
                                <th class="ACRate"><spring:message code="voj.submissions.leaderBoard-submission.ACSubmissionRate" text="AC Rate" /></th>
                            </thead>
                            <tbody>
                            <c:forEach var="submissionRank" items="${submissionRanks}">
                                <tr>
                                    <td class="rank">${submissionRank.userRank}</td>
                                    <td class="userName">${submissionRank.username}</td>
                                    <td class="ACProblemNum">${submissionRank.ACProblemNum}</td>
                                    <td class="submissionTimes">${submissionRank.submissionTimes}</td>
                                    <td class="ACSubmissionTimes">${submissionRank.ACSubmissionTimes}</td>
                                    <td class="ACRate">${submissionRank.ACRate}</td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div> <!-- .body -->
                </div> <!-- .leaderboard -->
            </div> <!-- .span12 -->
        </div> <!-- .row-fluid -->
    </div> <!-- #content -->
    <!-- Footer -->
    <%@ include file="/WEB-INF/views/include/footer.jsp" %>
    <!-- Java Script -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script type="text/javascript" src="${cdnUrl}/js/site.js?v=${version}"></script>
<%--    <script type="text/javascript">--%>
<%--        $(window).scroll(function() {--%>
<%--            var offset = $('table').offset().top - $('thead').outerHeight() - $(window).scrollTop();--%>

<%--            if ( offset <= 0 ) {--%>
<%--                $('thead').css('position', 'fixed');--%>
<%--            <c:forEach var="problem" items="${problems}">--%>
<%--                $('th.problem-${problem.problemId}').width($('td.problem-${problem.problemId}').width());--%>
<%--            </c:forEach>--%>
<%--            } else {--%>
<%--                $('thead').css('position', 'relative');--%>
<%--            }--%>
<%--        });--%>
<%--    </script>--%>
<%--    <c:if test="${GoogleAnalyticsCode != ''}">--%>
<%--    ${googleAnalyticsCode}--%>
<%--    </c:if>--%>
</body>
</html>
