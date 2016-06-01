<?php
namespace Home\Controller;
use Think\Controller;
class CgController extends Controller {
    
    public function selectBookpostByoldBPId(){

        $bptag = $_POST["bptag"];
        $fieldId = $_POST["fieldId"];
        $oldBPId = $_POST["oldBPId"];

        $pageCount = $_POST["pageCount"];
        $currUserId =$_POST["currUserId"];
       

        $db = M();
        $sql = "call proc_C_BookpostByoldBPId_Select($bptag,$fieldId,$oldBPId,$pageCount)";
        $result = $db->query($sql);

        $bookpost = array();
        $user = array();
        $field = array();
        $book =array();
        $i = 0;
        if ($result) {
            foreach ($result as $row) {
             $bookpost[$i]["bookpostId"] = $row["pk_bookpost_id"];
                $bookpost[$i]["bookpostTitle"] = $row["bookpost_title"];
                $bookpost[$i]["fieldName"] = $row["field_name"];
                $bookpost[$i]["bookName"] = $row["book_name"];
                $bookpost[$i]["bookpostSupport"] = $row["bookpost_support"];
                $bookpost[$i]["bookpostReplyNum"] = $row["bookpost_reply_number"];
                $bookpost[$i]["qualifier"] = 1;
                $bookpost[$i]["bookpostTime"] = $row["bookpost_time"];

                $userArr["userId"] = $row["pk_user_id"];
                $user[$i]["userName"] = $row["user_name"];
                $user[$i]["userFaceURL"] = $row["user_face_url"];
                $field[$i]["fieldName"] = $row["field_name"];
                $bookpost[$i]["field"] = $field[$i];
                $bookpost[$i]["user"] = $user[$i];
                $bookpost[$i]["field"] = $field[$i];
                $book[$i]["bookName"] = $row["book_name"];
                $bookpost[$i]["book"] = $book[$i];
                $bookpost[$i]["bookpostContent"] = $row["bookpost_content"];

                $sql42 = "call proc_C_UserCollectBookpostByBPIdUserId($currUserId,".$bookpost[$i]["bookpostId"].")";
                $result42 = $db->query($sql42);
                if (empty($result42)) {
               $bookpost[$i]["collected"] = 0;
                }
                else{
                foreach ($result42 as $row2) {
                  $bookpost[$i]["collected"] = $row2["collect_usable"];
                }
            }


            $sql43 = "call proc_C_BPSupportBycurruserId_Select($currUserId,".$bookpost[$i]["bookpostId"].")";
            $result43 = $db->query($sql43);
            if (empty($result43)) {
               $bookpost[$i]["supported"] = 0;
            }
            else{
                foreach ($result43 as $row2) {
                  $bookpost[$i]["supported"] = $row2["support_record_usable"];
                }
            }
            $i ++;
        }
        echo(json_encode(@['state'=>1,'result'=>$bookpost]));
        }
        else
        {
            echo(json_encode(@['state'=>0,'error'=>mysql_error()]));
        } 
    }
    public function loadHotTrends(){
      
            $pageCount = $_POST["pageCount"];
            $userId = $_POST["currUserId"];
            $stateValue = $_POST["stateValue"];
        // $pageCount = 10;
        // $userId = 1;
        // $stateValue = 2;


            $db = M();
            $user = array();
            $field =array();
            $book =array();
            $i = 0;


            $sql1 = "call WenHuiApartment.proc_C_QuestionByQuestionState_Select($stateValue, 1)";
            $result1 = $db->query($sql1);
            $questionArr = array();
            foreach ($result1 as $row) {
                $questionArr[$i]["questionId"] = $row["pk_question_id"];
                $questionArr[$i]["questionContent"] = $row["question_content"];
                $questionArr[$i]["questionOptionOne"] = $row["question_option_one"];
                $questionArr[$i]["questionOptionTwo"] = $row["question_option_two"];
                $questionArr[$i]["questionOptionThree"] = $row["question_option_three"];
                $questionArr[$i]["questionAnswer"] = $row["question_answer"];
                $questionArr[$i]["questionCollectNumber"] = $row["question_collect_number"];
                $questionArr[$i]["questionTime"] = $row["question_time"];

                $judgeCollectSQL = "call WenHuiApartment.proc_Z_UserCollectQuestionByQuestionIdUserId_Select(".$row["pk_question_id"].", $userId)";
                if (empty($db->query($judgeCollectSQL))) {
                    $questionArr[$i]["collected"] = "0";
                }
                else {
                    $questionArr[$i]["collected"] = "1";
                }

                $userArr = array();
                $userArr["userId"] = $row["pk_user_id"];
                $userArr["userAccount"] = $row["user_account"];
                $userArr["userName"] = $row["user_name"];
                $userArr["userFaceURL"] = $row["user_face_url"];
                $questionArr[$i]["user"] = $userArr;
                $i++;
            }



            //获取辩题信息
            $sql2 = "call WenHuiApartment.proc_C_ThesisByThesisState_Select()";
            $result2 = $db->query($sql2);
            $currThesisArr = array();
            foreach ($result2 as $row) {
                 $currThesisArr[0]["thesisId"] = $row["pk_thesis_id"];
                 $currThesisArr[0]["thesisContent"] = $row["thesis_content"];
                 $currThesisArr[0]["thesisPros"] = $row["thesis_pros"];
                 $currThesisArr[0]["thesisProsCount"] = $row["thesis_pros_count"];
                $currThesisArr[0]["thesisProsReplyNumber"] = $row["thesis_pros_reply_number"];
                $currThesisArr[0]["thesisCons"] = $row["thesis_cons"];
                $currThesisArr[0]["thesisConsCount"] = $row["thesis_cons_count"];
                $currThesisArr[0]["thesisConsReplyNumber"] = $row["thesis_cons_reply_number"];
                $currThesisArr[0]["thesisCollectNumber"] = $row["thesis_collect_number"];
                $currThesisArr[0]["thesisStartTime"] = $row["thesis_start_time"];
                $currThesisArr[0]["thesisEndTime"] = $row["thesis_end_time"];
                $currThesisArr[0]["thesisTime"] = $row["thesis_time"];

            // 判断当前用户是否收藏该辩题，并添加标识属性
                $judgeCollectSQL = "call WenHuiApartment.proc_Z_UserCollectThesisBythesisIdUserId_Select(".$row["pk_thesis_id"].", $userId)";
                if (empty($db->query($judgeCollectSQL))) {
                    $currThesisArr[0]["collected"] = "0";
                }
                else {
                    $currThesisArr[0]["collected"] = "1";
                }

                $stateArr = array();
                $stateArr["stateId"] = $row["pk_state_id"];
                $stateArr["stateName"] = $row["state_name"];
                $stateArr["stateValue"] = $row["state_value"];
                $stateArr["stateType"] = $row["state_type"];
                $stateArr["stateTime"] = $row["state_time"];
                $currThesisArr[0]["state"] = $stateArr;
                break;
            }


        //获取对联信息
            $sql3 = "call WenHuiApartment.proc_Z_CoupletByCoupletTime_Select($pageCount)";
            $result3 = $db->query($sql3);
            $coupletArr = array();
            $i = 0;
            foreach ($result3 as $row) {
                $coupletArr[$i]["coupletId"] = $row["pk_couplet_id"];
                $coupletArr[$i]["coupletContent"] = $row["couplet_content"];
                $coupletArr[$i]["coupletReplyNumber"] = $row["couplet_reply_number"];
                $coupletArr[$i]["coupletSupport"] = $row["couplet_support"];
                $coupletArr[$i]["coupletTime"] = $row["couplet_time"];

                $judgeSupportSQL = "call WenHuiApartment.proc_Z_CoupletSupRecordByCoupletIdUserId_Select(".$row["pk_couplet_id"].", $userId)";
                if (empty($db->query($judgeSupportSQL))) {
                    $coupletArr[$i]["supported"] = "0";
                }
                else {
                    $coupletArr[$i]["supported"] = "1";
                }   
                $judgeCollectSQL = "call WenHuiApartment.proc_Z_UserCollectCoupletByCoupletIdUserId_Select(".$row["pk_couplet_id"].", $userId)";
                if (empty($db->query($judgeCollectSQL))) {
                    $coupletArr[$i]["collected"] = "0";
                }
                else {
                    $coupletArr[$i]["collected"] = "1";
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

        //获取观点交流信息
            $sql4 = "call proc_C_Bookpost_Select($pageCount)";
            $result4 = $db->query($sql4);
            $bookpost = array();
            $user = array();
            $field = array();
            $book =array();
            $i = 0;
            foreach ($result4 as $row) {
                 $bookpost[$i]["bookpostId"] = $row["pk_bookpost_id"];
                $bookpost[$i]["bookpostTitle"] = $row["bookpost_title"];
                $bookpost[$i]["fieldName"] = $row["field_name"];
                $bookpost[$i]["bookName"] = $row["book_name"];
                $bookpost[$i]["bookpostSupport"] = $row["bookpost_support"];
                $bookpost[$i]["bookpostReplyNum"] = $row["bookpost_reply_number"];
                $bookpost[$i]["qualifier"] = 1;
                $bookpost[$i]["bookpostTime"] = $row["bookpost_time"];

                $user[$i]["userName"] = $row["user_name"];
                $user[$i]["userFaceURL"] = $row["user_face_url"];
                $field[$i]["fieldName"] = $row["field_name"];
                $bookpost[$i]["field"] = $field[$i];
                $bookpost[$i]["user"] = $user[$i];
                $bookpost[$i]["field"] = $field[$i];
                $book[$i]["bookName"] = $row["book_name"];
                $bookpost[$i]["book"] = $book[$i];
                $bookpost[$i]["bookpostContent"] = $row["bookpost_content"];

                $sql42 = "call proc_C_UserCollectBookpostByBPIdUserId($userId,".$bookpost[$i]["bookpostId"].")";
                $result42 = $db->query($sql42);
                if (empty($result42)) {
                    $bookpost[$i]["collected"] = 0;
                }
                else{
                    foreach ($result42 as $row2) {
                        $bookpost[$i]["collected"] = $row2["collect_usable"];
                    }
                }
            


                $sql43 = "call proc_C_BPSupportBycurruserId_Select($userId,".$bookpost[$i]["bookpostId"].")";
                $result43 = $db->query($sql43);
                if (empty($result43)) {
                    $bookpost[$i]["supported"] = 0;
                }
                else{
                    foreach ($result43 as $row2) {
                        $bookpost[$i]["supported"] = $row2["support_record_usable"];
                    }
                }
                $i ++;
            }
        $receive = array($questionArr,$currThesisArr,$bookpost,$coupletArr);
        echo(json_encode($receive));

    }
    
      /**
    *   获取问题
    */
    public function getQuestion() {
        $userId = $_POST["currUserId"];
        $pageCount = $_POST["pageCount"];
        $stateValue = $_POST["stateValue"];

        $db = M();
        $sql = "call WenHuiApartment.proc_Z_QuestionByQuestionState_Select($stateValue, $pageCount)";
        $result = $db->query($sql);

        $questionArr = array();
        $i = 0;
        foreach ($result as $row) {
            $questionArr[$i]["questionId"] = $row["pk_question_id"];
            $questionArr[$i]["questionContent"] = $row["question_content"];
            $questionArr[$i]["questionOptionOne"] = $row["question_option_one"];
            $questionArr[$i]["questionOptionTwo"] = $row["question_option_two"];
            $questionArr[$i]["questionOptionThree"] = $row["question_option_three"];
            $questionArr[$i]["questionAnswer"] = $row["question_answer"];
            $questionArr[$i]["questionCollectNumber"] = $row["question_collect_number"];
            $questionArr[$i]["questionTime"] = $row["question_time"];

            $judgeCollectSQL = "call WenHuiApartment.proc_Z_UserCollectQuestionByQuestionIdUserId_Select(".$row["pk_question_id"].", $userId)";
            if (empty($db->query($judgeCollectSQL))) {
                $questionArr[$i]["collected"] = "0";
            }
            else {
                $questionArr[$i]["collected"] = "1";
            }

            $userArr = array();
            $userArr["userId"] = $row["pk_user_id"];
            $userArr["userAccount"] = $row["user_account"];
            $userArr["userName"] = $row["user_name"];
            $userArr["userFaceURL"] = $row["user_face_url"];
            $questionArr[$i]["user"] = $userArr;
            $i++;
        }
        echo json_encode($questionArr);
    }


    ///观点交流搜索框搜索数据
    public function selectBookpostBysearchtext(){
        $searchtext = $_POST["searchtext"];
        $bptag = $_POST["bptag"];
        $fieldId = $_POST["fieldId"];
        $oldBPId = $_POST["oldBPId"];

        $pageCount = $_POST["pageCount"];
        $curruserId = $_POST["curruserId"];
         // $searchtext = '是';
        // $bptag = 0;
        // $fieldId = 0;
        // $oldBPId = 100;

        // $pageCount = 10;
        // $curruserId = 2;

        $searchtext = '%'.$searchtext.'%';
        $db = M();
        $sql = "call proc_C_BookpostBysearchtext_Select('$searchtext',$bptag,$fieldId,$oldBPId,$pageCount)";
        $result = $db->query($sql);
        $bookpost = array();
        $user = array();
        $field = array();
        $book =array();
        $i = 0;
        if ($result) {
            foreach ($result as $row) {
             $bookpost[$i]["bookpostId"] = $row["pk_bookpost_id"];
                $bookpost[$i]["bookpostTitle"] = $row["bookpost_title"];
                $bookpost[$i]["fieldName"] = $row["field_name"];
                $bookpost[$i]["bookName"] = $row["book_name"];
                $bookpost[$i]["bookpostSupport"] = $row["bookpost_support"];
                $bookpost[$i]["bookpostReplyNum"] = $row["bookpost_reply_number"];
                $bookpost[$i]["qualifier"] = 1;
                $bookpost[$i]["bookpostTime"] = $row["bookpost_time"];

                $user[$i]["userName"] = $row["user_name"];
                $user[$i]["userFaceURL"] = $row["user_face_url"];
                $field[$i]["fieldName"] = $row["field_name"];
                $bookpost[$i]["field"] = $field[$i];
                $bookpost[$i]["user"] = $user[$i];
                $bookpost[$i]["field"] = $field[$i];
                $book[$i]["bookName"] = $row["book_name"];
                $bookpost[$i]["book"] = $book[$i];
                $bookpost[$i]["bookpostContent"] = $row["bookpost_content"];

                $sql42 = "call proc_C_UserCollectBookpostByBPIdUserId($userId,".$bookpost[$i]["bookpostId"].")";
                $result42 = $db->query($sql42);
                if (empty($result42)) {
               $bookpost[$i]["collected"] = 0;
                }
                else{
                foreach ($result42 as $row2) {
                  $bookpost[$i]["collected"] = $row2["collect_usable"];
                }
            }


            $sql43 = "call proc_C_BPSupportBycurruserId_Select($userId,".$bookpost[$i]["bookpostId"].")";
            $result43 = $db->query($sql43);
            if (empty($result43)) {
               $bookpost[$i]["supported"] = 0;
            }
            else{
                foreach ($result43 as $row2) {
                  $bookpost[$i]["supported"] = $row2["support_record_usable"];
                }
            }
            $i ++;
        }
        echo(json_encode(@['state'=>1,'result'=>$bookpost]));
        }
        else
        {
            echo(json_encode(@['state'=>0,'error'=>mysql_error()]));
        }
        
    }
    public function updateBPCommentSupportBystates(){
        $bpcId = $_POST["bpcId"];
        $curruserId =$_POST["curruserId"];
        $states = $_POST["states"];

        $db=M("");
        $sql="call proc_C_BPCommentSupport_Update($bpcId,$curruserId,$states)";
        $result = $db->query($sql);
        $qualifier = array();
        if (!($result)) {
            $qualifier =array("qualifier" =>1,'state'=>$states);
        }
        else{
            $qualifier = array("qualifier" =>0);
        }
        echo(json_encode($qualifier));
    
    }
    public function updateBPCRSupportBystates(){
        $bpcrId = $_POST["bpcrId"];
        $curruserId =$_POST["curruserId"];
        $states = $_POST["states"];

        $db=M("");
        $sql="call proc_C_BPCRSupport_Update($bpcrId,$curruserId,$states)";
        $result = $db->query($sql);
        $qualifier = array();
        if (!($result)) {
            $qualifier =@["qualifier" =>1,'state'=>$states];
        }
        else{
            $qualifier = array("qualifier" =>0);
        }
        echo(json_encode($qualifier));
    
    }
    public function selectBPCReplyByoldbprcId(){
        $oldBPCReplyId = $_POST["oldBPCReplyId"];
        $bpcId = $_POST["bpcId"];
        $countNum = $_POST["countNum"];
        $curruserId = $_POST["curruserId"];


        $db =M("");
        $sql1 = "call proc_BPCReplyByoldbprcId_Select($oldBPCReplyId,$bpcId,$countNum)";
        $result1 = $db->query($sql1);
        $bpcReply = array();
        $user = array();
        $receiver = array();
        $bpComment = array();
     
        $i = 0;
        foreach ($result1 as $row) {
            $bpcReply[$i]["replyId"] = $row["pk_reply_id"];
            $bpcReply[$i]["replyContent"] = $row["reply_content"];
            $bpcReply[$i]["replySupport"] = $row["reply_support"];
            $bpcReply[$i]["replyTime"] = $row["reply_time"];

            $user[$i]["userId"] = $row["pk_user_id"];
            $user[$i]["userName"] = $row["user_name"];
            $user[$i]["userFaceURL"] = $row["user_face_url"];
            $bpcReply[$i]["user"] = $user[$i];

            $receiver[$i]["userId"] = $row["receiverId"];
            $receiver[$i]["userName"] = $row["receiverName"];
            $bpcReply[$i]["receiver"] = $receiver[$i];

            $bpComment[$i]["commentId"] = $row["pk_bookpost_comment_id"];
            $bpComment[$i]["commentContent"] = $row["comment_content"];
            $bpcReply[$i]["comment"] = $bpComment[$i];


            $sql2 = "call proc_C_BPCRSupportBycurruserId_Select($curruserId,".$bpcReply[$i]["replyId"].")";
            $result2 = $db->query($sql2);
            if (empty($result2)) {
                $bpcReply[$i]["supported"] = 0;
            }
            else{
                foreach ($result2 as $row2) {
                  $bpcReply[$i]["supported"] = $row2["support_record_usable"];
                }
            }

            $i ++;
        }

        echo(json_encode($bpcReply));

    }
    public function addBPCommentSupportRecord(){
        $bpcId = $_POST["bpcId"];
        $userId =$_POST["userId"];

        $db=M("");
        $sql="call proc_C_addBPCommentSupportRecord($bpcId,$userId)";
        $result = $db->query($sql);
        $qualifier = array();
        if (is_array($result)) {
            $qualifier =array("qualifier" =>1);
        }
        else{
            $qualifier = array("qualifier" =>0);
        }
        echo(json_encode($qualifier));
    }
    public function addBPCReplySupportRecord(){
        $bpcrId = $_POST["bpcrId"];
        $userId =$_POST["userId"];

        $db=M("");
        $sql2 = "call proc_C_BPCRSupportBycurruserId_Select($userId,$bpcrId)";
            $result2 = $db->query($sql2);
            if (empty($result2)) {
                $bpcReply[$i]["supported"] = 0;
            }
            else{
                foreach ($result2 as $row2) {
                  $bpcReply[$i]["supported"] = $row2["support_record_usable"];
                }
            }


        $sql="call proc_C_addBPCReplySupportRecord($bpcrId,$userId)";
        $result = $db->query($sql);
        $qualifier = array();
        if (is_array($result)) {
            $qualifier =array("qualifier" =>1);
        }
        else{
            $qualifier = array("qualifier" =>0);
        }
        echo(json_encode($qualifier));
    }
    public function  insertBPCReply(){
        $bpcId = $_POST["bpcId"];
        $userId = $_POST["userId"];
        $receiverId = $_POST["receiverId"];
        $replyContent = $_POST["replyContent"];

        $db = M("");
        $sql = "call proc_C_BPCReply_Insert($bpcId,$userId,$receiverId,'$replyContent')";
        $result = $db->query($sql);
        $qualifier = array();
        if (is_array($result)) {
            $qualifier =array("qualifier" =>1);
        }
        else{
            $qualifier = array("qualifier" =>0);
        }
        echo(json_encode($qualifier));
    }
    public function selectBPCReplyBybpcId(){
        $bpcId = $_POST["bpcId"];
        $pageCount = $_POST["pageCount"];
        $curruserId = $_POST["curruserId"];
        
        $db = M("");
        $sql = "call proc_C_BPCReplyBybpcId_Select($bpcId,$pageCount)";
        $result = $db->query($sql);

        $bpcReply = array();
        $user = array();
        $receiver = array();
        $bpComment = array();
        $i = 0;
        foreach ($result as $row) {
            $bpcReply[$i]["replyId"] = $row["pk_reply_id"];
            $bpcReply[$i]["replyContent"] = $row["reply_content"];
            $bpcReply[$i]["replySupport"] = $row["reply_support"];
            $bpcReply[$i]["replyTime"] = $row["reply_time"];

            $user[$i]["userId"] = $row["pk_user_id"];
            $user[$i]["userName"] = $row["user_name"];
            $user[$i]["userFaceURL"] = $row["user_face_url"];
            $bpcReply[$i]["user"] = $user[$i];

            $receiver[$i]["userId"] = $row["receiverId"];
            $receiver[$i]["userName"] = $row["receiverName"];
            $bpcReply[$i]["receiver"] = $receiver[$i];

            $bpComment[$i]["commentId"] = $row["pk_bookpost_comment_id"];
            $bpComment[$i]["commentContent"] = $row["comment_content"];
            $bpcReply[$i]["comment"] = $bpComment[$i];

            $sql2 = "call proc_C_BPCRSupportBycurruserId_Select($curruserId,".$bpcReply[$i]["replyId"].")";
            $result2 = $db->query($sql2);
            if (empty($result2)) {
                $bpcReply[$i]["supported"] = 0;
            }
            else{
                foreach ($result2 as $row2) {
                  $bpcReply[$i]["supported"] = $row2["support_record_usable"];
                }
            }

            $i ++;
        }
        echo(json_encode($bpcReply));
    }
    public function selectBPCommentBybpIdOldBPCId(){
        $bpId = $_POST["bpId"];
        $oldBPCId = $_POST["oldBPCId"];
        $pageCount = $_POST["pageCount"];
        $curruserId = $_POST["curruserId"];
        // $bpId = 2;
        // $oldBPCId = 100;
        // $pageCount = 10;
        // $curruserId = 2;
        $db = M("");
        $sql = "call proc_C_BPCommentBybpIdOldBPCId_Select($bpId,$oldBPCId,$pageCount)";
        $result = $db->query($sql);
        $bpComment = array();
        $user = array();
        $i = 0;

        foreach ($result as $row) {
            $bpComment[$i]["commentId"] = $row["pk_bookpost_comment_id"];
            $bpComment[$i]["commentContent"] = $row["comment_content"];
            $bpComment[$i]["commentSupport"] = $row["comment_support"];
            $bpComment[$i]["commentTime"] = $row["comment_time"];
            $bpComment[$i]["commentPosition"] = $row["comment_position"];

            $bpComment[$i]["commentReplyNumber"] = $row["comment_reply_number"];
            
            $user[$i]["userId"] = $row["pk_user_id"];
            $user[$i]["userName"] = $row["user_name"];
            $user[$i]["userFaceURL"] = $row["user_face_url"];
            $bpComment[$i]["user"] = $user[$i];


            $sql2 = "call proc_C_BPCommnetSupportBycurruserId_Select($curruserId,".$bpComment[$i]["commentId"].")";
            $result2 = $db->query($sql2);
            if (empty($result2)) {
                $bpComment[$i]["supported"] = 0;
            }
            else{
                foreach ($result2 as $row2) {
                  $bpComment[$i]["supported"] = $row2["support_record_usable"];
                }
            }


            $i++;
        }
        echo(json_encode($bpComment));

    }
    public function insertBPComment(){
        $replyContent =$_POST["replyContent"];
        $bookpostId = $_POST["bookpostId"];
        $userId =$_POST["userId"];

        $db = M("");
        $sql = "call proc_C_BookpostComment_Insert('$replyContent',$bookpostId,$userId)";
        $result = $db->query($sql);
        $qualifier = array();
        if (is_array($result)) {
            $qualifier = array("qualifier"=>1);
        } else {
            $qualifier = array("qualifier"=>0);
        }
        echo(json_encode($qualifier));
        
    }
    public function selectBPCommentBybpId(){
        $bpId = $_POST["bpId"];
        $curruserId = $_POST["curruserId"];
        $pageCount = $_POST["pageCount"];
        $db = M("");
        $sql = "call proc_C_BPCommentBybpId_Select($bpId,$pageCount)";
        $result = $db->query($sql);
        $bpComment = array();
        $user = array();
        $i = 0;

        foreach ($result as $row) {
            $bpComment[$i]["commentId"] = $row["pk_bookpost_comment_id"];
            $bpComment[$i]["commentContent"] = $row["comment_content"];
            $bpComment[$i]["commentSupport"] = $row["comment_support"];
            $bpComment[$i]["commentTime"] = $row["comment_time"];
            $bpComment[$i]["commentReplyNumber"] = $row["comment_reply_number"];

            $bpComment[$i]["commentPosition"] = $row["comment_position"];
            $user[$i]["userId"] = $row["pk_user_id"];
            $user[$i]["userName"] = $row["user_name"];
            $user[$i]["userFaceURL"] = $row["user_face_url"];
            $bpComment[$i]["user"] = $user[$i];

            $sql2 = "call proc_C_BPCommnetSupportBycurruserId_Select($curruserId,".$bpComment[$i]["commentId"].")";
            $result2 = $db->query($sql2);
            if (empty($result2)) {
                $bpComment[$i]["supported"] = 0;
            }
            else{
                foreach ($result2 as $row2) {
                  $bpComment[$i]["supported"] = $row2["support_record_usable"];
                }
            }



            $i ++;
        }
        echo(json_encode($bpComment));

    }
    public function insertBookpostBook(){
        $content = $_POST["content"];
        $title = $_POST["title"];
        $userId = $_POST["userId"];
        $fieldId = $_POST["fieldId"];
        $bookName = $_POST["bookName"];
        $position = $_POST["position"];
       

        $db = M("t");
        $sql = "call proc_C_BookpostBook_Insert('$content','$title',$userId,$fieldId,'$bookName','$position')";
        $result = $db->query($sql);
        if (is_array($result)) {
            $qualifier = array("qualifier"=>"1");
        } else {
            $qualifier = array("qualifier"=>"0");
        }
        echo(json_encode($qualifier));
        
    }
    public function getBookpostBybpTagField(){
       
         $field = $_POST["fieldId"];
        $bpTag = $_POST["bpTag"];
        $pageCount = $_POST["pageCount"];
        $curruserId = $_POST["currUserId"];
        
        
        $db = M("t_field");

        $sql ="call proc_C_BookpostBybpTagField_Select($field,$bpTag,$pageCount)";
        $sql2 = "call proc_C_BookPostBybpTag_Select($pageCount,$bpTag)"; 
        
        if ($field ==0) {
            $result = $db->query($sql2);
        } else {
            $result = $db->query($sql);
        }
        
        

        $bookpost = array();
        $user = array();
        $field = array();
        $book = array();
        $i = 0;
        if ($result) {
             foreach ($result as $row) {
                $bookpost[$i]["bookpostId"] = $row["pk_bookpost_id"];
                $bookpost[$i]["bookpostTitle"] = $row["bookpost_title"];
                $bookpost[$i]["fieldName"] = $row["field_name"];
                $bookpost[$i]["bookName"] = $row["book_name"];
                $bookpost[$i]["bookpostSupport"] = $row["bookpost_support"];
                $bookpost[$i]["bookpostReplyNum"] = $row["bookpost_replyNum"];
                $bookpost[$i]["qualifier"] = 1;
                $bookpost[$i]["bookpostTime"] = $row["bookpost_time"];

                $user[$i]["userId"] = $row["pk_user_id"];
                $user[$i]["userName"] = $row["user_name"];
                $user[$i]["userFaceURL"] = $row["user_face_url"];
                $field[$i]["fieldName"] = $row["field_name"];
                $field[$i]["fieldId"] = $row["pk_field_id"];
                $bookpost[$i]["field"] = $field[$i];
                $bookpost[$i]["user"] = $user[$i];
                $book[$i]["bookId"] = $row["pk_book_id"];
                $book[$i]["bookName"] = $row["book_name"];
                $bookpost[$i]["book"] = $book[$i];

                $bookpost[$i]["bookpostContent"] = $row["bookpost_content"];
                $i ++;
            }
        
        echo(json_encode(@['state'=>1,'result'=>$bookpost]));
        }
        else
        {
            echo(json_encode(@['state'=>0,'error'=>mysql_error()]));
        } 

    }

    public function getField(){
        $sd = M("t_field");
        // $sql = "call proc_C_Field_Select()";
        // $result = $sd->query($sql);
        $result = $sd->select();
        $field = array();
        $i = 0;
        foreach ($result as $row) {
           $field[$i]["fieldName"] = $row["field_name"];
            $field[$i]["fieldId"] = $row["pk_field_id"]; 
           $i ++;
        }
        echo(json_encode($field));

    }
    public function getBookpostBybpTag()
    {
        // $pageCount = $_POST["pageCount"];
        // $bpTag = $_POST["bpTag"];
        $pageCount = 10;
        $bpTag = 1;

        $db = M("");
        $sql = "call proc_C_BookpostBybpTag_Select($pageCount,$bpTag)";
        $result = $db->query($sql);
        $bookpost = array();
        $user = array();
        $field = array();
        $book =array();
        $comment = array();
        $i = 0;
        foreach ($result as $row) {
                $bookpost[$i]["bookpostId"] = $row["pk_bookpost_id"];
                $bookpost[$i]["bookpostTitle"] = $row["bookpost_title"];
                $bookpost[$i]["fieldName"] = $row["field_name"];
                $bookpost[$i]["bookName"] = $row["book_name"];
                $bookpost[$i]["bookpostSupport"] = $row["bookpost_support"];
                $bookpost[$i]["bookpostReplyNum"] = $row["bookpost_replyNum"];
                $bookpost[$i]["qualifier"] = 1;
                $bookpost[$i]["bookpostTime"] = $row["bookpost_time"];

               $user[$i]["userId"] = $row["pk_user_id"];
                $user[$i]["userName"] = $row["user_name"];
                $user[$i]["userFaceURL"] = $row["user_face_url"];
                $field[$i]["fieldName"] = $row["field_name"];
                $bookpost[$i]["field"] = $field[$i];
                $bookpost[$i]["user"] = $user[$i];
                $bookpost[$i]["field"] = $field[$i];
                $book[$i]["bookName"] = $row["book_name"];
                $bookpost[$i]["book"] = $book[$i];
                $bookpost[$i]["bookpostContent"] = $row["bookpost_content"];


                $sql42 = "call proc_C_UserCollectBookpostByBPIdUserId($userId,".$bookpost[$i]["bookpostId"].")";
                $result42 = $db->query($sql42);
                if (empty($result42)) {
                    $bookpost[$i]["collected"] = 0;
                }
                else{
                    foreach ($result42 as $row2) {
                        $bookpost[$i]["collected"] = $row2["collect_usable"];
                    }
                }

                $sql43 = "call proc_C_BPSupportBycurruserId_Select($userId,".$bookpost[$i]["bookpostId"].")";
                $result43 = $db->query($sql43);
                if (empty($result43)) {
                    $bookpost[$i]["supported"] = 0;
                }
                else{
                    foreach ($result43 as $row2) {
                        $bookpost[$i]["supported"] = $row2["support_record_usable"];
                    }
                }
                $bpId = $row["pk_bookpost_id"];
                $sql44 ="call proc_C_BPComment_mostSupport_Select($bpId)";
                $result44 = $db->query($sql44);
                // if (empty($result44)) {
                //    $comment[$i]["commentContent"] = "";
                // }
                // else{
                //      foreach ($result44 as $row4) {
                //         $comment[$i]["commentContent"] = $row4["comment_content"];
                //     }
                // }
                // $bookpost[$i]["comment"] = $comment[$i];
                if (empty($result44)) {
                   $bookpost[$i]["commentContent"] = "";
                }
                else{
                     foreach ($result44 as $row4) {
                        $bookpost[$i]["commentContent"] = $row4["comment_content"];
                    }
                }
                
                $i ++;
        }
        echo(json_encode($bookpost));

    }
    public function getHotTrends(){
        $recordCount = $_POST["recordCount"];
        $getDataTime = $_POST["getDataTime"];
        
        $sd=M("t_users");
        $result1 = $sd->query("call proc_C_QuestionByTime('$getDataTime')");
        
        $result2 = $sd->query("call proc_C_ArgumentByTime()");
        $result3 = $sd->query("call proc_C_BooKpostCoupletBYSupportSelect('$getDataTime',$recordCount)");
        $receive1 = array();
        $receive2 = array();
        $receive3 = array();
        $user = array();
        $field =array();
        $book =array();
        $i = 0;
        foreach ($result1 as $row) {
            $receive1[$i]["questionId"] = $row["pk_question_id"];
            $receive1[$i]["questionContent"]= $row["question_content"];
            $receive1[$i]["questionOptionOne"] = $row["question_option_one"];
            $receive1[$i]["questionOptionTwo"]= $row["question_option_two"];
            $receive1[$i]["questionOptionThree"] = $row["question_option_three"];
            $receive1[$i]["questionAnswer"]= $row["question_answer"];
            $receive1[$i]["qualifier"] = 3;
            $receive1[$i]["questionTime"] = $row["question_time"];
            // $receive1[$i]["userName"] = $row["user_name"];
            // $receive1[$i]["userFaceURL"] = $row["user_face_url"];

            $user[$i]["userName"] = $row["user_name"];
                $user[$i]["userFaceURL"] = $row["user_face_url"];
                $receive1[$i]["user"] = $user[$i];
            $i ++;
        }
        $i = 0;
        foreach ($result2 as $row) {
            $receive2[$i]["thesisId"]=$row["pk_thesis_id"];
            $receive2[$i]["thesisContent"] = $row["thesis_content"];
            $receive2[$i]["thesisPros"] = $row["thesis_pros"];
            $receive2[$i]["thesisCons"] = $row["thesis_cons"];
            $receive2[$i]["thesisProCount"] = $row["thesis_pros_count"];
            $receive2[$i]["thesisConsCount"] = $row["thesis_cons_count"];
            $receive2[$i]["qualifier"] = 4;
            $receive2[$i]["thesisStartTime"] =$row["thesis_start_time"];
            $receive2[$i]["thesisEndTime"] = $row["thesis_end_time"];
            $i ++;
        }
        $i = 0;
        foreach ($result3 as $row) {
            if ($row["1"]==1) {
                $receive3[$i]["bookpostId"] = $row["pk_bookpost_id"];
                $receive3[$i]["bookpostTitle"] = $row["bookpost_title"];
                $receive3[$i]["fieldName"] = $row["field_name"];
                $receive3[$i]["bookName"] = $row["book_name"];
                $receive3[$i]["bookpostSupport"] = $row["bookpost_support"];
                $receive3[$i]["bookpostReplyNum"] = $row["bookpost_replyNum"];
                $receive3[$i]["qualifier"] = $row["1"];
                $receive3[$i]["bookpostTime"] = $row["bookpost_time"];

                $user[$i]["userName"] = $row["user_name"];
                $user[$i]["userFaceURL"] = $row["user_face_url"];
                $field[$i]["fieldName"] = $row["field_name"];
                $book[$i]["bookName"] = $row["book_name"];
                $receive3[$i]["book"] = $book[$i];
                $receive3[$i]["user"] = $user[$i];
                $receive3[$i]["field"] = $field[$i];
                $i ++;
            }
            elseif ($row["1"]==2) {
                 $receive3[$i]["coupletId"] = $row["pk_bookpost_id"];
                $receive3[$i]["coupletContent"] = $row["bookpost_title"];
                $receive3[$i]["userName"] = $row["user_name"];
                $receive3[$i]["coupletSupport"] = $row["bookpost_support"];
                $receive3[$i]["coupletReplyNumber"] = $row["bookpost_replyNum"];
                $receive3[$i]["qualifier"] = $row["1"];
                $receive3[$i]["coupletTime"] = $row["bookpost_time"];
                $user[$i]["userName"] = $row["user_name"];
                $user[$i]["userFaceURL"] = $row["user_face_url"];
                $receive3[$i]["user"] = $user[$i];
                
              
                $i ++;
            }

        }

        $receive = array($receive1,$receive2,$receive3);
        echo(json_encode($receive));
      
    }
    

}