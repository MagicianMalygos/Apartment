<?php
namespace Home\Controller;
use Think\Controller;
class HotTrendController extends Controller {

    public function getHotBookpostComment() {

        $currUserID = $_POST['currUserID'];
        $pagination = $_POST['pagination'];
        $pageCount = $_POST['pageCount'];
        $pageIndex = ($pagination - 1) * $pageCount;
        $timeMin = date("Y-m-d",mktime(0,0,0,date("m"),date("d")-7,date("Y")));
        $timeMin = $timeMin." 00:00:00";
        $timeMax = date("Y-m-d H:i:s");

        $db = M();
        $db_user = M('user');
        $db_levels = M('levels');
        $db_field = M('field');
        $db_bookpost_comment = M('bookpost_comment');
        $result = $db_bookpost_comment->where('comment_usable=1 AND comment_time>="'.$timeMin.'" AND comment_time <="'.$timeMax.'"')->limit($pageIndex.','.$pageCount)->join('__USER__ on __USER__.pk_user_id=__BOOKPOST_COMMENT__.fk_bpc_user_id', 'LEFT')->order('comment_support desc, comment_reply_number desc')->select();

        $commentArr = array();
        $i = 0;
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

            $commentArr[$i]['bookpost'] = $this->getBookpostWithBookpostID($row['fk_bpc_bp_id'], $currUserID);

            $judgeSupportSQL = "call proc_UserSupportBpCommentByCommentIDUserID_Select(".$row["pk_bookpost_comment_id"].", $currUserID)";
            if (empty($db->query($judgeSupportSQL))) {
                $commentArr[$i]["supported"] = 0;
            }
            else{
                $commentArr[$i]["supported"] = 1;
            }
            $i ++;
        }

        echo json_encode(@['code'=>0, 'msg'=>'', 'data'=>@["aList"=>$commentArr]]);
    }


    public function getBookpostWithBookpostID($bookpostID, $currUserID) {

        $db = M();
        $db_user = M('user');
        $db_field = M('field');
        $db_bookpost = M('bookpost');
        $result = $db_bookpost->where('bookpost_usable=1 AND pk_bookpost_id='.$bookpostID)->join('__USER__ on __USER__.pk_user_id=__BOOKPOST__.fk_bp_user_id', 'LEFT')->join('__FIELD__ on __FIELD__.pk_field_id=__BOOKPOST__.fk_bp_field_id', 'LEFT')->select();

        $bookpost = array();
        $bookpost["bookpostId"] = $result[0]["pk_bookpost_id"];
        $bookpost["bookpostTitle"] = $result[0]["bookpost_title"];
        $bookpost["bookpostContent"] = $result[0]["bookpost_content"];
        $bookpost["bookpostBookName"] = $result[0]["bookpost_book_name"];
        $bookpost["bookpostSupport"] = $result[0]["bookpost_support"];
        $bookpost["bookpostReplyNumber"] = $result[0]["bookpost_reply_number"];
        $bookpost["bookpostCollectNumber"] = $result[0]["bookpost_collect_number"];
        $bookpost["bookpostTime"] = $result[0]["bookpost_time"];

        $userArr = array();
        $userArr["userId"] = $result[0]["pk_user_id"];
        $userArr["userAccount"] = $result[0]["user_account"];
        $userArr["userName"] = $result[0]["user_name"];
        $userArr["userAge"] = $result[0]["user_age"];
        $userArr["userFaceURL"] = $result[0]["user_face_url"];
        $userArr["userEXP"] = $result[0]["user_exp"];
        $bookpost["user"] = $userArr;

        $fieldArr = array();
        $fieldArr["fieldId"] = $result[0]["pk_field_id"];
        $fieldArr["fieldName"] = $result[0]["field_name"];
        $bookpost["field"] = $fieldArr;

        $judgeCollectSQL = "call proc_UserCollectBpByBookpostIDUserID_Select(".$result[0]["pk_bookpost_id"].", $currUserID)";
        if (empty($db->query($judgeCollectSQL))) {
            $bookpost["collected"] = 0;
        }
        else {
            $bookpost["collected"] = 1;
        }
        $judgeSupportSQL = "call proc_UserSupportBpByBookpostIDUserID_Select(".$result[0]["pk_bookpost_id"].", $currUserID)";
        if (empty($db->query($judgeSupportSQL))) {
            $bookpost["supported"] = 0;
        }
        else {
            $bookpost["supported"] = 1;
        }
        return $bookpost;
    }
    
    // 获取一周内评论数最多的图书贴
    public function getHotBookpost() {

        $currUserID = $_POST['currUserID'];
        $pagination = $_POST['pagination'];
        $pageCount = $_POST['pageCount'];
        $pageIndex = ($pagination - 1) * $pageCount;
        $timeMin = date("Y-m-d",mktime(0,0,0,date("m"),date("d")-7,date("Y")));
        $timeMin = $timeMin." 00:00:00";
    	$timeMax = date("Y-m-d H:i:s");

        $db = M();
        $db_user = M('user');
        $db_levels = M('levels');
        $db_field = M('field');
        $db_bookpost = M('bookpost');
        $result = $db_bookpost->where('bookpost_usable=1 AND bookpost_time>="'.$timeMin.'" AND bookpost_time <="'.$timeMax.'"')->limit($pageIndex.','.$pageCount)->join('__USER__ on __USER__.pk_user_id=__BOOKPOST__.fk_bp_user_id', 'LEFT')->join('__FIELD__ on __FIELD__.pk_field_id=__BOOKPOST__.fk_bp_field_id', 'LEFT')->order('bookpost_reply_number desc')->select();

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
}