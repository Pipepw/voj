package org.verwandlung.voj.web.mapper;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import org.apache.commons.io.FileUtils;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.transaction.annotation.Transactional;
import org.verwandlung.voj.web.model.Problem;
import org.verwandlung.voj.web.service.ProblemService;

import java.io.File;
import java.io.IOException;
import java.util.Collections;
import java.util.List;

@ExtendWith(SpringExtension.class)
@Transactional
@ContextConfiguration({"classpath:test-spring-context.xml"})
public class ProblemDifficultyMapperTest {
    @Autowired
    ProblemDifficultyMapper problemDifficultyMapper;
    @Autowired
    ProblemMapper problemMapper;
    @Autowired
    ProblemService problemService;
    @Test
    public void TestGet(){
        String temp = problemDifficultyMapper.getProblemDifficultyRelationUsingProblemId(1000);
        System.out.println(temp);
    }

    /**
     * 这个方法用于向数据库中添加数据，为了方便，所以放到了测试类中
     */
    @Test
    @Rollback(false)
    public void TestCreate() throws IOException {
        File JsonFile = new File("E:/文档/data.txt");
        String content = FileUtils.readFileToString(JsonFile,"UTF-8");
        List<Result> results = JSON.parseArray(content,Result.class);
        List<Problem> problems = problemService.getProblemsUsingFilters(0, "", "", null, true, 1000);
        for(int i=0; i<problems.size() && i<results.size();i++){
            System.out.println(results.get(i).getTitle() + "   " + problems.get(i).getProblemName());
            int ori = results.get(i).getDifficulty();
            int difficulty;
            if(results.get(i).getDifficulty() == 1 || results.get(i).getDifficulty() == 2){
                difficulty = 1;
            }
            else if(results.get(i).getDifficulty()==0 || (results.get(i).getDifficulty()>=3 && results.get(i).getDifficulty()<=5)){
                difficulty = 2;
            }
            else{
                difficulty = 3;
            }
            System.out.println(ori + "    " + difficulty + "    " + problems.get(i).getProblemId());
//            problemDifficultyMapper.createProblemDifficultyRelationship(problems.get(i).getProblemId(),difficulty);
        }
//        for (Result result : results) {
//            int difficulty;
//            if(result.getDifficulty() == 1 || result.getDifficulty() == 2){
//                difficulty = 1;
//            }
//            else if(result.getDifficulty()==0 || (result.getDifficulty()>=3 && result.getDifficulty()<=5)){
//                difficulty = 2;
//            }
//            else{
//                difficulty = 3;
//            }
//        }
    }
}

class Result{
    public List<Integer> getTags() {
        return tags;
    }

    public void setTags(List<Integer> tags) {
        this.tags = tags;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public int getDifficulty() {
        return difficulty;
    }

    public void setDifficulty(int difficulty) {
        this.difficulty = difficulty;
    }

    public Result(List<Integer> tags,String title, int difficulty){
        this.tags = tags;
        this.title = title;
        this.difficulty = difficulty;
    }

    public Result(){
        super();
    }
    private List<Integer> tags;
    private String title;
    private int difficulty;
}
