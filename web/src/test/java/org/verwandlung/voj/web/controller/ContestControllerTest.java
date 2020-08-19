package org.verwandlung.voj.web.controller;

import com.alibaba.fastjson.JSON;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.transaction.annotation.Transactional;
import org.verwandlung.voj.web.model.Contest;
import org.verwandlung.voj.web.model.Problem;
import org.verwandlung.voj.web.model.User;
import org.verwandlung.voj.web.service.ContestService;
import org.verwandlung.voj.web.service.ProblemService;
import org.verwandlung.voj.web.service.UserService;

import java.util.List;


@ExtendWith(SpringExtension.class)
@Transactional
@ContextConfiguration("classpath:test-spring-context.xml")
@WebAppConfiguration
public class ContestControllerTest {

    @Autowired
    ContestService contestService;
    @Autowired
    ProblemService problemService;
    @Autowired
    UserService userService;

    @Test
    public void getContestProblem(){
        Contest contest1 = contestService.getContest(1);
        Contest contest2 = contestService.getContest(18);
        List<Long> problems1 = JSON.parseArray(contest1.getProblems(), Long.class);
        List<Long> problems2 = JSON.parseArray(contest2.getProblems(), Long.class);
        Problem problem1 = problemService.getProblem(1000);
//        Problem problem2 = problemService.getProblem(problemId);
    }

    @Test
    public void getCodeSnippet(){
        Contest contest1 = contestService.getContest(1);
        Contest contest2 = contestService.getContest(18);
        User user = userService.getUserUsingUid(1000);
//        contestService.getCodeSnippetOfContestProblem(contest1,1000,user);
        contestService.getCodeSnippetOfContestProblem(contest2,1000,user);
    }
}
