<?php
namespace Home\Controller;
use Think\Controller;
class CommonController extends Controller {
    // 获取field
    public function getField(){
        $db = M("field");
        $result = $db->select();
        $field = array();
        $i = 0;
        foreach ($result as $row) {
            $field[$i]["fieldId"] = $row["pk_field_id"]; 
            $field[$i]["fieldName"] = $row["field_name"];
            $i ++;
        }
        echo(json_encode(@["data"=>@["aList"=>$field]]));
    }
}