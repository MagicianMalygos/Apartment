<?php
namespace Home\Controller;
use Think\Controller;
class LibraryController extends Controller {

    // 根据条件搜索图片：关键字、排序方式、所属领域
    public function getBookBySearchTextSortMethodFieldID(){
        $searchText = '%'.$_POST['searchText'].'%';
        $sortMethod = $_POST['sortMethod'];
        $fieldID = $_POST['fieldID'];
        $currUserID = $_POST['currUserID'];
        $pagination = $_POST['pagination'];
        $pageCount = $_POST['pageCount'];
        $pageIndex = ($pagination - 1) * $pageCount;

        $db = M();
        $db_levels = M('levels');
        $sql = "call WenHuiApartment.proc_Book_SelectByMultiCondition('$searchText', $sortMethod, $fieldID, $pageIndex, $pageCount);";
        $result = $db->query($sql);

        $bookArr = array();
        $i = 0;
        foreach ($result as $row) {
            $bookArr[$i]['bookId'] = $row['pk_book_id'];
            $bookArr[$i]['bookName'] = $row['book_name'];
            $bookArr[$i]['bookAuthor'] = $row['book_author'];
            $bookArr[$i]['bookPublishTime'] = $row['book_publish_time'];
            $bookArr[$i]['bookCoverURL'] = $row['book_cover_url'];
            $bookArr[$i]['bookCollectNumber'] = $row['book_collect_number'];
            $bookArr[$i]['bookPublisher'] = $row['book_publisher'];
            $bookArr[$i]['bookSummary'] = $row['book_summary'];
            $bookArr[$i]['bookCommentCount'] = $row['book_comment_count'];
            $bookArr[$i]['bookTime'] = $row['book_time'];

            $fieldArr = array();
            $fieldArr['fieldId'] = $row['pk_field_id'];
            $fieldArr['fieldName'] = $row['field_name'];
            $bookArr[$i]['field'] = $fieldArr;

            $userArr = array();
            $userArr['userId'] = $row['pk_user_id'];
            $userArr['userAccount'] = $row['user_account'];
            $userArr['userName'] = $row['user_name'];
            $userArr["userAge"] = $row["user_age"];
            $userArr["userFaceURL"] = $row["user_face_url"];
            $userArr["userLevel"] = $db_levels->where($row['user_exp'].' BETWEEN level_min_exp AND level_max_exp')->getField('level_name');
            $bookArr[$i]['contributor'] = $userArr;

            $judgeCollectSQL = "call WenHuiApartment.proc_UserCollectBookByBookIDUserID_Select(".$row["pk_book_id"].", $currUserID)";
            if (empty($db->query($judgeCollectSQL))) {
                $bookArr[$i]["collected"] = 0;
            }
            else {
                $bookArr[$i]["collected"] = 1;
            }

            $i++;
        }
        echo(json_encode(@['data'=>@['aList'=>$bookArr]]));
    }

    // 根据用户ID得到该用户所发过的图书
    public function getBookByUserID() {
        $currUserID = $_POST['currUserID'];
        $myUserID = $_POST['myUserID'];
        $pagination = $_POST['pagination'];
        $pageCount = $_POST['pageCount'];
        $pageIndex = ($pagination - 1) * $pageCount;

        $db = M();
        $db_user = M('user');
        $db_levels = M('levels');
        $db_field = M('field');
        $db_book = M('book');
        $result = $db_book->where('book_usable=1 AND fk_book_user_id='.$currUserID)->order('book_time desc')->limit($pageIndex.','.$pageCount)->select();

        $bookArr = array();
        $i = 0;
        foreach ($result as $row) {
            $bookArr[$i]['bookId'] = $row['pk_book_id'];
            $bookArr[$i]['bookName'] = $row['book_name'];
            $bookArr[$i]['bookAuthor'] = $row['book_author'];
            $bookArr[$i]['bookPublishTime'] = $row['book_publish_time'];
            $bookArr[$i]['bookCoverURL'] = $row['book_cover_url'];
            $bookArr[$i]['bookCollectNumber'] = $row['book_collect_number'];
            $bookArr[$i]['bookPublisher'] = $row['book_publisher'];
            $bookArr[$i]['bookSummary'] = $row['book_summary'];
            $bookArr[$i]['bookCommentCount'] = $row['book_comment_count'];
            $bookArr[$i]['bookTime'] = $row['book_time'];

            $userArr = array();
            $userResult = $db_user->where('pk_user_id='.$row['fk_book_user_id'])->select();
            $userArr["userId"] = $userResult[0]["pk_user_id"];
            $userArr["userAccount"] = $userResult[0]["user_account"];
            $userArr["userName"] = $userResult[0]["user_name"];
            $userArr["userAge"] = $userResult[0]["user_age"];
            $userArr["userFaceURL"] = $userResult[0]["user_face_url"];
            $userArr["userLevel"] = $db_levels->where($userResult[0]['user_exp'].' BETWEEN level_min_exp AND level_max_exp')->getField('level_name');
            $bookArr[$i]['contributor'] = $userArr;

            $fieldArr = array();
            $fieldResult = $db_field->where('pk_field_id='.$row['fk_book_field_id'])->select();
            $fieldArr["fieldId"] = $fieldResult[0]["pk_field_id"];
            $fieldArr["fieldName"] = $fieldResult[0]["field_name"];
            $bookArr[$i]["field"] = $fieldArr;

            $judgeCollectSQL = "call WenHuiApartment.proc_UserCollectBookByBookIDUserID_Select(".$row["pk_book_id"].", $myUserID)";
            if (empty($db->query($judgeCollectSQL))) {
                $bookArr[$i]["collected"] = 0;
            }
            else {
                $bookArr[$i]["collected"] = 1;
            }

            $i++;
        }
        echo(json_encode(@['data'=>@['aList'=>$bookArr]]));
    }

    // 根据用户ID得到该用户收藏的图书
    public function getCollectedBookByUserID() {
        $currUserID = $_POST['currUserID'];
        $myUserID = $_POST['myUserID'];
        $pagination = $_POST['pagination'];
        $pageCount = $_POST['pageCount'];
        $pageIndex = ($pagination - 1) * $pageCount;

        $db = M();
        $db_user = M('user');
        $db_levels = M('levels');
        $db_field = M('field');
        $db_book = M('book');
        $db_book_collect = M('user_collect_book');
        $result = $db_book_collect->where('collect_usable=1 AND fk_ucb_user_id='.$currUserID)->limit($pageIndex.','.$pageCount)->join('__BOOK__ on __BOOK__.pk_book_id=__USER_COLLECT_BOOK__.fk_ucb_book_id', 'LEFT')->order('book_time desc')->select();

        $bookArr = array();
        $i = 0;
        foreach ($result as $row) {
            $bookArr[$i]['bookId'] = $row['pk_book_id'];
            $bookArr[$i]['bookName'] = $row['book_name'];
            $bookArr[$i]['bookAuthor'] = $row['book_author'];
            $bookArr[$i]['bookPublishTime'] = $row['book_publish_time'];
            $bookArr[$i]['bookCoverURL'] = $row['book_cover_url'];
            $bookArr[$i]['bookCollectNumber'] = $row['book_collect_number'];
            $bookArr[$i]['bookPublisher'] = $row['book_publisher'];
            $bookArr[$i]['bookSummary'] = $row['book_summary'];
            $bookArr[$i]['bookCommentCount'] = $row['book_comment_count'];
            $bookArr[$i]['bookTime'] = $row['book_time'];

            $userArr = array();
            $userResult = $db_user->where('pk_user_id='.$row['fk_book_user_id'])->select();
            $userArr["userId"] = $userResult[0]["pk_user_id"];
            $userArr["userAccount"] = $userResult[0]["user_account"];
            $userArr["userName"] = $userResult[0]["user_name"];
            $userArr["userAge"] = $userResult[0]["user_age"];
            $userArr["userFaceURL"] = $userResult[0]["user_face_url"];
            $userArr["userLevel"] = $db_levels->where($userResult[0]['user_exp'].' BETWEEN level_min_exp AND level_max_exp')->getField('level_name');
            $bookArr[$i]['contributor'] = $userArr;

            $fieldArr = array();
            $fieldResult = $db_field->where('pk_field_id='.$row['fk_book_field_id'])->select();
            $fieldArr["fieldId"] = $fieldResult[0]["pk_field_id"];
            $fieldArr["fieldName"] = $fieldResult[0]["field_name"];
            $bookArr[$i]["field"] = $fieldArr;

            $judgeCollectSQL = "call WenHuiApartment.proc_UserCollectBookByBookIDUserID_Select(".$row["pk_book_id"].", $myUserID)";
            if (empty($db->query($judgeCollectSQL))) {
                $bookArr[$i]["collected"] = 0;
            }
            else {
                $bookArr[$i]["collected"] = 1;
            }

            $i++;
        }
        echo(json_encode(@['data'=>@['aList'=>$bookArr]]));
    }

    public function getBookReplyByBookID() {
        $currBookID = $_POST['currBookID'];
        $currUserID = $_POST['currUserID'];
        $pagination = $_POST['pagination'];
        $pageCount = $_POST['pageCount'];
        $pageIndex = ($pagination - 1) * $pageCount;

        $db = M();
        $db_levels = M('levels');
        $sql = "call WenHuiApartment.proc_BookReplyByBookID_Select($currBookID, $pageIndex, $pageCount);";
        $result = $db->query($sql);

        $bookReplyArr = array();
        $i = 0;
        foreach ($result as $row) {
            $bookReplyArr[$i]['bookreplyId'] = $row['pk_book_reply_id'];
            $bookReplyArr[$i]['bookreplySupport'] = $row['book_reply_support'];
            $bookReplyArr[$i]['bookreplyTime'] = $row['book_reply_time'];
            $bookReplyArr[$i]['bookreplyContent'] = preg_replace_callback('/@E(.{6}==)/', function($r) {return base64_decode($r[1]);}, $row['book_reply_content']);

            $userArr = array();
            $userArr['userId'] = $row['pk_user_id'];
            $userArr['userAccount'] = $row['user_account'];
            $userArr['userName'] = $row['user_name'];
            $userArr["userAge"] = $row["user_age"];
            $userArr["userFaceURL"] = $row["user_face_url"];
            $userArr["userLevel"] = $db_levels->where($row['user_exp'].' BETWEEN level_min_exp AND level_max_exp')->getField('level_name');
            $bookReplyArr[$i]['user'] = $userArr;

            $judgeCollectSQL = "call WenHuiApartment.proc_UserSupportBookReplyByReplyIDUserID_Select(".$row["pk_book_reply_id"].", $currUserID)";
            if (empty($db->query($judgeCollectSQL))) {
                $bookReplyArr[$i]["supported"] = 0;
            }
            else {
                $bookReplyArr[$i]["supported"] = 1;
            }

            $i++;
        }
        echo(json_encode(@['data'=>@['aList'=>$bookReplyArr]]));
    }

    // 改变图书收藏记录
    public function changeBookCollectionRecord(){
        $currBookID = $_POST["currBookID"];
        $currUserID = $_POST["currUserID"];
        $currCollected = $_POST["currCollected"];

        $db = M();
        $sql = "call WenHuiApartment.proc_UserCollectBookByBookIDUserID_InsertOrDelete($currUserID, $currBookID, $currCollected)";
        $result = $db->query($sql);  
        
        // 判断是否为数组,如果为数组则改变成功，如果返回false则添加失败
        if (is_array($result)) {
            echo json_encode(@["result"=>1]);
        }
        else {
            echo json_encode(@["result"=>0]);
        }
    }

    // 改变图书回复点赞状态
    public function changeBookReplySupportRecord() {
        $currBookReplyID = $_POST["currBookReplyID"];
        $currUserID = $_POST["currUserID"];
        $currSupported = $_POST["currSupported"];

        $db = M();
        $sql = "call WenHuiApartment.proc_UserSupportBookReplyByReplyIDUserID_InsertOrDelete($currBookReplyID, $currUserID, $currSupported)";
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
    *   添加图书
    */
    public function addBook() {

        // $tmp_name = $_FILES['cover']['tmp_name'];//系统默认缓冲区的带路径文件名，如/Applications/MAMP/tmp/php/phpjij1Ow
        // 当前目录为：/Applications/MAMP/htdocs/1.0

        $tmpPath = $_FILES['cover']['tmp_name'];
        $fileName = $_FILES['cover']['name'];
        $filePath = 'Application/Home/Images/Cover/'.$fileName;

        $bookName = preg_replace_callback('/[\xf0-\xf7].{3}/', function($r) { return '@E'.base64_encode($r[0]);}, $_POST["bookName"]);
        $bookAuthor = preg_replace_callback('/[\xf0-\xf7].{3}/', function($r) { return '@E'.base64_encode($r[0]);}, $_POST["bookAuthor"]);
        $bookPublishTime = preg_replace_callback('/[\xf0-\xf7].{3}/', function($r) { return '@E'.base64_encode($r[0]);}, $_POST["bookPublishTime"]);
        $bookPublisher = preg_replace_callback('/[\xf0-\xf7].{3}/', function($r) { return '@E'.base64_encode($r[0]);}, $_POST["bookPublisher"]);
        $bookSummary = preg_replace_callback('/[\xf0-\xf7].{3}/', function($r) { return '@E'.base64_encode($r[0]);}, $_POST["bookSummary"]);
        $fieldID = $_POST["fieldID"];
        $currUserID = $_POST["currUserID"];
        $stateValue = 0;

        if(!$_FILES['cover']['error'] && move_uploaded_file($tmpPath, $filePath)) {
            $db = M();
            $sql = "call WenHuiApartment.proc_Book_Insert('$bookName','$bookAuthor', '$bookPublishTime', '$fileName', '$bookPublisher', '$bookSummary', $fieldID, $currUserID, $stateValue)";
            $result = $db->query($sql);
            // 判断是否为数组,如果为数组则添加成功，如果返回false则添加失败
            if (is_array($result)) {
                echo json_encode(@["result"=>1]);
            }
            else {
                echo json_encode(@["result"=>0]);
            }
        } else {
            echo json_encode(@["result"=>0]);
        }
    }


    /**
    *   添加一条图书回复
    */
    public function addBookReply() {
        $replyContent = preg_replace_callback('/[\xf0-\xf7].{3}/', function($r) {return '@E'.base64_encode($r[0]);}, $_POST["bookReplyContent"]);
        $currBookID = $_POST["currBookID"];
        $currUserID = $_POST["currUserID"];

        $db = M();
        $sql = "call WenHuiApartment.proc_BookReply_Insert('$replyContent', $currBookID, $currUserID)";
        $result = $db->query($sql);

        // 判断是否为数组,如果为数组则添加成功，如果返回false则添加失败
        if (is_array($result)) {
            echo json_encode(@["result"=>1]);
        }
        else {
            echo json_encode(@["result"=>0]);
        }
    } 
}