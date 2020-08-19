package org.verwandlung.voj.web.service;

import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.transaction.annotation.Transactional;
import org.verwandlung.voj.web.model.Submission;

import java.util.List;

@ExtendWith(SpringExtension.class)
@Transactional
@ContextConfiguration("classpath:test-spring-context.xml")
@WebAppConfiguration
public class SubmissionServiceTest {
    @Autowired SubmissionService submissionService;
    @org.junit.jupiter.api.Test
    public void submissionServiceTest(){
        System.out.println("Start---------");
//        List<Submission> submissions = submissionService.
//                getSubmissions(1000,"zjhzxhz",100);
//        for (Submission submission : submissions) {
//            System.out.println("time = " + submission.getSubmitTime());
//        }
    }
}
