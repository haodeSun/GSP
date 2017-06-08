package com.thinkgem.jeesite.common.web;

import java.util.HashMap;
import java.util.Map;

/**
 * @author JOKING
 * @since 2016/11/26
 */
public class JsonResponse {
    /*
      {
            "code":0,
            "message":"",
            "data":Object
    */
    private static final String CODE = "code";

    private static final String MESSAGE = "message";

    private static final String DATA = "data";

    private Object data;
    private String code;
    private String message;
    private Map<String, Object> result = new HashMap<>();

    private JsonResponse(String code, String message, Object data) {
        this.data = data;
        this.code = code;
        this.message = message;
    }

    public static JsonResponse create(String code, String message, Object data){
        return new JsonResponse(code, message, data);
    }

    public Object getResult(){
        if(code != null){
            result.put(CODE, code);
        }
        if(message != null && !message.isEmpty()){
            result.put(MESSAGE, message);
        }
        if(data != null){
            result.put(DATA, data);
        }
        return result;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
