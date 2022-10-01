package cn.nilnullnaught.SpringMVCTest2.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller // 让 Spring IOC 容器初始化时自动扫描到该类
@RequestMapping("/hello_world")
public class HelloWorldController {


    @RequestMapping("/test1")// 访问地址：localhost:8080/hello_world/test1
    // Model 类型的参数是为了把 Action 中的数据带到视图中
    public String test1(@RequestParam("xx") Model model){
        // 向模型中添加属性msg与值，可以在JSP页面中取出并渲染
        model.addAttribute("msg","hello world");
        // 跳转到 web-inf/jsp/index.jsp
        return "index";
    }

}