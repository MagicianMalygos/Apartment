<?php
namespace Home\Controller;
use Think\Controller;
class activityController {
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////// - - - - - - - - - - 对对联 - - - - - - - - - - /////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    /**
    *   根据条件搜索对联：排序方式
    */
    public function getCoupletBySortMethod() {
        $sortMethod = $_POST['sortMethod'];
        $currUserID = $_POST["currUserID"];
        $pagination = $_POST['pagination'];
        $pageCount = $_POST['pageCount'];
        $pageIndex = ($pagination - 1) * $pageCount;

        $db = M();
        $sql = "call proc_Couplet_SelectByMultiCondition($sortMethod, $pageIndex, $pageCount)";
        $result = $db->query($sql);

        $coupletArr = array();
        $i = 0;
        foreach ($result as $row) {
            $coupletArr[$i]["coupletId"] = $row["pk_couplet_id"];
            $coupletArr[$i]["coupletContent"] = preg_replace_callback('/@E(.{6}==)/', function($r) {return base64_decode($r[1]);}, $row["couplet_content"]);
            $coupletArr[$i]["coupletReplyNumber"] = $row["couplet_reply_number"];
            $coupletArr[$i]["coupletSupport"] = $row["couplet_support"];
            $coupletArr[$i]["coupletTime"] = $row["couplet_time"];

            $judgeSupportSQL = "call proc_UserSupportCoupletByCoupletIDUserID_Select(".$row["pk_couplet_id"].", $currUserID)";
            if (empty($db->query($judgeSupportSQL))) {
                $coupletArr[$i]["supported"] = 0;
            }
            else {
                $coupletArr[$i]["supported"] = 1;
            }
            $judgeCollectSQL = "call proc_UserCollectCoupletByCoupletIDUserID_Select(".$row["pk_couplet_id"].", $currUserID)";
            if (empty($db->query($judgeCollectSQL))) {
                $coupletArr[$i]["collected"] = 0;
            }
            else {
                $coupletArr[$i]["collected"] = 1;
            }

            $userArr = array();
            $userArr["userId"] = $row["pk_user_id"];
            $userArr["userAccount"] = $row["user_account"];
            $userArr["userName"] = $row["user_name"];
            $userArr["userAge"] = $row["user_age"];
            $userArr["userFaceURL"] = $row["user_face_url"];
            $userArr["userEXP"] = $row["user_exp"];
            $coupletArr[$i]["user"] = $userArr;
            $i++;
        }
        echo json_encode(@["data"=>@["aList"=>$coupletArr]]);
    }

    // 根据用户ID得到该用户所发过的对联
    public function getCoupletByUserID() {
        $currUserID = $_POST["currUserID"];
        $myUserID = $_POST['myUserID'];
        $pagination = $_POST['pagination'];
        $pageCount = $_POST['pageCount'];
        $pageIndex = ($pagination - 1) * $pageCount;

        $db = M();
        $db_user = M('user');
        $db_couplet = M('couplet');
        $result = $db_couplet->where('couplet_usable=1 AND fk_couplet_user_id='.$currUserID)->order('couplet_time desc')->limit($pageIndex.','.$pageCount)->select();

        $coupletArr = array();
        $i = 0;
        foreach ($result as $row) {
            $coupletArr[$i]["coupletId"] = $row["pk_couplet_id"];
            $coupletArr[$i]["coupletContent"] = preg_replace_callback('/@E(.{6}==)/', function($r) {return base64_decode($r[1]);}, $row["couplet_content"]);
            $coupletArr[$i]["coupletReplyNumber"] = $row["couplet_reply_number"];
            $coupletArr[$i]["coupletSupport"] = $row["couplet_support"];
            $coupletArr[$i]["coupletTime"] = $row["couplet_time"];

            $userArr = array();
            $userResult = $db_user->where('pk_user_id='.$row['fk_couplet_user_id'])->select();
            $userArr["userId"] = $userResult[0]["pk_user_id"];
            $userArr["userAccount"] = $userResult[0]["user_account"];
            $userArr["userName"] = $userResult[0]["user_name"];
            $userArr["userAge"] = $userResult[0]["user_age"];
            $userArr["userFaceURL"] = $userResult[0]["user_face_url"];
            $userArr["userEXP"] = $userResult[0]["user_exp"];
            $coupletArr[$i]['user'] = $userArr;

            $judgeSupportSQL = "call proc_UserSupportCoupletByCoupletIDUserID_Select(".$row["pk_couplet_id"].", $myUserID)";
            if (empty($db->query($judgeSupportSQL))) {
                $coupletArr[$i]["supported"] = 0;
            }
            else {
                $coupletArr[$i]["supported"] = 1;
            }
            $judgeCollectSQL = "call proc_UserCollectCoupletByCoupletIDUserID_Select(".$row["pk_couplet_id"].", $myUserID)";
            if (empty($db->query($judgeCollectSQL))) {
                $coupletArr[$i]["collected"] = 0;
            }
            else {
                $coupletArr[$i]["collected"] = 1;
            }

            $i++;
        }
        echo json_encode(@["data"=>@["aList"=>$coupletArr]]);
    }

    // 根据用户ID得到该用户收藏的对联
    public function getCollectedCoupletByUserID() {
        $currUserID = $_POST["currUserID"];
        $myUserID = $_POST['myUserID'];
        $pagination = $_POST['pagination'];
        $pageCount = $_POST['pageCount'];
        $pageIndex = ($pagination - 1) * $pageCount;

        $db = M();
        $db_user = M('user');
        $db_couplet = M('couplet');
        $db_couplet_collect = M('user_collect_couplet');
        $result = $db_couplet_collect->where('collect_usable=1 AND fk_ucc_user_id='.$currUserID)->limit($pageIndex.','.$pageCount)->join('__COUPLET__ on __COUPLET__.pk_couplet_id=__USER_COLLECT_COUPLET__.fk_ucc_couplet_id', 'LEFT')->order('couplet_time desc')->select();

        $coupletArr = array();
        $i = 0;
        foreach ($result as $row) {
            $coupletArr[$i]["coupletId"] = $row["pk_couplet_id"];
            $coupletArr[$i]["coupletContent"] = preg_replace_callback('/@E(.{6}==)/', function($r) {return base64_decode($r[1]);}, $row["couplet_content"]);
            $coupletArr[$i]["coupletReplyNumber"] = $row["couplet_reply_number"];
            $coupletArr[$i]["coupletSupport"] = $row["couplet_support"];
            $coupletArr[$i]["coupletTime"] = $row["couplet_time"];

            $userArr = array();
            $userResult = $db_user->where('pk_user_id='.$row['fk_couplet_user_id'])->select();
            $userArr["userId"] = $userResult[0]["pk_user_id"];
            $userArr["userAccount"] = $userResult[0]["user_account"];
            $userArr["userName"] = $userResult[0]["user_name"];
            $userArr["userAge"] = $userResult[0]["user_age"];
            $userArr["userFaceURL"] = $userResult[0]["user_face_url"];
            $userArr["userEXP"] = $userResult[0]["user_exp"];
            $coupletArr[$i]['user'] = $userArr;

            $judgeSupportSQL = "call proc_UserSupportCoupletByCoupletIDUserID_Select(".$row["pk_couplet_id"].", $myUserID)";
            if (empty($db->query($judgeSupportSQL))) {
                $coupletArr[$i]["supported"] = 0;
            }
            else {
                $coupletArr[$i]["supported"] = 1;
            }
            $judgeCollectSQL = "call proc_UserCollectCoupletByCoupletIDUserID_Select(".$row["pk_couplet_id"].", $myUserID)";
            if (empty($db->query($judgeCollectSQL))) {
                $coupletArr[$i]["collected"] = 0;
            }
            else {
                $coupletArr[$i]["collected"] = 1;
            }

            $i++;
        }
        echo json_encode(@["data"=>@["aList"=>$coupletArr]]);
    }

    /**
    *   根据CoupletId，按时间降序获取该对联的前pageCount条“对联回复”记录
    */
    public function getCoupletReplyByCoupletID() {
        
        $currCoupletID = $_POST["currCoupletID"];
        $currUserID = $_POST["currUserID"];
        $pagination = $_POST['pagination'];
        $pageCount = $_POST['pageCount'];
        $pageIndex = ($pagination - 1) * $pageCount;

        $db = M();
        $sql = "call proc_CoupletReplyByCoupletID_Select($currCoupletID, $pageIndex, $pageCount)";
        $result = $db->query($sql);

        $coupletReplyArr = array();
        $i = 0;
        foreach ($result as $row) {
            $coupletReplyArr[$i]["replyId"] = $row["pk_couplet_reply_id"];
            $coupletReplyArr[$i]["replyContent"] = preg_replace_callback('/@E(.{6}==)/', function($r) {return base64_decode($r[1]);}, $row["reply_content"]);
            $coupletReplyArr[$i]["replySupport"] = $row["reply_support"];
            $coupletReplyArr[$i]["replyTime"] = $row["reply_time"];

            // 判断当前用户是否点过赞，并添加标识属性
            $judgeSupportSQL = "call proc_UserSupportCoupletReplyByReplyIDUserID_Select(".$row["pk_couplet_reply_id"].", $currUserID)";
            if (empty($db->query($judgeSupportSQL))) {
                $coupletReplyArr[$i]["supported"] = 0;
            }
            else {
                $coupletReplyArr[$i]["supported"] = 1;
            }

            $userArr = array();
            $userArr["userId"] = $row["pk_user_id"];
            $userArr["userAccount"] = $row["user_account"];
            $userArr["userName"] = $row["user_name"];
            $userArr["userAge"] = $row["user_age"];
            $userArr["userFaceURL"] = $row["user_face_url"];
            $userArr["userEXP"] = $row["user_exp"];
            $coupletReplyArr[$i]["user"] = $userArr;
            $i++;
        }
        echo json_encode(@["data"=>@["aList"=>$coupletReplyArr]]);
    }
    /**
    *   添加一条对联
    */
    public function addCouplet() {
        $coupletContent = preg_replace_callback('/[\xf0-\xf7].{3}/', function($r) {return '@E' . base64_encode($r[0]);}, $_POST["coupletContent"]);
        $currUserID = $_POST["currUserID"];

        $db = M();
        $sql = "call proc_Couplet_Insert('$coupletContent', $currUserID)";
        $result = $db->query($sql);

        // 判断是否为数组,如果为数组则添加成功，如果返回false则添加失败
        if (is_array($result)) {
            echo json_encode(@["result"=>1]);
        }
        else {
            echo json_encode(@["result"=>0]);
        }
    }
    /**
    *   添加一条对联回复
    */
    public function addCoupletReply() {
        $replyContent = preg_replace_callback('/[\xf0-\xf7].{3}/', function($r) {return '@E'.base64_encode($r[0]);}, $_POST["coupletReplyContent"]);
        $currCoupletID = $_POST["currCoupletID"];
        $currUserID = $_POST["currUserID"];

        $db = M();
        $sql = "call proc_CoupletReply_Insert('$replyContent', $currCoupletID, $currUserID)";
        $result = $db->query($sql);

        // 判断是否为数组,如果为数组则添加成功，如果返回false则添加失败
        if (is_array($result)) {
            echo json_encode(@["result"=>1]);
        }
        else {
            echo json_encode(@["result"=>0]);
        }
    }
    /**
    *   改变对联点赞记录
    */
    public function changeCoupletSupportRecord() {
        $currCoupletID = $_POST["currCoupletID"];
        $currUserID = $_POST["currUserID"];
        $currSupported = $_POST["currSupported"];

        $db = M();
        $sql = "call proc_UserSupportCoupletByCoupletIDUserID_InsertOrDelete($currCoupletID, $currUserID, $currSupported)";
        $result = $db->query($sql);
        // 判断是否为数组,如果为数组则改变成功，如果返回false则添加失败
        if (is_array($result)) {
            echo json_encode(@["result"=>1]);
        }
        else {
            echo json_encode(@["result"=>0]);
        }
    }
    /**
    *   改变对联收藏记录
    */
    public function changeCoupletCollectionRecord() {
        $currCoupletID = $_POST["currCoupletID"];
        $currUserID = $_POST["currUserID"];
        $currCollected = $_POST["currCollected"];

        $db = M();
        $sql = "call proc_UserCollectCoupletByCoupletIDUserID_InsertOrDelete($currCoupletID, $currUserID, $currCollected)";
        $result = $db->query($sql);

        // 判断是否为数组,如果为数组则改变成功，如果返回false则添加失败
        if (is_array($result)) {
            echo json_encode(@["result"=>1]);
        }
        else {
            echo json_encode(@["result"=>0]);
        }
    }
    /**
    *   改变对联回复点赞记录
    */
    public function changeCoupletReplySupportRecord() {
        $currCoupletReplyID = $_POST["currCoupletReplyID"];
        $currUserID = $_POST["currUserID"];
        $currSupported = $_POST["currSupported"];

        $db = M();
        $sql  = "call proc_UserSupportCoupletReplyByReplyIDUserID_InsertOrDelete($currCoupletReplyID, $currUserID, $currSupported)";
        $result = $db->query($sql);   
        // 判断是否为数组,如果为数组则添加成功，如果返回false则添加失败
        if (is_array($result)) {
            echo json_encode(@["result"=>1]);
        }
        else {
            echo json_encode(@["result"=>0]);
        }
    }

    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////// - - - - - - - - - - 舌场争锋 - - - - - - - - - - //////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /**
    *   获取当前使用辩题
    */
    public function getCurrThesis() {

        $currUserID = $_POST["currUserID"];

        $db = M();
        $sql = "call proc_ThesisByThesisState_Select()";
        $result = $db->query($sql);

        $currThesisArr = array();
        foreach ($result as $row) {
            $currThesisArr["thesisId"] = $row["pk_thesis_id"];
            $currThesisArr["thesisContent"] = preg_replace_callback('/@E(.{6}==)/', function($r) {return base64_decode($r[1]);}, $row["thesis_content"]);
            $currThesisArr["thesisPros"] = preg_replace_callback('/@E(.{6}==)/', function($r) {return base64_decode($r[1]);}, $row["thesis_pros"]);
            $currThesisArr["thesisProsCount"] = $row["thesis_pros_count"];
            $currThesisArr["thesisProsReplyNumber"] = $row["thesis_pros_reply_number"];
            $currThesisArr["thesisCons"] = preg_replace_callback('/@E(.{6}==)/', function($r) {return base64_decode($r[1]);}, $row["thesis_cons"]);
            $currThesisArr["thesisConsCount"] = $row["thesis_cons_count"];
            $currThesisArr["thesisConsReplyNumber"] = $row["thesis_cons_reply_number"];
            $currThesisArr["thesisCollectNumber"] = $row["thesis_collect_number"];
            $currThesisArr["thesisStartTime"] = $row["thesis_start_time"];
            $currThesisArr["thesisEndTime"] = $row["thesis_end_time"];
            $currThesisArr["thesisTime"] = $row["thesis_time"];

            $stateArr = array();
            $stateArr["stateId"] = $row["pk_state_id"];
            $stateArr["stateName"] = $row["state_name"];
            $stateArr["stateValue"] = $row["state_value"];
            $stateArr["stateType"] = $row["state_type"];
            $stateArr["stateTime"] = $row["state_time"];
            $currThesisArr["state"] = $stateArr;

            // 判断当前用户是否收藏该辩题，并添加标识属性
            $judgeCollectSQL = "call proc_UserCollectThesisBythesisIDUserID_Select(".$row["pk_thesis_id"].", $currUserID)";
            if (empty($db->query($judgeCollectSQL))) {
                $currThesisArr["collected"] = 0;
            }
            else {
                $currThesisArr["collected"] = 1;
            }
        }

        $prosArgument = $this->getArgument(1, $currUserID, 1, 1)[0];
        $consArgument = $this->getArgument(0, $currUserID, 1, 1)[0];

        echo json_encode(@["data"=>@["currThesis"=>$currThesisArr
            , "prosArgument"=>$prosArgument
            , "consArgument"=>$consArgument]]);
    }

    // 根据用户ID得到该用户所发过的辩题
    public function getThesisByUserID() {

        $currUserID = $_POST["currUserID"];
        $myUserID = $_POST['myUserID'];
        $pagination = $_POST['pagination'];
        $pageCount = $_POST['pageCount'];
        $pageIndex = ($pagination - 1) * $pageCount;

        $db = M();
        $db_state = M('state');
        $db_thesis = M('thesis');
        $result = $db_thesis->where('thesis_usable=1 AND fk_thesis_user_id='.$currUserID)->order('thesis_time desc')->limit($pageIndex.','.$pageCount)->select();

        $thesisArr = array();
        $i = 0;
        foreach ($result as $row) {
            $thesisArr[$i]["thesisId"] = $row["pk_thesis_id"];
            $thesisArr[$i]["thesisContent"] = preg_replace_callback('/@E(.{6}==)/', function($r) {return base64_decode($r[1]);}, $row["thesis_content"]);
            $thesisArr[$i]["thesisPros"] = preg_replace_callback('/@E(.{6}==)/', function($r) {return base64_decode($r[1]);}, $row["thesis_pros"]);
            $thesisArr[$i]["thesisProsCount"] = $row["thesis_pros_count"];
            $thesisArr[$i]["thesisProsReplyNumber"] = $row["thesis_pros_reply_number"];
            $thesisArr[$i]["thesisCons"] = preg_replace_callback('/@E(.{6}==)/', function($r) {return base64_decode($r[1]);}, $row["thesis_cons"]);
            $thesisArr[$i]["thesisConsCount"] = $row["thesis_cons_count"];
            $thesisArr[$i]["thesisConsReplyNumber"] = $row["thesis_cons_reply_number"];
            $thesisArr[$i]["thesisCollectNumber"] = $row["thesis_collect_number"];
            $thesisArr[$i]["thesisStartTime"] = $row["thesis_start_time"];
            $thesisArr[$i]["thesisEndTime"] = $row["thesis_end_time"];
            $thesisArr[$i]["thesisTime"] = $row["thesis_time"];

            $stateArr = array();
            $stateResult = $db_state->where('pk_state_id='.$row['fk_thesis_state_id'])->select();
            $stateArr["stateId"] = $stateResult[0]["pk_state_id"];
            $stateArr["stateName"] = $stateResult[0]["state_name"];
            $stateArr["stateValue"] = $stateResult[0]["state_value"];
            $stateArr["stateType"] = $stateResult[0]["state_type"];
            $stateArr["stateTime"] = $stateResult[0]["state_time"];
            $thesisArr[$i]["state"] = $stateArr;

            // 判断当前用户是否收藏该辩题，并添加标识属性
            $judgeCollectSQL = "call proc_UserCollectThesisBythesisIDUserID_Select(".$row["pk_thesis_id"].", $myUserID)";
            if (empty($db->query($judgeCollectSQL))) {
                $currThesisArr["collected"] = 0;
            }
            else {
                $currThesisArr["collected"] = 1;
            }
            $i ++;
        }

        echo json_encode(@["data"=>@["aList"=>$thesisArr]]);
    }

    // 根据用户ID得到该用户收藏的辩题
    public function getCollectedThesisByUserID() {

        $currUserID = $_POST["currUserID"];
        $myUserID = $_POST['myUserID'];
        $pagination = $_POST['pagination'];
        $pageCount = $_POST['pageCount'];
        $pageIndex = ($pagination - 1) * $pageCount;

        $db = M();
        $db_state = M('state');
        $db_thesis = M('thesis');
        $db_thesis_collect = M('user_collect_thesis');
        $result = $db_thesis_collect->where('collect_usable=1 AND fk_uct_user_id='.$currUserID)->limit($pageIndex.','.$pageCount)->join('__THESIS__ on __THESIS__.pk_thesis_id=__USER_COLLECT_THESIS__.fk_uct_thesis_id', 'LEFT')->order('thesis_time desc')->select();

        $thesisArr = array();
        $i = 0;
        foreach ($result as $row) {
            $thesisArr[$i]["thesisId"] = $row["pk_thesis_id"];
            $thesisArr[$i]["thesisContent"] = preg_replace_callback('/@E(.{6}==)/', function($r) {return base64_decode($r[1]);}, $row["thesis_content"]);
            $thesisArr[$i]["thesisPros"] = preg_replace_callback('/@E(.{6}==)/', function($r) {return base64_decode($r[1]);}, $row["thesis_pros"]);
            $thesisArr[$i]["thesisProsCount"] = $row["thesis_pros_count"];
            $thesisArr[$i]["thesisProsReplyNumber"] = $row["thesis_pros_reply_number"];
            $thesisArr[$i]["thesisCons"] = preg_replace_callback('/@E(.{6}==)/', function($r) {return base64_decode($r[1]);}, $row["thesis_cons"]);
            $thesisArr[$i]["thesisConsCount"] = $row["thesis_cons_count"];
            $thesisArr[$i]["thesisConsReplyNumber"] = $row["thesis_cons_reply_number"];
            $thesisArr[$i]["thesisCollectNumber"] = $row["thesis_collect_number"];
            $thesisArr[$i]["thesisStartTime"] = $row["thesis_start_time"];
            $thesisArr[$i]["thesisEndTime"] = $row["thesis_end_time"];
            $thesisArr[$i]["thesisTime"] = $row["thesis_time"];

            $stateArr = array();
            $stateResult = $db_state->where('pk_state_id='.$row['fk_thesis_state_id'])->select();
            $stateArr["stateId"] = $stateResult[0]["pk_state_id"];
            $stateArr["stateName"] = $stateResult[0]["state_name"];
            $stateArr["stateValue"] = $stateResult[0]["state_value"];
            $stateArr["stateType"] = $stateResult[0]["state_type"];
            $stateArr["stateTime"] = $stateResult[0]["state_time"];
            $thesisArr[$i]["state"] = $stateArr;

            // 判断当前用户是否收藏该辩题，并添加标识属性
            $judgeCollectSQL = "call proc_UserCollectThesisBythesisIDUserID_Select(".$row["pk_thesis_id"].", $myUserID)";
            if (empty($db->query($judgeCollectSQL))) {
                $currThesisArr["collected"] = 0;
            }
            else {
                $currThesisArr["collected"] = 1;
            }
            $i ++;
        }

        echo json_encode(@["data"=>@["aList"=>$thesisArr]]);
    }

    /**
    *   获取论据（带参方法，私有）
    */
    public function getArgument($belong, $currUserID, $pagination, $pageCount) {
        $pageIndex = ($pagination - 1) * $pageCount;

        $db = M();
        $sql = "call proc_ArgumentByBelong_Select($belong, $pageIndex, $pageCount)";
        $result = $db->query($sql);

        $argumentArr = array();
        $i = 0;
        foreach ($result as $row) {
            $argumentArr[$i]["argumentId"] = $row["pk_argument_id"];
            $argumentArr[$i]["argumentContent"] = preg_replace_callback('/@E(.{6}==)/', function($r) {return base64_decode($r[1]);}, $row["argument_content"]);
            $argumentArr[$i]["argumentSupport"] = $row["argument_support"];
            $argumentArr[$i]["argumentBelong"] = $row["argument_belong"];
            $argumentArr[$i]["argumentTime"] = $row["argument_time"];

            // 判断当前用户是否点过赞，并添加标识属性
            $judgeSupportSQL = "call proc_UserSupportArgumentByArgumentIDUserID_Select(".$row["pk_argument_id"].", $currUserID)";
            if (empty($db->query($judgeSupportSQL))) {
                $argumentArr[$i]["supported"] = 0;
            }
            else {
                $argumentArr[$i]["supported"] = 1;
            }

            $userArr = array();
            $userArr["userId"] = $row["pk_user_id"];
            $userArr["userAccount"] = $row["user_account"];
            $userArr["userName"] = $row["user_name"];
            $userArr["userAge"] = $row["user_age"];
            $userArr["userFaceURL"] = $row["user_face_url"];
            $userArr["userEXP"] = $row["user_exp"];
            $argumentArr["$i"]["user"] = $userArr;

            $stateArr = array();
            $stateArr["stateId"] = $row["pk_state_id"];
            $stateArr["stateName"] = $row["state_name"];
            $stateArr["stateValue"] = $row["state_value"];
            $stateArr["stateType"] = $row["state_type"];
            $stateArr["stateTime"] = $row["state_time"];
            $argumentArr["$i"]["state"] = $stateArr;
            $i++;
        }

        return $argumentArr;
    }

    /**
    *   获取论据
    */
    public function getArgumentByBelong() {

        $belong = $_POST["belong"];
        $currUserID = $_POST["currUserID"];
        $pagination = $_POST['pagination'];
        $pageCount = $_POST['pageCount'];

        $argumentArr = $this->getArgument($belong, $currUserID, $pagination, $pageCount);

        echo json_encode(@["data"=>@["aList"=>$argumentArr]]);
    }
    /**
    *   添加辩题收藏记录
    */
    public function changeThesisCollectionRecord() {
        $currThesisID = $_POST["currThesisID"];
        $currUserID = $_POST["currUserID"];
        $currCollected = $_POST["currCollected"];

        $db = M();
        $sql = "call proc_UserCollectThesisByThesisIDUserID_InsertOrDelete($currThesisID, $currUserID, $currCollected)";
        $result = $db->query($sql);

        // 判断是否为数组,如果为数组则添加成功，如果返回false则添加失败
        if (is_array($result)) {
            echo json_encode(@["result"=>1]);
        }
        else {
            echo json_encode(@["result"=>0]);
        }
    }
    /**
    *   添加论据点赞记录
    */
    public function changeArgumentSupportRecord() {
        $argumentId = $_POST["currArgumentID"];
        $userId = $_POST["currUserID"];
        $currSupported = $_POST["currSupported"];

        $db = M();
        $sql = "call proc_UserSupportArgumentByArgumentIDUserID_InsertOrDelete($argumentId, $userId, $currSupported)";
        $result = $db->query($sql);

        // 判断是否为数组,如果为数组则添加成功，如果返回false则添加失败
        if (is_array($result)) {
            echo json_encode(@["result"=>1]);
        }
        else {
            echo json_encode(@["result"=>0]);
        }
    }
    
    /**
    *   添加辩题
    */
    public function addThesis() {
        $stateValue = 0;
        $thesisContent = preg_replace_callback('/[\xf0-\xf7].{3}/', function($r) { return '@E' . base64_encode($r[0]);}, $_POST["thesisContent"]);
        $thesisPros = preg_replace_callback('/[\xf0-\xf7].{3}/', function($r) { return '@E' . base64_encode($r[0]);}, $_POST["thesisPros"]);
        $thesisCons = preg_replace_callback('/[\xf0-\xf7].{3}/', function($r) { return '@E' . base64_encode($r[0]);}, $_POST["thesisCons"]);
        $thesisAddReson = preg_replace_callback('/[\xf0-\xf7].{3}/', function($r) { return '@E' . base64_encode($r[0]);}, $_POST["thesisAddReson"]);
        $currUserID = $_POST["currUserID"];

        $db = M();
        $sql = "call proc_Thesis_Insert('$thesisContent','$thesisPros', '$thesisCons', '$thesisAddReson', $stateValue, $currUserID)";
        $result = $db->query($sql);
        // 判断是否为数组,如果为数组则添加成功，如果返回false则添加失败
        if (is_array($result)) {
            echo json_encode(@["result"=>1]);
        }
        else {
            echo json_encode(@["result"=>0]);
        }
    }

    /**
    *   添加论据
    */
    public function addArgument() {
        $currThesisID = $_POST["currThesisID"];
        $currUserID = $_POST["currUserID"];
        $stateValue = $_POST["isAnonymous"]? 0: 1;
        $argumentContent = preg_replace_callback('/[\xf0-\xf7].{3}/', function($r) { return '@E' . base64_encode($r[0]);}, $_POST["argumentContent"]);
        $argumentBelong = $_POST["argumentBelong"];

        $db = M();
        $sql = "call proc_Argument_Insert($stateValue, '$argumentContent', $argumentBelong, $currThesisID, $currUserID)";
        $result = $db->query($sql);
        // 判断是否为数组,如果为数组则添加成功，如果返回false则添加失败
        if (is_array($result)) {
            echo json_encode(@["result"=>1]);
        }
        else {
            echo json_encode(@["result"=>0]);
        }
    }

    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////// - - - - - - - - - - 头脑风暴 - - - - - - - - - - ///////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /**
    *   获取问题
    */
    public function getQuestion() {
        $currUserID = $_POST["currUserID"];
        $pageCount = 5; // 默认5个题目
        $stateValue = 2;

        $db = M();
        $sql = "call proc_QuestionByQuestionState_Select($stateValue, $pageCount)";
        $result = $db->query($sql);

        $questionArr = array();
        $i = 0;
        foreach ($result as $row) {
            $questionArr[$i]["questionId"] = $row["pk_question_id"];
            $questionArr[$i]["questionContent"] = preg_replace_callback('/@E(.{6}==)/', function($r) {return base64_decode($r[1]);}, $row["question_content"]);
            $questionArr[$i]["questionOptionOne"] = preg_replace_callback('/@E(.{6}==)/', function($r) {return base64_decode($r[1]);}, $row["question_option_one"]);
            $questionArr[$i]["questionOptionTwo"] = preg_replace_callback('/@E(.{6}==)/', function($r) {return base64_decode($r[1]);}, $row["question_option_two"]);
            $questionArr[$i]["questionOptionThree"] = preg_replace_callback('/@E(.{6}==)/', function($r) {return base64_decode($r[1]);}, $row["question_option_three"]);
            $questionArr[$i]["questionAnswer"] = preg_replace_callback('/@E(.{6}==)/', function($r) {return base64_decode($r[1]);}, $row["question_answer"]);
            $questionArr[$i]["questionCollectNumber"] = $row["question_collect_number"];
            $questionArr[$i]["questionShowOrder"] = $row['question_show_order'];
            $questionArr[$i]["questionTime"] = $row["question_time"];

            // 相关用户信息
            $userArr = array();
            $userArr["userId"] = $row["pk_user_id"];
            $userArr["userAccount"] = $row["user_account"];
            $userArr["userName"] = $row["user_name"];
            $userArr["userFaceURL"] = $row["user_face_url"];
            $questionArr[$i]["user"] = $userArr;

            // 收藏状态
            $judgeCollectSQL = "call proc_UserCollectQuestionByQuestionIDUserID_Select(".$row["pk_question_id"].", $currUserID)";
            if (empty($db->query($judgeCollectSQL))) {
                $questionArr[$i]["collected"] = 0;
            }
            else {
                $questionArr[$i]["collected"] = 1;
            }

            $i++;
        }
        echo json_encode(@["data"=>@["aList"=>$questionArr]]);
    }

    // 根据用户ID得到该用户所发过的题目
    public function getQuestionByUserID() {

        $currUserID = $_POST["currUserID"];
        $myUserID = $_POST['myUserID'];
        $pagination = $_POST['pagination'];
        $pageCount = $_POST['pageCount'];
        $pageIndex = ($pagination - 1) * $pageCount;

        $db = M();
        $db_state = M('state');
        $db_question = M('question');
        $result = $db_question->where('question_usable=1 AND fk_question_user_id='.$currUserID)->order('question_time desc')->limit($pageIndex.','.$pageCount)->select();

        $questionArr = array();
        $i = 0;
        foreach ($result as $row) {
            $questionArr[$i]["questionId"] = $row["pk_question_id"];
            $questionArr[$i]["questionContent"] = preg_replace_callback('/@E(.{6}==)/', function($r) {return base64_decode($r[1]);}, $row["question_content"]);
            $questionArr[$i]["questionOptionOne"] = preg_replace_callback('/@E(.{6}==)/', function($r) {return base64_decode($r[1]);}, $row["question_option_one"]);
            $questionArr[$i]["questionOptionTwo"] = preg_replace_callback('/@E(.{6}==)/', function($r) {return base64_decode($r[1]);}, $row["question_option_two"]);
            $questionArr[$i]["questionOptionThree"] = preg_replace_callback('/@E(.{6}==)/', function($r) {return base64_decode($r[1]);}, $row["question_option_three"]);
            $questionArr[$i]["questionAnswer"] = preg_replace_callback('/@E(.{6}==)/', function($r) {return base64_decode($r[1]);}, $row["question_answer"]);
            $questionArr[$i]["questionCollectNumber"] = $row["question_collect_number"];
            $questionArr[$i]["questionShowOrder"] = $row['question_show_order'];
            $questionArr[$i]["questionTime"] = $row["question_time"];

            $stateArr = array();
            $stateResult = $db_state->where('pk_state_id='.$row['fk_question_state_id'])->select();
            $stateArr["stateId"] = $stateResult[0]["pk_state_id"];
            $stateArr["stateName"] = $stateResult[0]["state_name"];
            $stateArr["stateValue"] = $stateResult[0]["state_value"];
            $stateArr["stateType"] = $stateResult[0]["state_type"];
            $stateArr["stateTime"] = $stateResult[0]["state_time"];
            $questionArr[$i]["state"] = $stateArr;

            // 判断当前用户是否收藏该辩题，并添加标识属性
            $judgeCollectSQL = "call proc_UserCollectQuestionByQuestionIDUserID_Select(".$row["pk_question_id"].", $myUserID)";
            if (empty($db->query($judgeCollectSQL))) {
                $questionArr[$i]["collected"] = 0;
            }
            else {
                $questionArr[$i]["collected"] = 1;
            }
            $i ++;
        }

        echo json_encode(@["data"=>@["aList"=>$questionArr]]);
    }

    // 根据用户ID得到该用户收藏的题目
    public function getCollectedQuestionByUserID() {

        $currUserID = $_POST["currUserID"];
        $myUserID = $_POST['myUserID'];
        $pagination = $_POST['pagination'];
        $pageCount = $_POST['pageCount'];
        $pageIndex = ($pagination - 1) * $pageCount;

        $db = M();
        $db_state = M('state');
        $db_question = M('question');
        $db_question_collect = M('user_collect_question');
        $result = $db_question_collect->where('collect_usable=1 AND fk_ucq_user_id='.$currUserID)->limit($pageIndex.','.$pageCount)->join('__QUESTION__ on __QUESTION__.pk_question_id=__USER_COLLECT_QUESTION__.fk_ucq_question_id', 'LEFT')->order('question_time desc')->select();

        $questionArr = array();
        $i = 0;
        foreach ($result as $row) {
            $questionArr[$i]["questionId"] = $row["pk_question_id"];
            $questionArr[$i]["questionContent"] = preg_replace_callback('/@E(.{6}==)/', function($r) {return base64_decode($r[1]);}, $row["question_content"]);
            $questionArr[$i]["questionOptionOne"] = preg_replace_callback('/@E(.{6}==)/', function($r) {return base64_decode($r[1]);}, $row["question_option_one"]);
            $questionArr[$i]["questionOptionTwo"] = preg_replace_callback('/@E(.{6}==)/', function($r) {return base64_decode($r[1]);}, $row["question_option_two"]);
            $questionArr[$i]["questionOptionThree"] = preg_replace_callback('/@E(.{6}==)/', function($r) {return base64_decode($r[1]);}, $row["question_option_three"]);
            $questionArr[$i]["questionAnswer"] = preg_replace_callback('/@E(.{6}==)/', function($r) {return base64_decode($r[1]);}, $row["question_answer"]);
            $questionArr[$i]["questionCollectNumber"] = $row["question_collect_number"];
            $questionArr[$i]["questionShowOrder"] = $row['question_show_order'];
            $questionArr[$i]["questionTime"] = $row["question_time"];

            $stateArr = array();
            $stateResult = $db_state->where('pk_state_id='.$row['fk_question_state_id'])->select();
            $stateArr["stateId"] = $stateResult[0]["pk_state_id"];
            $stateArr["stateName"] = $stateResult[0]["state_name"];
            $stateArr["stateValue"] = $stateResult[0]["state_value"];
            $stateArr["stateType"] = $stateResult[0]["state_type"];
            $stateArr["stateTime"] = $stateResult[0]["state_time"];
            $questionArr[$i]["state"] = $stateArr;

            // 判断当前用户是否收藏该辩题，并添加标识属性
            $judgeCollectSQL = "call proc_UserCollectQuestionByQuestionIDUserID_Select(".$row["pk_question_id"].", $myUserID)";
            if (empty($db->query($judgeCollectSQL))) {
                $questionArr[$i]["collected"] = 0;
            }
            else {
                $questionArr[$i]["collected"] = 1;
            }
            $i ++;
        }

        echo json_encode(@["data"=>@["aList"=>$questionArr]]);
    }

    /**
    *   获取用户答题记录
    */
    public function getAnswerRecordByUserID() {

        $currUserID = $_POST['currUserID'];

        $db_question = M('question');
        $db_answer_record = M('answer_record');
        $db_user = M('user');

        // 获取问题列表：id、答案、答案序列
        $questionResult = $db_question->where('question_usable=1 AND fk_question_state_id=7')->field('pk_question_id, question_answer, question_show_order')->select();

        // 根据问题列表和当前用户ID获取答案
        $answers = '';
        for ($i = 0; $i < count($questionResult); $i++) {
            $data['fk_answer_record_user_id'] = $currUserID;
            $data['fk_answer_record_question_id'] = $questionResult[$i]["pk_question_id"]; 
            $answer = $db_answer_record->where('fk_answer_record_user_id='.$currUserID.' AND fk_answer_record_question_id='.$questionResult[$i]["pk_question_id"])->getField('answer_record_answer');
            $answers = $answers.$answer;
        }

        if (strlen($answers) == 5) {
            echo json_encode(@['code'=>0, 'msg'=>'', 'answers'=>$answers]);
        } else if (strlen($answers == 0)) {
            echo json_encode(@['code'=>1, 'msg'=>'当前用户还未答题', 'answers'=>$answers]);
        } else {
            echo json_encode(@['code'=>2, 'msg'=>'位置错误', 'answers'=>$answers]);
        }
    }

    /**
    *   提交答案,并为用户增加分数
    */
    public function submitQuestionAnswer() {
        $currUserID = $_POST["currUserID"];
        $answers = $_POST["answers"];
        $score = 0;

        $db_question = M('question');
        $db_answer_record = M('answer_record');
        $db_user = M('user');

        // 获取问题列表：id、答案、答案序列
        $questionResult = $db_question->where('question_usable=1 AND fk_question_state_id=7')->field('pk_question_id, question_answer, question_show_order')->select();

        // 防止答案数组出现问题导致错误
        if (strlen($answers) != 5) {
            echo json_encode(@['code'=>1, 'msg'=>'答案数组存在异常', 'result'=>0, 'score'=>0]);
            return;
        }

        // 判断是否存在答题记录，如果有则返回错误信息
        $isExitResult = 0;
        for ($i = 0; $i < count($questionResult); $i++) {
            $result = $db_answer_record->where('fk_answer_record_user_id='.$currUserID.' AND fk_answer_record_question_id='.$questionResult[$i]['pk_question_id'])->select();
            $isExitResult = $isExitResult || $result;
        }
        if ($isExitResult) {
            echo json_encode(@['code'=>2, 'msg'=>'当前用户已答过题了', 'result'=>0, 'score'=>0]);
            return;
        }

        // 对比答案数组与答案序列，并统计分数
        for ($i = 0; $i < count($questionResult); $i++) {
            if ($questionResult[$i]["question_show_order"][$answers[$i] - 1] == 4) {
                $score++;
            }
            $data = array();
            $data['answer_record_answer'] = $answers[$i];
            $data['answer_record_time'] = date("Y-m-d H:i:s");
            $data['fk_answer_record_user_id'] = $currUserID;
            $data['fk_answer_record_question_id'] = $questionResult[$i]["pk_question_id"]; 
            $db_answer_record->add($data);
        }

        // 保存用户答题记录，为用户增加分数
        $oldScore = $db_user->where('pk_user_id='.$currUserID)->getField('user_score');
        $newScore = $score + $oldScore;
        $db_user->where('pk_user_id='.$currUserID)->save(@['user_score'=>$score]);

        echo json_encode(@['code'=>0, 'msg'=>'', 'result'=>1, 'score'=>$score]);
    }

    /**
    *   改变问题收藏记录
    */
    public function changeQuestionCollectionRecord() {
        $currQuestionID = $_POST["currQuestionID"];
        $currUserID = $_POST["currUserID"];
        $currCollected = $_POST["currCollected"];

        $db = M();
        $sql = "call proc_UserCollectQuestionByQuestionIDUserID_InsertOrDelete($currQuestionID, $currUserID, $currCollected)";
        $result = $db->query($sql);

        // 判断是否为数组,如果为数组则添加成功，如果返回false则添加失败
        if (is_array($result)) {
            echo json_encode(@["code"=>0, "msg"=>"", "result"=>1]);
        }
        else {
            echo json_encode(@["code"=>1, "msg"=>"", "result"=>0]);
        }
    }

    /**
    *   添加题目
    */
    public function addQuestion() {
        $questionContent = preg_replace_callback('/[\xf0-\xf7].{3}/', function($r) { return '@E' . base64_encode($r[0]);}, $_POST["questionContent"]);
        $optionOne = preg_replace_callback('/[\xf0-\xf7].{3}/', function($r) { return '@E' . base64_encode($r[0]);}, $_POST["optionOne"]);
        $optionTwo = preg_replace_callback('/[\xf0-\xf7].{3}/', function($r) { return '@E' . base64_encode($r[0]);}, $_POST["optionTwo"]);
        $optionThree = preg_replace_callback('/[\xf0-\xf7].{3}/', function($r) { return '@E' . base64_encode($r[0]);}, $_POST["optionThree"]);
        $answer = preg_replace_callback('/[\xf0-\xf7].{3}/', function($r) { return '@E' . base64_encode($r[0]);}, $_POST["answer"]);
        $currUserID = $_POST["currUserID"];

        // 生成不重复随机4位序列
        $a = array();
        $index = 0;
        for ($i = 1; $i <= 4; $i++) {
            $a[$index ++] = $i;
        }
        for ($index = 3; $index >= 0; $index--) {
            $randomIndex = rand(0, 3);
            $temp = $a[$index];
            $a[$index] = $a[$randomIndex];
            $a[$randomIndex] = $temp;
        }

        $showOrder = "";
        for ($i = 0; $i < 4; $i++) { 
            $showOrder = $showOrder.$a[$i];
        }

        $db = M();
        $sql = "call proc_Question_Insert('$questionContent', '$optionOne', '$optionTwo', '$optionThree', '$answer', '$showOrder', $currUserID)";
        $result = $db->query($sql);

        // 判断是否为数组,如果为数组则添加成功，如果返回false则添加失败
        if (is_array($result)) {
            echo json_encode(@["code"=>0, "msg"=>"", "result"=>1]);
        }
        else {
            echo json_encode(@["code"=>1, "msg"=>"", "result"=>0]);
        }
    }
}