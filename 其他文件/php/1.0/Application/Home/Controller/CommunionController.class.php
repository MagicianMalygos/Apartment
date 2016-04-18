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
        $db_levels = M('levels');
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
                $userArr["userLevel"] = $db_levels->where($row['user_exp'].' BETWEEN level_min_exp AND level_max_exp')->getField('level_name');
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
        $db_levels = M('levels');
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
                $userArr["userLevel"] = $db_levels->where($userResult[0]['user_exp'].' BETWEEN level_min_exp AND level_max_exp')->getField('level_name');
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
        $db_levels = M('levels');
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
                $userArr["userLevel"] = $db_levels->where($userResult[0]['user_exp'].' BETWEEN level_min_exp AND level_max_exp')->getField('level_name');
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
        $db_levels = M('levels');
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
                $userArr["userLevel"] = $db_levels->where($row['user_exp'].' BETWEEN level_min_exp AND level_max_exp')->getField('level_name');
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
        $db_levels = M('levels');
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
                $userArr["userLevel"] = $db_levels->where($row['user_exp'].' BETWEEN level_min_exp AND level_max_exp')->getField('level_name');
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
}