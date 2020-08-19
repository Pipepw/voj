package org.verwandlung.voj.web.service;

import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.transaction.annotation.Transactional;

import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.Map;


@ExtendWith(SpringExtension.class)
@Transactional
@ContextConfiguration("classpath:test-spring-context.xml")
@WebAppConfiguration
public class ContestServiceTest {
    @Autowired
    private ContestService contestService;
    @org.junit.jupiter.api.Test
    @Rollback(false)
//    @Rollback(false)，如果不加这个，那么数据在执行完这个方法之后，
//    刚才对数据库执行的操作都会被清除，这个时候应该通过查询数据库的方式来验证正确性
//    不过我的目的是测试这样修改数据库之后，在页面上是否可以直接显示
    public void contestTest() {
        GregorianCalendar startGc = new GregorianCalendar();
        GregorianCalendar endGc = new GregorianCalendar();
        startGc.set(2020, Calendar.AUGUST,15,8,0,0);
        endGc.set(2020,Calendar.AUGUST,15,12,0,0);
        Map<String, Object> result = contestService.createContest("test","3123",
                startGc.getTime(),endGc.getTime(),"OI","[1000, 1003]");
        System.out.println(result.get("isSuccessful"));
    }
}
