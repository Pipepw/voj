<%@ page import="java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="${language}" />
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:eval expression="@propertyConfigurer.getProperty('url.cdn')" var="cdnUrl" />
<spring:eval expression="@propertyConfigurer.getProperty('build.version')" var="version" />
<!DOCTYPE html>
<html lang="${language}">
<head>
    <meta charset="UTF-8">
    <title><spring:message code="voj.administration.all-contests.title" text="All Problems" /> | ${websiteName}</title>
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
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/administration/style.css?v=${version}" />
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/administration/all-problems.css?v=${version}" />
    <!-- JavaScript -->
    <script type="text/javascript" src="${cdnUrl}/js/jquery-1.11.1.min.js?v=${version}"></script>
    <script type="text/javascript" src="${cdnUrl}/js/bootstrap.min.js?v=${version}"></script>
    <script type="text/javascript" src="${cdnUrl}/js/flat-ui.min.js?v=${version}"></script>
    <script type="text/javascript" src="${cdnUrl}/js/md5.min.js?v=${version}"></script>
    <script type="text/javascript" src="${cdnUrl}/js/pace.min.js?v=${version}"></script>
    <!--[if lte IE 9]>
        <script type="text/javascript" src="${cdnUrl}/js/jquery.placeholder.min.js?v=${version}"></script>
    <![endif]-->
    <!--[if lte IE 7]>
        <script type="text/javascript"> 
            window.location.href='<c:url value="/not-supported" />';
        </script>
    <![endif]-->
</head>
<body>
    <div id="wrapper">
        <!-- Sidebar -->
        <%@ include file="/WEB-INF/views/administration/include/sidebar.jsp" %>
        <div id="container">
            <!-- Header -->
            <%@ include file="/WEB-INF/views/administration/include/header.jsp" %>
            <!-- Content -->
            <div id="content">
                <h2 class="page-header"><i class="fa fa-question-circle"></i> <spring:message code="voj.administration.all-contests.all-contests" text="All Contests" /></h2>
                <div class="alert alert-error hide"></div> <!-- .alert-error -->
                <div id="filters" class="row-fluid">
                    <div class="span4">
                        <div class="row-fluid">
                            <div class="span8">
                                <select id="actions">
                                    <option value="delete"><spring:message code="voj.administration.all-contests.delete" text="Delete" /></option>
                                </select>
                            </div> <!-- .span8 -->
                            <div class="span4">
                                <button class="btn btn-danger"><spring:message code="voj.administration.all-contests.apply" text="Apply" /></button>
                            </div> <!-- .span4 -->
                        </div> <!-- .row-fluid -->
                    </div> <!-- .span4 -->
                    <div class="span8 text-right">
                        <form action="<c:url value="/administration/all-contests" />" method="GET" class="row-fluid">
                            <div class="span5">
                                <div class="control-group">
                                    <input id="keyword" name="keyword" class="span12" type="text" placeholder="<spring:message code="voj.administration.all-contests.keyword" text="Keyword" />" value="${keyword}" />
                                </div> <!-- .control-group -->
                            </div> <!-- .span5 -->
                            <div class="span5">
                                
                            </div> <!-- .span5 -->
                            <div class="span2">
                                <button class="btn btn-primary"><spring:message code="voj.administration.all-contests.filter" text="Filter" /></button>
                            </div> <!-- .span2 -->
                        </form> <!-- .row-fluid -->
                    </div> <!-- .span8 -->
                </div> <!-- .row-fluid -->
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th class="check-box">
                                <label class="checkbox" for="all-contests">
                                    <input id="all-contests" type="checkbox" data-toggle="checkbox">
                                </label>
                            </th>
                            <th class="contest-id">#</th>
                            <th class="contest-name"><spring:message code="voj.administration.all-contests.contest-name" text="Contest Name" /></th>
                            <th class="contest-mode"><spring:message code="voj.administration.all-contests.contest-mode" text="Contest Mode" /></th>
                            <th class="contest-start-time"><spring:message code="voj.administration.all-contests.contest-start-time" text="Start Time" /></th>
                            <th class="contest-tags"><spring:message code="voj.administration.all-contests.contest-end-time" text="End Time" /></th>
                            <th class="contest-tags"><spring:message code="voj.administration.all-contests.contest-status" text="Contest Status" /></th>
                            <th class="total-submission"><spring:message code="voj.administration.all-contests.total-submissions" text="Total Submissions" /></th>
                            <th class="high-scores"><spring:message code="voj.administration.all-contests.contest-high-scores" text="High Scores" /></th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="contest" items="${contests}">
                        <tr data-value="${contest.contestId}">
                            <td class="check-box">
                                <label class="checkbox" for="contest-${contest.contestId}">
                                    <input id="contest-${contest.contestId}" type="checkbox" value="${contest.contestId}" data-toggle="checkbox" />
                                </label>
                            </td>
                            <td class="contest-id">
                                <a href="<c:url value="/administration/edit-contest/${contest.contestId}" />">${contest.contestId}</a>
                            </td>
                            <td class="contest-name">${contest.contestName}</td>
                            <td class="contest-mode">${contest.contestMode}</td>
                            <td class="contest-start-time"><fmt:formatDate value="${contest.startTime}" dateStyle="long" timeStyle="medium"/></td>
                            <td class="contest-end-time"><fmt:formatDate value="${contest.endTime}" dateStyle="long" timeStyle="medium"/></td>
                            <td class="contest-status">
                                <c:choose>
                                    <c:when test="${currentTime.before(contest.startTime)}">
                                        <c:set var="contestStatus" value="Ready" />
                                    </c:when>
                                    <c:when test="${currentTime.after(contest.endTime)}">
                                        <c:set var="contestStatus" value="Done" />
                                    </c:when>
                                    <c:when test="${currentTime.after(contest.startTime) and currentTime.before(contest.endTime)}">
                                        <c:set var="contestStatus" value="Live" />
                                    </c:when>
                                </c:choose>
                                ${contestStatus}
                            </td>
                            <td class="total-submission">${contest.totalContestContestant}</td>
                            <td class="high-scores">${contest.highScores}</td>
                        </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <div id="pagination" class="pagination pagination-centered">
                    <c:set var="lowerBound" value="${currentPage - 5 > 0 ? currentPage - 5 : 1}" />
                    <c:set var="upperBound" value="${currentPage + 5 < totalPages ? currentPage + 5 : totalPages}" />
                    <c:set var="baseUrl" value="/administration/all-contests?keyword=${keyword}&contestCategory=${selectedProblemCategory}" />
                    <ul>
                        <li class="previous <c:if test="${currentPage <= 1}">disabled</c:if>">
                        <a href="
                        <c:choose>
                            <c:when test="${currentPage <= 1}">javascript:void(0);</c:when>
                            <c:otherwise><c:url value="${baseUrl}&page=${currentPage - 1}" /></c:otherwise>
                        </c:choose>
                        ">&lt;</a>
                        </li>
                        <c:forEach begin="${lowerBound}" end="${upperBound}" var="pageNumber">
                        <li <c:if test="${pageNumber == currentPage}">class="active"</c:if>><a href="<c:url value="${baseUrl}&page=${pageNumber}" />">${pageNumber}</a></li>
                        </c:forEach>
                        <li class="next <c:if test="${currentPage >= totalPages}">disabled</c:if>">
                        <a href="
                        <c:choose>
                            <c:when test="${currentPage >= totalPages}">javascript:void(0);</c:when>
                            <c:otherwise><c:url value="${baseUrl}&page=${currentPage + 1}" /></c:otherwise>
                        </c:choose>
                        ">&gt;</a>
                        </li>
                    </ul>
                </div> <!-- #pagination-->
            </div> <!-- #content -->
        </div> <!-- #container -->
    </div> <!-- #wrapper -->
    <!-- Java Script -->
    <!-- Placed at the end of the document so the pages load faster -->
    <%@ include file="/WEB-INF/views/administration/include/footer-script.jsp" %>
    <script type="text/javascript">
        $('label[for=all-contests]').click(function() {
            // Fix the bug for Checkbox in FlatUI 
            var isChecked = false;
            setTimeout(function() {
                isChecked = $('label[for=all-contests]').hasClass('checked');
                
                if ( isChecked ) {
                    $('label.checkbox').addClass('checked');
                } else {
                    $('label.checkbox').removeClass('checked');
                }
            }, 100);
        });
    </script>
    <script type="text/javascript">
        $('button.btn-danger', '#filters').click(function() {
            if ( !confirm('<spring:message code="voj.administration.all-contests.continue-or-not" text="Are you sure to continue?" />') ) {
                return;
            }
            $('.alert-error').addClass('hide');
            $('button.btn-danger', '#filters').attr('disabled', 'disabled');
            $('button.btn-danger', '#filters').html('<spring:message code="voj.administration.all-contests.please-wait" text="Please wait..." />');

            var contests    = [],
                action      = $('#actions').val();

            $('label.checkbox', 'table tbody').each(function() {
                if ( $(this).hasClass('checked') ) {
                    var contestId = $('input[type=checkbox]', $(this)).val();
                    contests.push(contestId);
                }
            });

            if ( action == 'delete' ) {
                return doDeleteProblemsAction(contests);
            }
        });
    </script>
    <script type="text/javascript">
        function doDeleteProblemsAction(contests) {
            var postData = {
                'contests': JSON.stringify(contests)
            };

            $.ajax({
                type: 'POST',
                url: '<c:url value="/administration/deleteContests.action" />',
                data: postData,
                dataType: 'JSON',
                success: function(result){
                    if ( result['isSuccessful'] ) {
                        for ( var i = 0; i < contests.length; ++ i ) {
                            $('tr[data-value=%s]'.format(contests[i])).remove();
                        }
                    } else {
                        $('.alert').html('<spring:message code="voj.administration.all-contests.delete-error" text="Some errors occurred while deleting contests." />');
                        $('.alert').removeClass('hide');
                    }
                    $('button.btn-danger', '#filters').removeAttr('disabled');
                    $('button.btn-danger', '#filters').html('<spring:message code="voj.administration.all-contests.apply" text="Apply" />');
                }
            });
        }
    </script>
</body>
</html>