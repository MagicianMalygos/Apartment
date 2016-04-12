<?php
namespace Home\Controller;
use Think\Controller;
class CommunionController extends Controller {

    // 根据条件搜索图书贴：关键字、排序方式、所属领域
    public function getBookpostBySearchTextSortMethodFieldID() {

        $searchText = '%'.$_POST['searchText'].'%';
        $sortMethod = $_POST['sortMethod'];
        $fieldID = $_POST['fieldID'];
        $currUserID = $_POST['currUserID'];
        $pagination = $_POST['pagination'];
        $pageCount = $_POST['pageCount'];
        $pageIndex = ($pagination - 1) * $pageCount;
        
        $db = M();
        $sql ="call proc_Bp_SelectByMultiCondition('$searchText', $sortMethod, $fieldID, $pageIndex, $pageCount)";
        $result = $db->query($sql);

        $bookpostArr = array();
        $i = 0;
        if ($result) {
             foreach ($result as $row) {
                $bookpostArr[$i]["bookpostId"] = $row["pk_bookpost_id"];
                $bookpostArr[$i]["bookpostTitle"] = $row["bookpost_title"];
                $bookpostArr[$i]["bookpostContent"] = $row["bookpost_content"];
                $bookpostArr[$i]["bookpostBookName"] = $row["bookpost_book_name"];
                $bookpostArr[$i]["bookpostSupport"] = $row["bookpost_support"];
                $bookpostArr[$i]["bookpostReplyNumber"] = $row["bookpost_reply_number"];
                $bookpostArr[$i]["bookpostCollectNumber"] = $row["bookpost_collect_number"];
                $bookpostArr[$i]["bookpostTime"] = $row["bookpost_time"];

                $userArr = array();
                $userArr["userId"] = $row["pk_user_id"];
                $userArr["userAccount"] = $row["user_account"];
                $userArr["userName"] = $row["user_name"];
                $userArr["userAge"] = $row["user_age"];
                $userArr["userFaceURL"] = $row["user_face_url"];
                $userArr["userEXP"] = $row["user_exp"];
                $bookpostArr[$i]["user"] = $userArr;

                $fieldArr = array();
                $fieldArr["fieldId"] = $row["pk_field_id"];
                $fieldArr["fieldName"] = $row["field_name"];
                $bookpostArr[$i]["field"] = $fieldArr;

                $judgeCollectSQL = "call proc_UserCollectBpByBookpostIDUserID_Select(".$row["pk_bookpost_id"].", $currUserID)";
                if (empty($db->query($judgeCollectSQL))) {
                    $bookpostArr[$i]["collected"] = 0;
                }
                else {
                    $bookpostArr[$i]["collected"] = 1;
                }
                $judgeSupportSQL = "call proc_UserSupportBpByBookpostIDUserID_Select(".$row["pk_bookpost_id"].", $currUserID)";
                if (empty($db->query($judgeSupportSQL))) {
                    $bookpostArr[$i]["supported"] = 0;
                }
                else {
                    $bookpostArr[$i]["supported"] = 1;
                }
                $i ++;
            }
        }
        echo(json_encode(@['data'=>@["aList"=>$bookpostArr]]));
    }

    // 根据用户ID得到该用户所发过的图书贴
    public function getBookpostByUserID() {

        $currUserID = $_POST['currUserID'];
        $myUserID = $_POST['myUserID'];
        $pagination = $_POST['pagination'];
        $pageCount = $_POST['pageCount'];
        $pageIndex = ($pagination - 1) * $pageCount;
        
        $db = M();
        $db_user = M('user');
        $db_field = M('field');
        $db_bookpost = M('bookpost');
        $result = $db_bookpost->where('bookpost_usable=1 AND fk_bp_user_id='.$currUserID)->order('bookpost_time desc')->limit($pageIndex.','.$pageCount)->select();

        $bookpostArr = array();
        $i = 0;
        if ($result) {
             foreach ($result as $row) {
                $bookpostArr[$i]["bookpostId"] = $row["pk_bookpost_id"];
                $bookpostArr[$i]["bookpostTitle"] = $row["bookpost_title"];
                $bookpostArr[$i]["bookpostContent"] = $row["bookpost_content"];
                $bookpostArr[$i]["bookpostBookName"] = $row["bookpost_book_name"];
                $bookpostArr[$i]["bookpostSupport"] = $row["bookpost_support"];
                $bookpostArr[$i]["bookpostReplyNumber"] = $row["bookpost_reply_number"];
                $bookpostArr[$i]["bookpostCollectNumber"] = $row["bookpost_collect_number"];
                $bookpostArr[$i]["bookpostTime"] = $row["bookpost_time"];

                $userArr = array();
                $userResult = $db_user->where('pk_user_id='.$row['fk_bp_user_id'])->select();
                $userArr["userId"] = $userResult[0]["pk_user_id"];
                $userArr["userAccount"] = $userResult[0]["user_account"];
                $userArr["userName"] = $userResult[0]["user_name"];
                $userArr["userAge"] = $userResult[0]["user_age"];
                $userArr["userFaceURL"] = $userResult[0]["user_face_url"];
                $userArr["userEXP"] = $userResult[0]["user_exp"];
                $bookpostArr[$i]["user"] = $userArr;

                $fieldArr = array();
                $fieldResult = $db_field->where('pk_field_id='.$row['fk_bp_field_id'])->select();
                $fieldArr["fieldId"] = $fieldResult[0]["pk_field_id"];
                $fieldArr["fieldName"] = $fieldResult[0]["field_name"];
                $bookpostArr[$i]["field"] = $fieldArr;

                $judgeCollectSQL = "call proc_UserCollectBpByBookpostIDUserID_Select(".$row["pk_bookpost_id"].", $myUserID)";
                if (empty($db->query($judgeCollectSQL))) {
                    $bookpostArr[$i]["collected"] = 0;
                }
                else {
                    $bookpostArr[$i]["collected"] = 1;
                }
                $judgeSupportSQL = "call proc_UserSupportBpByBookpostIDUserID_Select(".$row["pk_bookpost_id"].", $myUserID)";
                if (empty($db->query($judgeSupportSQL))) {
                    $bookpostArr[$i]["supported"] = 0;
                }
                else {
                    $bookpostArr[$i]["supported"] = 1;
                }
                $i ++;
            }
        }
        echo(json_encode(@['data'=>@["aList"=>$bookpostArr]]));
    }

    // 根据用户ID得到该用户收藏的图书贴
    public function getCollectedBookpostByUserID() {

        $currUserID = $_POST['currUserID'];
        $myUserID = $_POST['myUserID'];
        $pagination = $_POST['pagination'];
        $pageCount = $_POST['pageCount'];
        $pageIndex = ($pagination - 1) * $pageCount;
        
        $db = M();
        $db_user = M('user');
        $db_field = M('field');
        $db_bookpost = M('bookpost');
        $db_bookpost_collect = M('user_collect_bookpost');
        $result = $db_bookpost_collect->where('collect_usable=1 AND fk_ucbp_user_id='.$currUserID)->limit($pageIndex.','.$pageCount)->join('__BOOKPOST__ on __BOOKPOST__.pk_bookpost_id=__USER_COLLECT_BOOKPOST__.fk_ucbp_bookpost_id', 'LEFT')->order('bookpost_time desc')->select();

        $bookpostArr = array();
        $i = 0;
        if ($result) {
             foreach ($result as $row) {
                $bookpostArr[$i]["bookpostId"] = $row["pk_bookpost_id"];
                $bookpostArr[$i]["bookpostTitle"] = $row["bookpost_title"];
                $bookpostArr[$i]["bookpostContent"] = $row["bookpost_content"];
                $bookpostArr[$i]["bookpostBookName"] = $row["bookpost_book_name"];
                $bookpostArr[$i]["bookpostSupport"] = $row["bookpost_support"];
                $bookpostArr[$i]["bookpostReplyNumber"] = $row["bookpost_reply_number"];
                $bookpostArr[$i]["bookpostCollectNumber"] = $row["bookpost_collect_number"];
                $bookpostArr[$i]["bookpostTime"] = $row["bookpost_time"];

                $userArr = array();
                $userResult = $db_user->where('pk_user_id='.$row['fk_bp_user_id'])->select();
                $userArr["userId"] = $userResult[0]["pk_user_id"];
                $userArr["userAccount"] = $userResult[0]["user_account"];
                $userArr["userName"] = $userResult[0]["user_name"];
                $userArr["userAge"] = $userResult[0]["user_age"];
                $userArr["userFaceURL"] = $userResult[0]["user_face_url"];
                $userArr["userEXP"] = $userResult[0]["user_exp"];
                $bookpostArr[$i]["user"] = $userArr;

                $fieldArr = array();
                $fieldResult = $db_field->where('pk_field_id='.$row['fk_bp_field_id'])->select();
                $fieldArr["fieldId"] = $fieldResult[0]["pk_field_id"];
                $fieldArr["fieldName"] = $fieldResult[0]["field_name"];
                $bookpostArr[$i]["field"] = $fieldArr;

                $judgeCollectSQL = "call proc_UserCollectBpByBookpostIDUserID_Select(".$row["pk_bookpost_id"].", $myUserID)";
                if (empty($db->query($judgeCollectSQL))) {
                    $bookpostArr[$i]["collected"] = 0;
                }
                else {
                    $bookpostArr[$i]["collected"] = 1;
                }
                $judgeSupportSQL = "call proc_UserSupportBpByBookpostIDUserID_Select(".$row["pk_bookpost_id"].", $myUserID)";
                if (empty($db->query($judgeSupportSQL))) {
                    $bookpostArr[$i]["supported"] = 0;
                }
                else {
                    $bookpostArr[$i]["supported"] = 1;
                }
                $i ++;
            }
        }
        echo(json_encode(@['data'=>@["aList"=>$bookpostArr]]));
    }

    // 根据图书贴ID获取图书贴评论
    public function getBookpostCommentByBookpostID() {
        $bookpostID = $_POST['bookpostID'];
        $currUserID = $_POST['currUserID'];
        $pagination = $_POST['pagination'];
        $pageCount = $_POST['pageCount'];
        $pageIndex = ($pagination - 1) * $pageCount;
        
        $db = M();
        $sql ="call proc_BpCommentByBookpostID_Select($bookpostID, $pageIndex, $pageCount)";
        $result = $db->query($sql);

        $commentArr = array();
        $i = 0;
        if ($result) {
             foreach ($result as $row) {
                $commentArr[$i]["commentId"] = $row["pk_bookpost_comment_id"];
                $commentArr[$i]["commentContent"] = $row["comment_content"];
                $commentArr[$i]["commentReplyNumber"] = $row["comment_reply_number"];
                $commentArr[$i]["commentSupport"] = $row["comment_support"];
                $commentArr[$i]["commentTime"] = $row["comment_time"];

                $userArr = array();
                $userArr["userId"] = $row["pk_user_id"];
                $userArr["userAccount"] = $row["user_account"];
                $userArr["userName"] = $row["user_name"];
                $userArr["userAge"] = $row["user_age"];
                $userArr["userFaceURL"] = $row["user_face_url"];
                $userArr["userEXP"] = $row["user_exp"];
                $commentArr[$i]["user"] = $userArr;

                $judgeSupportSQL = "call proc_UserSupportBpCommentByCommentIDUserID_Select(".$row["pk_bookpost_comment_id"].", $currUserID)";
                if (empty($db->query($judgeSupportSQL))) {
                    $commentArr[$i]["supported"] = 0;
                }
                else{
                    $commentArr[$i]["supported"] = 1;
                }
                $i ++;
            }
        }
        echo(json_encode(@['data'=>@["aList"=>$commentArr]]));
    }

    // 根据图书贴评论ID获取图书贴评论回复
    public function getBookpostCommentReplyByBookpostCommentID() {
        $commentID = $_POST['bookpostCommentID'];
        $currUserID = $_POST['currUserID'];
        $pagination = $_POST['pagination'];
        $pageCount = $_POST['pageCount'];
        $pageIndex = ($pagination - 1) * $pageCount;
        
        $db = M();
        $sql ="call proc_BpCommentReplyByCommentID_Select($commentID, $pageIndex, $pageCount)";
        $result = $db->query($sql);

        $replyArr = array();
        $i = 0;
        if ($result) {
             foreach ($result as $row) {
                $replyArr[$i]["replyId"] = $row["pk_reply_id"];
                $replyArr[$i]["replyContent"] = $row["reply_content"];
                $replyArr[$i]["replySupport"] = $row["reply_support"];
                $replyArr[$i]["replyTime"] = $row["reply_time"];
                $replyArr[$i]["isReplyAuthor"] = $row["reply_isreply_author"];

                $userArr = array();
                $userArr["userId"] = $row["pk_user_id"];
                $userArr["userAccount"] = $row["user_account"];
                $userArr["userName"] = $row["user_name"];
                $userArr["userAge"] = $row["user_age"];
                $userArr["userFaceURL"] = $row["user_face_url"];
                $userArr["userEXP"] = $row["user_exp"];
                $replyArr[$i]["user"] = $userArr;

                $receiver = array();
                $receiver["userId"] = $row["pk_user_id_receiver"];
                $receiver["userName"] = $row["user_name_receiver"];
                $replyArr[$i]["receiver"] = $receiver;

                $judgeSupportSQL = "call proc_UserSupportBpCommentReplyByReplyIDUserID_Select(".$row["pk_reply_id"].", $currUserID)";
                if (empty($db->query($judgeSupportSQL))) {
                    $replyArr[$i]["supported"] = 0;
                }
                else{
                    $replyArr[$i]["supported"] = 1;
                }
                $i ++;
            }
        }
        echo(json_encode(@['data'=>@["aList"=>$replyArr]]));
    }

    // 改变图书贴点赞记录
    public function changeBookpostSupportRecord() {
        $currBookpostID = $_POST["currBookpostID"];
        $currUserID = $_POST["currUserID"];
        $currSupported = $_POST["currSupported"];

        $db = M();
        $sql = "call proc_UserSupportBpByBookpostIDUserID_InsertOrDelete($currBookpostID, $currUserID, $currSupported)";
        $result = $db->query($sql);  
        
        // 判断是否为数组,如果为数组则改变成功，如果返回false则添加失败
        if (is_array($result)) {
            echo json_encode(@["result"=>1]);
        }
        else {
            echo json_encode(@["result"=>0]);
        }
    }

    // 改变图书贴收藏记录
    public function changeBookpostCollectionRecord() {
        $currBookpostID = $_POST["currBookpostID"];
        $currUserID = $_POST["currUserID"];
        $currCollected = $_POST["currCollected"];

        $db = M();
        $sql = "call proc_UserCollectBpByBookpostIDUserID_InsertOrDelete($currBookpostID, $currUserID, $currCollected)";
        $result = $db->query($sql);  
        
        // 判断是否为数组,如果为数组则改变成功，如果返回false则添加失败
        if (is_array($result)) {
            echo json_encode(@["result"=>1]);
        }
        else {
            echo json_encode(@["result"=>0]);
        }
    }

    // 改变图书贴评论点赞记录
    public function changeBookpostCommentSupportRecord() {
        $commentID = $_POST["currBookpostCommentID"];
        $currUserID = $_POST["currUserID"];
        $currSupported = $_POST["currSupported"];

        $db = M();
        $sql = "call proc_UserSupportBpCommentByCommentIDUserID_InsertOrDelete($commentID, $currUserID, $currSupported)";
        $result = $db->query($sql);  
        
        // 判断是否为数组,如果为数组则改变成功，如果返回false则添加失败
        if (is_array($result)) {
            echo json_encode(@["result"=>1]);
        }
        else {
            echo json_encode(@["result"=>0]);
        }
    }

    // 改变图书评论回复点赞记录
    public function changeBookpostCommentReplySupportRecord() {
        $replyID = $_POST["currBookpostCommentReplyID"];
        $currUserID = $_POST["currUserID"];
        $currSupported = $_POST["currSupported"];

        $db = M();
        $sql = "call proc_UserSupportBpCommentReplyByReplyIDUserID_InsertOrDelete($replyID, $currUserID, $currSupported)";
        $result = $db->query($sql);  
        
        // 判断是否为数组,如果为数组则改变成功，如果返回false则添加失败
        if (is_array($result)) {
            echo json_encode(@["result"=>1]);
        }
        else {
            echo json_encode(@["result"=>0]);
        }
    }

    // 添加图书贴
    public function addBookpost() {
        $bookpostTitle = $_POST["bookpostTitle"];
        $bookpostContent = $_POST["bookpostContent"];
        $bookpostBookName = $_POST["bookpostBookName"];
        $currUserID = $_POST["currUserID"];
        $fieldID = $_POST["fieldID"];

        $db = M();
        $sql = "call proc_Bp_Insert('$bookpostTitle', '$bookpostContent', '$bookpostBookName', $currUserID, $fieldID)";
        $result = $db->query($sql);
        
        // 判断是否为数组,如果为数组则改变成功，如果返回false则添加失败
        if (is_array($result)) {
            echo json_encode(@["result"=>1]);
        }
        else {
            echo json_encode(@["result"=>0]);
        }
    }

    // 添加图书贴评论
    public function addBookpostComment() {
        $bookpostCommentContent = $_POST["bookpostCommentContent"];
        $bookpostID = $_POST["bookpostID"];
        $currUserID = $_POST["currUserID"];

        $db = M();
        $sql = "call proc_BpComment_Insert('$bookpostCommentContent', $bookpostID, $currUserID)";
        $result = $db->query($sql);
        
        // 判断是否为数组,如果为数组则改变成功，如果返回false则添加失败
        if (is_array($result)) {
            echo json_encode(@["result"=>1]);
        }
        else {
            echo json_encode(@["result"=>0]);
        }
    }

    // 添加图书贴评论回复
    public function addBookpostCommentReply() {
        $bookpostCommentReplyContent = $_POST["bookpostCommentReplyContent"];
        $isReplyAuthor = $_POST["isReplyAuthor"];
        $bookpostCommentID = $_POST["bookpostCommentID"];
        $currUserID = $_POST["currUserID"];
        $receiverID = $_POST["receiverID"];

        $db = M();
        $sql = "call proc_BpCommentReply_Insert('$bookpostCommentReplyContent', $isReplyAuthor, $bookpostCommentID, $currUserID, $receiverID)";
        $result = $db->query($sql);
        
        // 判断是否为数组,如果为数组则改变成功，如果返回false则添加失败
        if (is_array($result)) {
            echo json_encode(@["result"=>1]);
        }
        else {
            echo json_encode(@["result"=>0]);
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