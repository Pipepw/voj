<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:eval expression="@propertyConfigurer.getProperty('url.cdn')" var="cdnUrl" />
<spring:eval expression="@propertyConfigurer.getProperty('build.version')" var="version" />
<!DOCTYPE html>
<html lang="${language}">
<head>
    <meta charset="UTF-8">
    <title><spring:message code="voj.index.title" text="Home" /> | ${websiteName}</title>
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
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/misc/homepage.css?v=${version}" />
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
    <div id="content">
        <div id="introduction" class="carousel slide">
            <ol class="carousel-indicators">
<%--                <li data-target="#introduction" data-slide-to="0" class="active"></li>--%>
<%--                <li data-target="#introduction" data-slide-to="1"></li>--%>
<%--                <li data-target="#introduction" data-slide-to="2"></li>--%>
                    <li data-target="#introduction" data-slide-to="0" class="active"></li>
            </ol>
            <div class="carousel-inner">
                <div class="active item first"></div>
<%--                <div class="item second"></div>--%>
<%--                <div class="item third"></div>--%>
            </div>
        </div> <!-- #introduction -->
        <div id="slogan" class="row-fluid">
            <div class="container">
                <div class="span5 offset7">
                    <h2><spring:message code="voj.index.slogan" text="Start Your OJ Journey Today!" /></h2>
                    <c:choose>
                    <c:when test="${!isLogin}">
                        <p><button class="btn btn-success" onclick="window.location.href='<c:url value="/accounts/register" />'"><spring:message code="voj.index.create-account" text="Create Account" /></button></p>
                        <p><a href="<c:url value="/accounts/login" />"><spring:message code="voj.index.login" text="Sign In" /></a></p>
                    </c:when>
                    <c:otherwise>
                        <p><button class="btn btn-success" onclick="window.location.href='<c:url value="/p" />'"><spring:message code="voj.index.get-started" text="Get Started Now" /></button></p>
                    </c:otherwise>
                    </c:choose>
                </div> <!-- .span6 -->
            </div> <!-- .container -->
        </div> <!-- #slogan -->
        <div class="row-fluid container">
            <div id="main-content" class="span8">
                <div id="contests">
                    <table class="table">
                        <tbody>
                            <c:forEach var="contest" items="${contests}">
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
                            <tr class="contest ${contestStatus}">
                                <td class="overview">
                                    <h5><a href="<c:url value="/contest/${contest.contestId}" />">${contest.contestName}</a></h5>
                                    <ul class="inline">
                                        <li>${contest.contestMode}</li>
                                        <li><spring:message code="voj.index.start-time" text="Start Time" />: <fmt:formatDate value="${contest.startTime}" type="both" dateStyle="long" timeStyle="medium" /></li>
                                        <li><spring:message code="voj.index.end-time" text="End Time" />: <fmt:formatDate value="${contest.endTime}" type="both" dateStyle="long" timeStyle="medium" /></li>
                                    </ul>
                                </td>
                                <td class="status">${contestStatus}</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div> <!-- #contests -->
                <c:if test="${discussionThreads != null and discussionThreads.size() > 0}">
                <div id="discussion">
                    <table class="table">
                        <tbody>
                        <c:forEach var="discussionThread" items="${discussionThreads}">
                            <tr class="discussion-thread">
                                <td class="avatar" data-value="${fn:toLowerCase(discussionThread.discussionThreadCreator.email)}">
                                    <img src="${cdnUrl}${discussionThread.discussionThreadCreator.avatarUrl}?v=${version}" alt="avatar" />
                                </td>
                                <td class="overview">
                                    <h5><a href="<c:url value="/discussion/" />${discussionThread.discussionThreadId}">${discussionThread.discussionThreadTitle}</a></h5>
                                    <ul class="inline">
                                        <li>
                                            <spring:message code="voj.index.author" text="Author" />: 
                                            <a href="<c:url value="/accounts/user/" />${discussionThread.discussionThreadCreator.uid}">${discussionThread.discussionThreadCreator.username}</a>
                                        </li>
                                        <li>
                                            <spring:message code="voj.index.posted-in" text="Posted in" />: 
                                        <c:choose>
                                        <c:when test="${discussionThread.problem == null}">
                                            <a href="<c:url value="/discussion?topicSlug=" />${discussionThread.discussionTopic.discussionTopicSlug}">${discussionThread.discussionTopic.discussionTopicName}</a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="<c:url value="/p/" />${discussionThread.problem.problemId}">P${discussionThread.problem.problemId}: ${discussionThread.problem.problemName}</a>
                                        </c:otherwise>
                                        </c:choose>
                                        </li>
                                        <li>
                                            <spring:message code="voj.index.latest-reply" text="Latest reply" />:
                                        <c:choose>
                                        <c:when test="${discussionThread.latestDiscussionReply == null}">
                                            <a href="<c:url value="/accounts/user/" />${discussionThread.discussionThreadCreator.uid}">${discussionThread.discussionThreadCreator.username}</a> 
                                            @<span class="reply-datetime"><fmt:formatDate value="${discussionThread.discussionThreadCreateTime}" pattern="yyyy-MM-dd HH:mm:ss" /></span>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="<c:url value="/accounts/user/" />${discussionThread.latestDiscussionReply.discussionReplyCreator.uid}">${discussionThread.latestDiscussionReply.discussionReplyCreator.username}</a> 
                                            @<span class="reply-datetime"><fmt:formatDate value="${discussionThread.latestDiscussionReply.discussionReplyCreateTime}" pattern="yyyy-MM-dd HH:mm:ss" /></span>
                                        </c:otherwise>
                                        </c:choose>
                                        </li>
                                    </ul>
                                </td>
                                <td class="reply-count">
                                    <c:choose>
                                    <c:when test="${discussionThread.discussionTopic.discussionTopicSlug == 'solutions'}">${discussionThread.numberOfReplies}</c:when>
                                    <c:otherwise>${discussionThread.numberOfReplies <= 1 ?  0 : discussionThread.numberOfReplies - 1}</c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div> <!-- #discussion -->
                </c:if>
            </div> <!-- #main-content -->
            <div id="sidebar" class="span4">
                <div id="bulletin-board" class="widget">
                    <h4 align="center"><spring:message code="voj.index.bulletin-board" text="Bulletin Board" /></h4>
                <c:choose>
                <c:when test="${bulletinBoardMessages != null and bulletinBoardMessages.size() > 0}">
                    <ul id="bulletin-board-messages">
                    <c:forEach var="bulletinBoardMessage" items="${bulletinBoardMessages}">
                        <div>如有问题或需求，请联系QQ：416361536</div>
<%--                        <li>--%>
<%--                            <div>该OJ平台尚未完善，如有问题或需求，请联系QQ：416361536</div>--%>
<%--&lt;%&ndash;                            <a href="javascript:void(0);">&ndash;%&gt;--%>
<%--&lt;%&ndash;                                <span class="message-create-time">[<fmt:formatDate value="${bulletinBoardMessage.messageCreateTime}" type="date" dateStyle="short" />]</span>&ndash;%&gt;--%>
<%--&lt;%&ndash;                                <span class="message-title">${bulletinBoardMessage.messageTitle}</span>&ndash;%&gt;--%>
<%--&lt;%&ndash;                                <p class="message-body">${bulletinBoardMessage.messageBody}</p>&ndash;%&gt;--%>
<%--&lt;%&ndash;                            </a>&ndash;%&gt;--%>
<%--                        </li>--%>
                    </c:forEach>
                    </ul>
                </c:when>
                <c:otherwise>
                    <p><spring:message code="voj.index.no-notification" text="No notification now." /></p>
                </c:otherwise>
                </c:choose>
                </div> <!-- #kanban -->
            </div> <!-- #sidebar -->
        </div> <!-- .row-fluid -->
    </div> <!-- #content -->
    <div id="bulletin-board-message-modal" class="modal hide fade">
        <div class="modal-header">
            <i class="fa fa-info-circle"></i>
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        </div> <!-- .modal-header -->
        <div class="modal-body">
            <h5 class="message-title"></h5>
            <div class="message-body"></div> <!-- .message-body -->
        </div> <!-- .modal-body -->
    </div> <!-- #bulletin-board-message-modal -->
    <!-- Footer -->
    <%@ include file="/WEB-INF/views/include/footer.jsp" %>
    <!-- Java Script -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script type="text/javascript" src="${cdnUrl}/js/site.js?v=${version}"></script>
    <script type="text/javascript">
        $.getScript('${cdnUrl}/js/moment.min.js?v=${version}', function() {
            moment.locale('${language}');
            $('span.reply-datetime').each(function() {
                var dateTime = $(this).html();
                $(this).html(getTimeElapsed(dateTime));
            });
        });
    </script>
    <script type="text/javascript">
        function getTimeElapsed(dateTimeString) {
            var dateTime = moment(dateTimeString);
            return dateTime.fromNow();
        }
    </script>
    <script type="text/javascript">
        $('li', '#bulletin-board-messages').click(function() {
            var messageTitle = $('.message-title', this).html(),
                messageBody  = $('.message-body', this).html();

            $('.message-title', '#bulletin-board-message-modal').html(messageTitle);
            $('.message-body', '#bulletin-board-message-modal').html(messageBody.replace('\n', '<br><br>'));
            $('#bulletin-board-message-modal').modal();
        });
    </script>
    <script type="text/javascript">
        $(function() {
            var isUpgradeBrowserShown = $('#upgrade-browser').is(':visible'),
                upgradeBrowserHeight  = $('#upgrade-browser').outerHeight();

            if ( isUpgradeBrowserShown ) {
                $('#header').css('top', upgradeBrowserHeight);
                $('#content').css('margin-top', upgradeBrowserHeight);
            }
        });
    </script>
    <script type="text/javascript">
        $('.btn-danger', '#upgrade-browser').click(function() {
            $('#header').css('top', 0);
            $('#content').css('margin-top', 0);
        });
    </script>

    <script type="text/javascript">
        function changeAvatar(uid) {
            var animateimg = $("#avatar_file").val(); //获取上传的图片路径
            var imgarr = animateimg.split('\\'); //分割
            var myimg = imgarr[imgarr.length - 1]; //去掉 // 获取图片名
            var houzui = myimg.lastIndexOf('.'); //获取 . 出现的位置
            var ext = myimg.substring(houzui, myimg.length).toUpperCase(); //切割 . 获取文件后缀
            var file = $('#avatar_file').get(0).files[0]; //获取上传的文件
            var fileSize = file.size; //获取上传的文件大小
            var maxSize = 1048576;
            if (ext != '.PNG' && ext != '.JPG' && ext != '.JPEG' && ext != '.BMP') {
                alert('文件类型错误,请上传图片类型');
                return false;
            } else if (parseInt(fileSize) >= parseInt(maxSize)) {
                alert('上传的文件不能超过1MB');
                return false;
            } else {
                //上传请求
                var formData = new FormData();
                formData.append("avatar_file", file);
                formData.append("userId",uid);
                $.ajax({
                    type: "POST",
                    url: '<c:url value="/accounts/changeAvatar" />',
                    data : formData,
                    cache: false,
                    contentType : false,
                    processData : false,
                    success : function(result) {
                        if (result == "true") {
                            // $("#ti").attr("src", data.data);
                            // $("#header").val(data.data);
                            location.reload();
                            // $("#avatarImg").attr('src',cdnUrl + uid + '.' + ext);
                            alert("修改头像成功！");
                        }
                        else {
                            alert("修改头像失败");
                        }
                    },
                    error : function(data) {
                        alert("修改头像失败");
                    }
                });
            }
        }
    </script>

    <script type="text/javascript">
        $('#avatarImg').click(function(){
            $('.changeAvatar').show();
        });
    </script>
    <c:if test="${GoogleAnalyticsCode != ''}">
    ${googleAnalyticsCode}
    </c:if>
</body>
</html>