<?php
namespace Home\Controller;
use Think\Controller;
class ManaController extends Controller {
    public function index(){
        $this->show('<style type="text/css">*{ padding: 0; margin: 0; } div{ padding: 4px 48px;} body{ background: #fff; font-family: "微软雅黑"; color: #333;font-size:24px} h1{ font-size: 100px; font-weight: normal; margin-bottom: 12px; } p{ line-height: 1.8em; font-size: 36px }</style><div style="padding: 24px 48px;"> <h1>:)</h1><p>欢迎使用 <b>ThinkPHP</b>！</p><br/>[ 您现在访问的是Home模块的Index控制器 ]</div><script type="text/javascript" src="http://tajs.qq.com/stats?sId=9347272" charset="UTF-8"></script>','utf-8');
    }

    public function test1() {
        // $image = $_POST['images'];
        // $userid = $_POST['userid'];
        // $filename = $_POST['name'];
        // $header = getallheaders();
        // echo(json_encode($header));
        $Arr = array();
        $i = 0;
        foreach(getallheaders() as $key=>$value)  
        {
            // echo  "Key: $key; Value: $value <br/>\n ";
            $Arr[$i] = @['Key: '.$key=>'Value: '.$value];
            $i++;
        }
        // echo(json_encode(@['userid'=>$userid]));
        $data = file_get_contents("php://input"); 
        $Arr[$i] = @['body'=>$data];
        echo($Arr);
        // $xmlstr= file_get_contents("php://input"); 
        // // echo(json_encode(@['state'=>'success','result'=>$xmlstr])); 
        // echo(json_encode($xmlstr));
        // $filename=time().'.png'; 
        // if(file_put_contents($filename,$xmlstr)){ 
        //  echo(json_encode(@['state'=>'success','result'=>$filename])); 
        // }else{ 
        //  echo(json_encode(@['state'=>'fail'])); 
        // }
    }

    public function getUserInfo() {
        $user_id = $_POST["user_id"];
    	$dbsource="localhost";
        $username="root";
        $password="root";
        if (!$con=mysql_connect($dbsource,$username,$password)) {
            echo(json_encode(@['state'=>0]));
        }
        mysql_query("SET NAMES UTF8");
        mysql_select_db('WenHuiApartment',$con);
        if ($result = mysql_query("call WenHuiApartment.proc_M_UserByUserId_Select($user_id);")) {
        	$row = mysql_fetch_array($result);
        	$Arr["userScore"] = $row["user_score"];
        	$Arr["userEXP"] = $row["user_exp"];
        	echo(json_encode(@['state'=>1,'result'=>$Arr]));
        }else {
        	echo(json_encode(@['state'=>0]));
        }
        mysql_close();
    }

    public function proc_M_UserByUserId_Select() {
        


        $user_id = $_GET["userid"];
        $dbsource="localhost";
        $username="root";
        $password="root";
        if (!$con=mysql_connect($dbsource,$username,$password)) {
            echo(json_encode(@['state'=>0]));
        }
        mysql_query("SET NAMES UTF8");
        mysql_select_db('WenHuiApartment',$con);
        if ($result = mysql_query("call WenHuiApartment.proc_M_UserByUserId_Select($user_id);")) {
            $row = mysql_fetch_array($result);
            $Arr["userId"] = $row["pk_user_id"];
            $Arr["userAccount"] = $row["user_account"];
            $Arr["userName"] = $row["user_name"];
            $Arr["userAge"] = $row["user_age"];
            $Arr["userFaceURL"] = $row["user_face_url"];
            $Arr["userScore"] = $row["user_score"];
            $Arr["userEXP"] = $row["user_exp"];
            if ($Arr) {
                echo(json_encode(@['state'=>1,'result'=>$Arr]));
            }else {
                echo(json_encode(@['state'=>2]));
            }
        }else {
            echo(json_encode(@['state'=>3]));
        }
        mysql_close();
    }

    public function updataPassword() {
        $userid = $_POST['userid'];
        $useroldpassword = $_POST['useroldpassword'];
        $usernewpassword = $_POST['usernewpassword'];

        $db=M("t_user");
        $result = $db->where("pk_user_id='$userid'")->select();
        $result = $result[0];
        if ($result["user_password"] == $useroldpassword) {
            $result["user_password"] = $usernewpassword;
            if($db->save($result)){
                echo(
                json_encode(@[
                    'state'=>1
                    ])
                );
            }else{
                echo(
                json_encode(@[
                    'state'=>0,
                    'reason'=>'更新失败'
                    ])
                );
            }
        }else{
            echo(
                json_encode(@[
                    'state'=>0,
                    'reason'=>'密码错误'
                    ])
                );
        }
    }

    // 获取用户发表的图书贴
    public function get_M_BookPostByUserIdBookPostId_Select() {
        $userId = $_GET['userId'];
        $pageCount = $_GET['pageCount'];
        $pageIndex = $_GET['pageIndex'];
        // $userId = 1;
        // $pageIndex = 0;
        // $pageCount = 10;

        $pageIndex = $pageIndex * $pageCount;
        $db = M();
        $sql = "call WenHuiApartment.proc_M_BookPostByUserIdPageIndexPageCount_Select($userId,$pageIndex,$pageCount)";
        $result = $db->query($sql);  
        $i=0; 
        if ($result) {
            $i = 0;
            foreach ($result as $row) {
                $Arr[$i]['bookpostId'] = $row['pk_bookpost_id'];
                $Arr[$i]['bookpostTitle'] = $row['bookpost_title'];
                $Arr[$i]['bookpostContent'] = $row['bookpost_content'];
                $Arr[$i]['bookpostPosition'] = $row['bookpost_position'];
                $Arr[$i]['bookpostSupport'] = $row['bookpost_support'];
                $Arr[$i]['bookpostTime'] = $row['bookpost_time'];
                $Arr[$i]['bookpostReplyNumber'] = $row['bookpost_reply_number'];
                $Arr[$i]['bookpostCollectNumber'] = $row['bookpost_collect_number'];

                $fieldArr = array();
                $fieldArr['fieldId'] = $row['pk_field_id'];
                $fieldArr['fieldName'] = $row['field_name'];
                $Arr[$i]['field'] = $fieldArr;

                $bookArr = array();
                $bookArr['bookId'] = $row['pk_book_id'];
                $bookArr['bookName'] = $row['book_name'];
                $bookArr['bookCoverURL'] = $row['book_cover_url'];
                $Arr[$i]['book'] = $bookArr;

                $userArr = array();
                $userArr['userId'] = $row['pk_user_id'];
                $userArr['userName'] = $row['user_name'];
                $userArr['userFaceURL'] = $row['user_face_url'];
                $Arr[$i]['user'] = $userArr;
                $i++;
            }
            if ($Arr) {
                echo(json_encode(@['state'=>1,'result'=>$Arr]));
            }else {
                echo(json_encode(@['state'=>2]));
            }
        }else {
            echo(json_encode(@['state'=>0,'error'=>mysql_error()]));
        }
        mysql_close();
    }

    //获得用户贡献的书籍
    public function get_M_BookByBookId_Select() {
        $userId = $_GET['userId'];
        $pageIndex = $_GET['pageIndex'];
        $pageCount = $_GET['pageCount'];
        // $userId = 1;
        // $pageIndex = 0;
        // $pageCount = 10;
        $pageIndex = $pageIndex * $pageCount;
        $db = M();
        $sql = "call WenHuiApartment.proc_M_BookByUserIdPageIndexPageCount_Select($userId,$pageIndex,$pageCount)";
        $result = $db->query($sql);  
        if ($result) {
            $i=0;
            foreach ($result as $row) {
                $bookArr[$i]['bookId'] = $row['pk_book_id'];
                $bookArr[$i]['bookName'] = $row['book_name'];
                $bookArr[$i]['bookAuthor'] = $row['book_author'];
                $bookArr[$i]['bookPublishTime'] = $row['book_publish_time'];
                $bookArr[$i]['bookCoverURL'] = $row['book_cover_url'];
                // $Arr[$i]['book_publisher'] = $row['book_publisher'];
                // $Arr[$i]['book_summary'] = $row['book_summary'];
                $bookArr[$i]['bookCommentCount'] = $row['book_comment_count'];
                // $Arr[$i]['book_time'] = $row['book_time'];

                $fieldArr = array();
                $fieldArr['fieldId'] = $row['pk_field_id'];
                $fieldArr['fieldName'] = $row['field_name'];
                $bookArr[$i]['field'] = $fieldArr;

                $userArr = array();
                $userArr['userId'] = $row['pk_user_id'];
                $userArr['userAccount'] = $row['user_account'];
                $userArr['userName'] = $row['user_name'];
                $bookArr[$i]['contributor'] = $userArr;
                $i++;
            }
            echo(json_encode(@['state'=>1,'result'=>$bookArr]));
        } else {
            echo(json_encode(@['state'=>0,'error'=>mysql_error()]));
        }
    }
    ///根据ID获取图书贴
    public function getBookpostByID($bookpostid) {
        //proc_M_BookpostByBookpostid_Select
        $db = M();
        $sql = "call WenHuiApartment.proc_M_BookpostByBookpostid_Select($bookpostid)";
        $row = $db->query($sql); 
        $row= $row[0];
        $bookpostArr['bookpostId'] = $row['pk_bookpost_id'];
                $bookpostArr['bookpostTitle'] = $row['bookpost_title'];
                $bookpostArr['bookpostContent'] = $row['bookpost_content'];
                $bookpostArr['bookpostPosition'] = $row['bookpost_position'];
                $bookpostArr['bookpostSupport'] = $row['bookpost_support'];
                $bookpostArr['bookpostTime'] = $row['bookpost_time'];
                $bookpostArr['bookpostReplyNumber'] = $row['bookpost_reply_number'];
                $bookpostArr['bookpostCollectNumber'] = $row['bookpost_collect_number'];

                $fieldArr = array();
                $fieldArr['fieldId'] = $row['pk_field_id'];
                $fieldArr['fieldName'] = $row['field_name'];
                $bookpostArr['field'] = $fieldArr;

                $bookArr = array();
                $bookArr['bookId'] = $row['pk_book_id'];
                $bookArr['bookName'] = $row['book_name'];
                $bookArr['bookCoverURL'] = $row['book_cover_url'];
                $bookpostArr['book'] = $bookArr;

                $userArr = array();
                $userArr['userId'] = $row['pk_user_id'];
                $userArr['userName'] = $row['user_name'];
                $userArr['userFaceURL'] = $row['user_face_url'];
                $bookpostArr['user'] = $userArr;
        return $bookpostArr;
    }

//获取用户评论图书贴
    public function get_M_BookpostCommentByUserId_Select() {
        $userId = $_GET['userId'];
        $pageIndex = $_GET['pageIndex'];
        $pageCount = $_GET['pageCount'];
        // $userId = 1;
        // $pageIndex = 0;
        // $pageCount = 10;
        $pageIndex = $pageIndex * $pageCount;
        $db = M();
        $sql = "call WenHuiApartment.proc_M_BookpostCommentByUserIdPageIndexPageCount_Select($userId,$pageIndex,$pageCount)";
        $result = $db->query($sql); 
        if ($result) {
            $i = 0;
            foreach ($result as $row) {
                $Arr[$i]['commentId'] = $row['pk_bookpost_comment_id'];
                $Arr[$i]['commentContent'] = $row['comment_content'];
                $Arr[$i]['commentPosition'] = $row['comment_position'];
                $Arr[$i]['commentSupport'] = $row['comment_support'];
                $Arr[$i]['commentReplyNumber'] = $row['comment_reply_number'];
                $Arr[$i]['commentTime'] = $row['comment_time'];

                $userId = array();
                $userArr["userId"] = $row["pk_user_id"];
                $userArr['userName'] = $row['user_name'];
                //
                $userArr['userFaceURL'] = $row['user_face_url'];
                $Arr[$i]['user'] = $userArr;
                $Arr[$i]['bookpost'] = $this->getBookpostByID($row['pk_bookpost_id']);
                $i++;
            }
            echo(json_encode(@['state'=>1,'result'=>$Arr]));
        }else {
            echo(json_encode(@['state'=>0,'error'=>mysql_error()]));
        }
        mysql_close();
    }


    //添加关注 ，弃用
    public function proc_M_ConcerPersonByUserIdPersonId_Insert(){
        $dbsource="localhost";
        $username="root";
        $password="root";
        $personid = $_POST['personid'];
        $userid = $_POST['userid'];
        if (!$con=mysql_connect($dbsource,$username,$password)) {
            echo(json_encode(@['state'=>0]));
        }
        mysql_query("SET NAMES UTF8");
        mysql_select_db('WenHuiApartment',$con);
        // $personid = 1;
        // $userid =2;
        if ($result = mysql_query("call WenHuiApartment.proc_M_ConcerPersonByUserIdPersonId_Insert($personid,$userid);")) {
            if ($result) {
                echo(json_encode(@['state'=>1,'result'=>$result]));
            }else {
                echo(json_encode(@['state'=>2]));
            }
        }else {
            echo(json_encode(@['state'=>0,'error'=>mysql_error()]));
        }
        mysql_close();
    }

//获取用户关注人列表
    public function get_M_ConcerPersonByUserIdpageIndexpageCount_Select() {
        $userId = $_GET['userId'];
        $pageIndex = $_GET['pageIndex'];
        $pageCount = $_GET['pageCount'];
        // $userId = 1;
        // $pageIndex = 0;
        // $pageCount = 10;
        $pageIndex = $pageIndex * $pageCount;
        $db = M();
        $sql = "call WenHuiApartment.proc_M_ConcerPersonByUserIdpageIndexpageCount_Select($userId,$pageIndex,$pageCount)";
        $result = $db->query($sql); 
        if ($result) {
            $i = 0;
            foreach ($result as $row) {
                $Arr[$i]['concerPersonId'] = $row['pk_concer_person_id'];
                $Arr[$i]['concerPersonTime'] = $row['concer_person_time'];
                $Arr[$i]['userId'] = $row['fk_concer_person_user_id'];
                $Arr[$i]['followedId'] = $row['pk_user_id'];
                $Arr[$i]['followName'] = $row['user_name'];
                $Arr[$i]['followFaceURL'] = $row['user_face_url'];
                $Arr[$i]['followLevel'] = $row['level_name'];
                $i++;
            }
            echo(json_encode(@['state'=>1,'result'=>$Arr]));
        }else {
            echo(json_encode(@['state'=>0,'error'=>mysql_error()]));
        }
    }


    // 获得领域
    public function proc_M_FieldByFieldId_Select($fieldid){
        $dbsource="localhost";
        $username="root";
        $password="root";
        if (!$con=mysql_connect($dbsource,$username,$password)) {
            echo(json_encode(@['state'=>0]));
        }
        mysql_query("SET NAMES UTF8");
        mysql_select_db('WenHuiApartment',$con);
        if ($result = mysql_query("call WenHuiApartment.proc_M_FieldByFieldId_Select($fieldid);")) {
            $i = 0;
            while ($row = mysql_fetch_array($result)) {
                $Arr[$i]['pk_field_id'] = $row['pk_field_id'];
                $Arr[$i]['field_name'] = $row['field_name'];
                $Arr[$i]['field_time'] = $row['field_time'];
                $i++;
            }
        }
        mysql_close();
        return $Arr;
    }
////////////////////////////////
    //领域
    public function getFieldByFieldId($fieldid){
        $db=M("t_field");
        $result = $db->where("pk_field_id=$fieldid")->select();
        return $result[0];
    }
    //关注领域表$userid
    public function getT_USER_FOCUS_FIELD($userid){
        $db=M("t_user_focus_field");
        $result = $db->where("fk_user_focus_field_user_id=$userid and user_focus_field_usable = 1")->select();
        // var_dump($result);
        return $result;
    }

    //称号表
    public function getT_LEVEL($exp) {
        $db = M("t_levels");
        $result = $db->where("level_min_exp<=$exp and $exp <= level_max_exp")->select();
        return $result[0];
    }
/////////////
    public function getUserInfoByUserId(){
        $userid = $_GET["userid"];
        $db = M("t_user");
        $result = $db->where("pk_user_id = $userid")->select();
        $result = $result[0];
        $field_users = $this->getT_USER_FOCUS_FIELD($userid);
        // echo(json_encode($fields));
        $i = 0;
        foreach ($field_users as $key => $value) {
            $fields[$i] = $this->getFieldByFieldId($value['fk_user_focus_field_field_id'])['field_name'];
            $i++;
        }
        // var_dump($fields);
        $re["foucusFieldsArr"] = $fields;
        $re["userLevel"] = $this->getT_LEVEL($result['user_exp'])['level_name'];
        $re['userId'] = $result['pk_user_id'];
        $re['userAccount'] = $result['user_account'];
        $re['userName'] = $result['user_name'];
        $re['userAge'] = $result['user_age'];
        $re['userFaceURL'] = $result['user_face_url'];
        $re['userScore'] = $result['user_score'];
        $re['userEXP'] = $result['user_exp'];
        $re['userRegisterTime'] = $result['user_register_time'];
        echo(json_encode($re));

    }


    public function insertT_CONCER_PERSON(){
        $userId = $_GET['userid'];
        $personid = $_GET['personid'];
        $db=M('t_concer_person');
        // $result = $db->query("")
    }

    //删除关注人 ，弃用
    public function proc_M_ConcerPersonByUserIdPersonId_Delete(){
        $userid = $_POST['userid'];
        $personid = $_POST['personid'];
        // $userid = 1;
        // $personid =1;
        $db = M("t_concer_person");
        $result = $db->query("call WenHuiApartment.proc_M_ConcerPersonByUserIdPersonId_Delete($userid,$personid);");
        echo(json_encode(@['state'=>1,'result'=>$result]));
    }


    //获取单个用户对联列表
    public function get_M_CoupletByUserIdPageIndexPageCount_Select_simple(){
        $userId = $_GET['userId'];
        $pageCount = $_GET['pageCount'];
        $pageIndex = $_GET['pageIndex'];
        // $userId = 2;
        // $pageIndex = 0;
        // $pageCount = 10;
        $pageIndex = $pageIndex * $pageCount;
        $db = M();
        $sql = "call WenHuiApartment.proc_M_CoupletByUserIdPageIndexPageCount_Select($userId,$pageIndex,$pageCount)";
        $result = $db->query($sql);
        if ($result) {
            $i = 0;
            $coupletArr = array();
            foreach ($result as $row) {
            $coupletArr[$i]["coupletId"] = $row["pk_couplet_id"];
            $coupletArr[$i]["coupletContent"] = $row["couplet_content"];
            $coupletArr[$i]["coupletReplyNumber"] = $row["couplet_reply_number"];
            $coupletArr[$i]["coupletSupport"] = $row["couplet_support"];
            $coupletArr[$i]["coupletTime"] = $row["couplet_time"];

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
            echo(json_encode(@['state'=>1,'result'=>$coupletArr]));
        }else {
            echo(json_encode(@['state'=>0,'error'=>mysql_error()]));
        }
    }


//－－－－－－－－－－－小猪
public function getCoupletByTime() {
        $pageCount = $_POST["pageCount"];

        $db = M();
        $sql = "call WenHuiApartment.proc_Z_CoupletByCoupletTime_Select($pageCount)";
        $result = $db->query($sql);

        $coupletArr = array();
        $i = 0;
        foreach ($result as $row) {
            $coupletArr[$i]["coupletId"] = $row["pk_couplet_id"];
            $coupletArr[$i]["coupletContent"] = $row["couplet_content"];
            $coupletArr[$i]["coupletReplyNumber"] = $row["couplet_reply_number"];
            $coupletArr[$i]["coupletSupport"] = $row["couplet_support"];
            $coupletArr[$i]["coupletTime"] = $row["couplet_time"];

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
        echo json_encode($coupletArr);
    }

    //  根据页码index（下标 0 开始） 取count 条 对联 时间最新排序
    public function getCoupletByUserIdPageIndexPageCount(){
        $userId = $_GET['userId'];
        $pageCount = $_GET['pageCount'];
        $pageIndex = $_GET['pageIndex'];
        $pageIndex = $pageIndex * $pageCount;
        $db = M();
        $sql = "call WenHuiApartment.proc_M_CoupletByUserIdPageIndexPageCount_Select($userId,$pageIndex,$pageCount)";
        $result = $db->query($sql);  
        $i=0; 
        if ($result) {
            foreach ($result as $row) {
            $coupletArr[$i]["coupletId"] = $row["pk_couplet_id"];
            $coupletArr[$i]["coupletContent"] = $row["couplet_content"];
            $coupletArr[$i]["coupletReplyNumber"] = $row["couplet_reply_number"];
            $coupletArr[$i]["coupletSupport"] = $row["couplet_support"];
            $coupletArr[$i]["coupletTime"] = $row["couplet_time"];

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
            echo(json_encode(@['state'=>1,'result'=>$coupletArr]));
        } else {
            echo(json_encode(@['state'=>0,'error'=>mysql_error()]));
        }
    }


 ///获取用户贡献书籍
    public function getBookByUserIdPageIndexPageCount_Select() {
        $userId = $_GET['userId'];
        $pageCount = $_GET['pageCount'];
        $pageIndex = $_GET['pageIndex']; 
        // $userId = 9;
        // $pageIndex = 0;
        // $pageCount = 10;
        $pageIndex = $pageIndex * $pageCount;
        $db = M();
        $sql = "call WenHuiApartment.proc_M_BookByUserIdPageIndexPageCount_Select($userId,$pageIndex,$pageCount)";
        $result = $db->query($sql);  
        $i=0; 
        if ($result) {
            foreach ($result as $row) {
            $coupletArr[$i]["bookId"] = $row["pk_book_id"];
            $coupletArr[$i]["bookName"] = $row["book_name"];
            $coupletArr[$i]["bookAuthor"] = $row["book_author"];
            $coupletArr[$i]["bookCoverURL"] = $row["book_cover_url"];
            $coupletArr[$i]["bookCommentCount"] = $row["book_comment_count"];
            $coupletArr[$i]["bookPublishTime"] = $row["book_publish_time"];
            $fieldArr = array();
            $fieldArr['fieldName'] = $row["field_name"];
            $fieldArr['fieldId'] = $row["pk_field_id"];
            $coupletArr[$i]["field"] = $fieldArr;

            $userArr = array();
            $userArr["userId"] = $row["pk_user_id"];
            $userArr["userAccount"] = $row["user_account"];
            $userArr["userName"] = $row["user_name"];
            $userArr["userAge"] = $row["user_age"];
            $userArr["userFaceURL"] = $row["user_face_url"];
            $userArr["userEXP"] = $row["user_exp"];

            $coupletArr[$i]["contributor"] = $userArr;
            $i++;
            }
            echo(json_encode(@['state'=>1,'result'=>$coupletArr]));
        } else {
            echo(json_encode(@['state'=>0,'error'=>mysql_error()]));
        }
    }
    // 获得用户收藏的图书
    public function getUserCollectBookByUserIdPageIndexPageCount_Select(){
        $userId = $_GET['userId'];
        $pageCount = $_GET['pageCount'];
        $pageIndex = $_GET['pageIndex']; 
        // $userId = 9;
        // $pageIndex = 0;
        // $pageCount = 10;
        $pageIndex = $pageIndex * $pageCount;
        $db = M();
        $sql = "call WenHuiApartment.proc_M_UserCollectBookByUserIdPageIndexPageCount_Select($userId,$pageIndex,$pageCount)";
        $result = $db->query($sql);  
        $i=0; 
        if ($result) {
            foreach ($result as $row) {
            $bookArr[$i]["bookId"] = $row["pk_book_id"];
            $bookArr[$i]["bookName"] = $row["book_name"];
            $bookArr[$i]["bookAuthor"] = $row["book_author"];
            $bookArr[$i]["bookCoverURL"] = $row["book_cover_url"];
            $bookArr[$i]["bookCommentCount"] = $row["book_comment_count"];
            $bookArr[$i]["bookPublishTime"] = $row["book_publish_time"];

            $bookArr[$i]["bookpublisher"] = $row["book_publisher"];
            $bookArr[$i]["bookSummary"] = $row["book_summary"];
            $bookArr[$i]["bookCommentCount"] = $row["book_comment_count"];
            $bookArr[$i]["bookCollectNumber"] = $row["book_collect_number"];
            $bookArr[$i]["bookTime"] = $row["book_time"];

            $fieldArr = array();
            $fieldArr['fieldName'] = $row["field_name"];
            $fieldArr['fieldId'] = $row["pk_field_id"];
            $bookArr[$i]["field"] = $fieldArr;

            $userArr = array();
            $userArr["userId"] = $row["pk_user_id"];
            $userArr["userAccount"] = $row["user_account"];
            $userArr["userName"] = $row["user_name"];
            $userArr["userAge"] = $row["user_age"];
            $userArr["userFaceURL"] = $row["user_face_url"];
            $userArr["userEXP"] = $row["user_exp"];

            $bookArr[$i]["contributor"] = $userArr;
            $i++;
            }
            echo(json_encode(@['state'=>1,'result'=>$bookArr]));
        } else {
            echo(json_encode(@['state'=>0,'error'=>mysql_error()]));
        }
    }

    //  获得用户收藏的对联
    public function getUserCollectCoupletByUserIdPageIndexPageCount_Select(){
        $userId = $_GET['userId'];
        $pageCount = $_GET['pageCount'];
        $pageIndex = $_GET['pageIndex'];
        // $userId = 1;
        // $pageIndex = 0;
        // $pageCount = 10;
        $pageIndex = $pageIndex * $pageCount;
        $db = M();
        $sql = "call WenHuiApartment.proc_M_UserCollectCoupletByUserIdPageIndexPageCount_Select($userId,$pageIndex,$pageCount)";
        $result = $db->query($sql);  
        $i=0; 
        if ($result) {
            foreach ($result as $row) {
            $coupletArr[$i]["coupletId"] = $row["pk_couplet_id"];
            $coupletArr[$i]["coupletContent"] = $row["couplet_content"];
            $coupletArr[$i]["coupletSupport"] = $row["couplet_support"];
            $coupletArr[$i]["coupletReplyNumber"] = $row["couplet_reply_number"];
            $coupletArr[$i]["coupletCollectNumber"] = $row["couplet_collect_number"];
            $coupletArr[$i]["coupletTime"] = $row["couplet_time"];

            // $coupletArr[$i]["coupletTime"] = $row["couplet_collect_number"];
            // $coupletArr[$i]["coupletTime"] = $row["couplet_collect_number"];
            // $coupletArr[$i]["coupletTime"] = $row["couplet_collect_number"];
            // $coupletArr[$i]["coupletTime"] = $row["couplet_collect_number"];
            // $coupletArr[$i]["coupletTime"] = $row["couplet_collect_number"];
            // $coupletArr[$i]["coupletTime"] = $row["couplet_collect_number"];

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
            echo(json_encode(@['state'=>1,'result'=>$coupletArr]));
        } else {
            echo(json_encode(@['state'=>0,'error'=>mysql_error()]));
        }
    }

    //获得用户收藏的图书贴
    public function getUserCollectBookPostByserIdPageIndexPageCount_Select(){
        $userId = $_GET['userId'];
        $pageCount = $_GET['pageCount'];
        $pageIndex = $_GET['pageIndex'];
        // $userId = 1;
        // $pageIndex = 0;
        // $pageCount = 10;
        $pageIndex = $pageIndex * $pageCount;
        $db = M();
        $sql = "call WenHuiApartment.proc_M_UserCollectBookPostByserIdPageIndexPageCount_Select($userId,$pageIndex,$pageCount)";
        $result = $db->query($sql);  
        $i=0; 
        if ($result) {
            foreach ($result as $row) {
            $BookPostArr[$i]["bookpostId"] = $row["pk_bookpost_id"];
            $BookPostArr[$i]["bookpostTitle"] = $row["bookpost_title"];
            $BookPostArr[$i]["bookpostContent"] = $row["bookpost_content"];
            $BookPostArr[$i]["bookpostPosition"] = $row["bookpost_position"];
            $BookPostArr[$i]["bookpostSupport"] = $row["bookpost_support"];
            $BookPostArr[$i]["bookpostReplyNumber"] = $row["bookpost_reply_number"];
            $BookPostArr[$i]["bookpostCollectNumber"] = $row["bookpost_collect_number"];
            $BookPostArr[$i]["bookpostTime"] = $row["bookpost_time"];

            $userArr = array();
            $userArr["userId"] = $row["pk_user_id"];
            $userArr["userAccount"] = $row["user_account"];
            $userArr["userName"] = $row["user_name"];
            $userArr["userAge"] = $row["user_age"];
            $userArr["userFaceURL"] = $row["user_face_url"];
            $userArr["userEXP"] = $row["user_exp"];
            $BookPostArr[$i]["user"] = $userArr;

            $fieldArr = array();
            $fieldArr['fieldId'] = $row["pk_field_id"];
            $fieldArr['fieldName'] = $row["field_name"];
            $BookPostArr[$i]['field'] = $fieldArr;

            $bookArr = array();
            $bookArr['bookId'] = $row["pk_book_id"];
            $bookArr['bookName'] = $row["book_name"];
            $bookArr['bookAuthor'] = $row["book_author"];
            $bookArr['bookPublishTime'] = $row["book_publish_time"];
            $bookArr['bookCoverURL'] = $row["book_cover_url"];
            $bookArr['bookpublisher'] = $row["book_publisher"];
            $BookPostArr[$i]['book'] = $bookArr;
            $i++;
            }
            echo(json_encode(@['state'=>1,'result'=>$BookPostArr]));
        } else {
            echo(json_encode(@['state'=>0,'error'=>mysql_error()]));
        }
    }

    //获得用户收藏的辩题
    public  function getUserCollectThesisByUserIdByPageIndexPageCount_Select(){
        $userId = $_GET['userId'];
        $pageCount = $_GET['pageCount'];
        $pageIndex = $_GET['pageIndex'];
        // $userId = 1;
        // $pageIndex = 0;
        // $pageCount = 10;

        $pageIndex = $pageIndex * $pageCount;
        $db = M();
        $sql = "call WenHuiApartment.proc_M_UserCollectThesisByUserIdByPageIndexPageCount_Select($userId,$pageIndex,$pageCount)";
        $result = $db->query($sql);  
        $i=0; 
        if ($result) {
            foreach ($result as $row) {
            $ThesisArr[$i]["thesisId"] = $row["pk_thesis_id"];
            $ThesisArr[$i]["thesisContent"] = $row["thesis_content"];
            $ThesisArr[$i]["thesisPros"] = $row["thesis_pros"];
            $ThesisArr[$i]["thesisProsCount"] = $row["thesis_pros_count"];
            $ThesisArr[$i]["thesisProsReplyNumber"] = $row["thesis_pros_reply_number"];
            $ThesisArr[$i]["thesisCons"] = $row["thesis_cons"];
            $ThesisArr[$i]["thesisConsCount"] = $row["thesis_cons_count"];
            $ThesisArr[$i]["thesisConsReplyNumber"] = $row["thesis_cons_reply_number"];
            $ThesisArr[$i]["thesisCollectNumber"] = $row["thesis_collect_number"];
            $ThesisArr[$i]["thesisStartTime"] = $row["thesis_start_time"];
            $ThesisArr[$i]["thesisEndTime"] = $row["thesis_end_time"];
            $ThesisArr[$i]["thesisTime"] = $row["thesis_time"];
            $stateArr = array();
            $stateArr['stateId'] = $row['pk_state_id'];
            $stateArr['stateName'] = $row['state_name'];
            $stateArr['stateValue'] = $row['state_value'];
            $stateArr['stateType'] = $row['state_type'];
            $stateArr['stateTime'] = $row['state_time'];
            $ThesisArr[$i]["state"] = $stateArr;

            $ThesisArr[$i]['pros'] = $this->getArgument($row["pk_thesis_id"],1);
            $ThesisArr[$i]['cons'] = $this->getArgument($row["pk_thesis_id"],0);
            $i++;
            }
            echo(json_encode(@['state'=>1,'result'=>$ThesisArr]));
        } else {
            echo(json_encode(@['state'=>0,'error'=>mysql_error()]));
        }
    }

// proc_M_ArgumentByThesisidBelong_Select_best
    //获取论据$thesisId,$belong
    public function getArgument($thesisId,$belong){
        // $thesisId =1 ;
        // $belong=1;
        $db = M();
        $sql = "call WenHuiApartment.proc_M_ArgumentByThesisidBelong_Select_best($thesisId,$belong)";
        $result = $db->query($sql);  
        $result[0]['user'] = $this->getUser($result[0]['fk_argument_user_id']);
        return $result[0];
    }
// proc_M_UserByUserId_Select
    public function getUser($userid){
        // $userid  = 2;
        $db = M();
        $sql = "call WenHuiApartment.proc_M_UserByUserId_Select($userid)";
        $result = $db->query($sql);  
        // echo(json_encode($result[0]));
        return $result[0];
    }
    //获取用户收藏的问题
    public function getUserCollectQuestionByUserIdPageIndexPageCount_Select() {
        $userId = $_GET['userId'];
        $pageCount = $_GET['pageCount'];
        $pageIndex = $_GET['pageIndex'];
        // $userId = 1;
        // $pageIndex = 0;
        // $pageCount = 10;

        $pageIndex = $pageIndex * $pageCount;
        $db = M();
        $sql = "call WenHuiApartment.proc_M_UserCollectQuestionByUserIdPageIndexPageCount_Select($userId,$pageIndex,$pageCount)";
        $result = $db->query($sql);  
        $i=0; 
        if ($result) {
            foreach ($result as $row) {
            $QuestionArr[$i]["questionId"] = $row["pk_question_id"];
            $QuestionArr[$i]["questionContent"] = $row["question_content"];
            $QuestionArr[$i]["questionOptionOne"] = $row["question_option_one"];
            $QuestionArr[$i]["questionOptionTwo"] = $row["question_option_two"];
            $QuestionArr[$i]["questionOptionThree"] = $row["question_option_three"];
            $QuestionArr[$i]["questionAnswer"] = $row["question_answer"];
            
            $QuestionArr[$i]["questionCollectNumber"] = $row["question_collect_number"];

            $QuestionArr[$i]["questionTime"] = $row["question_time"];

            $userArr = array();
            $userArr["userId"] = $row["pk_user_id"];
            $userArr["userAccount"] = $row["user_account"];
            $userArr["userName"] = $row["user_name"];
            $userArr["userFaceURL"] = $row["user_face_url"];
            $userArr["userScore"] = $row["user_score"];
            $userArr["userAge"] = $row["user_age"];
            $QuestionArr[$i]["user"] = $userArr;

            $stateArr = array();
            $stateArr['stateId'] = $row['pk_state_id'];
            $stateArr['stateName'] = $row['state_name'];
            $stateArr['stateValue'] = $row['state_value'];
            $stateArr['stateType'] = $row['state_type'];
            $stateArr['stateTime'] = $row['state_time'];
            $QuestionArr[$i]["state"] = $stateArr;
            $i++;
            }
            echo(json_encode(@['state'=>1,'result'=>$QuestionArr]));
        } else {
            echo(json_encode(@['state'=>0,'error'=>mysql_error()]));
        }
    }


    // 添加关注人，或者变更关注状态 1 0 
    public function get_M_ConcerPersonByStateUserIdPersonId_Update_Insert(){
        $userId = $_POST['userId'];
        $state = $_POST['state'];
        $personid = $_POST['personid'];

        $db = M();
        $sql = "call WenHuiApartment.proc_M_ConcerPersonByStateUserIdPersonId_Update_Insert($state,$userId,$personid)";
        $result = $db->query($sql);  
        $i=0; 
        if (!$result) {
            echo(json_encode(@['state'=>1]));
        } else {
            echo(json_encode(@['state'=>0,'error'=>mysql_error()]));
        }
    }

    public function saveHeadImage(){
        header("Content-type:text/html;charset=utf-8");
        $userid = $_POST['userid'];
        $filename = $_FILES['images']['name'];
        $filepath = 'images/head/'.$filename;
        $filename = 'Application/Home/images/head/'.$filename;
        if(!$_FILES['images']['error']){
           if(move_uploaded_file($_FILES['images']['tmp_name'],$filename))
           {
                if ($this->updateImageUrl($userid,$filepath)) {
                    echo(json_encode(@["code"=>200,'header'=>$_FILES['images'],'userid'=>$userid,'filename'=>$filename]));
                }else {
                    echo(json_encode(@['code'=>500]));
                }
          }
          else{
            echo json_encode(array("code"=>"300","data"=>$_FILES['images'],"filename"=>$filename));
          }
        }
        else{
           echo json_encode(array("code"=>"400","data"=>$_FILES['images']));
        }
    }

    public function uploadBookInfo() {
        header("Content-type:text/html;charset=utf-8");

        $userid = $_POST['userid'];
        $bookname = $_POST['bookname'];
        $author = $_POST['author'];
        $publisher = $_POST['publisher'];
        $summary = $_POST['summary'];
        $publishTime = $_POST['publishTime'];
        $fieldid = $_POST['fieldid'];
        $summary = preg_replace_callback('/[\xf0-\xf7].{3}/', function($r) { return '@E' . base64_encode($r[0]);}, $summary);
        $filename = $_FILES['images']['name'];
        $filepath = 'images/cover/'.$filename;
        $filename = 'Application/Home/images/cover/'.$filename;


        if(!$_FILES['images']['error']){
           if(move_uploaded_file($_FILES['images']['tmp_name'],$filename))
           {
                if ($this->insertBookInfo($userid,$bookname,$author,$publisher,$summary,$publishTime,$fieldid,$filepath)) {
                    $this->addEXP($userid,7);
                    echo(json_encode(@["code"=>200,'header'=>$_FILES['images'],'userid'=>$userid,'filename'=>$filename]));
                }else {
                    echo(json_encode(@['code'=>500,'error'=>mysql_error()]));
                }
          }
          else{
            echo json_encode(array("code"=>500,"data"=>$_FILES['images'],"filename"=>$filename));
          }
        }
        else{
           echo json_encode(array("code"=>500,"data"=>$_FILES['images']));
        }
    }
    //$userid,$bookname,$author,$publisher,$summary,$publishTime,$fieldid,$coverUrl
    public function insertBookInfo($userid,$bookname,$author,$publisher,$summary,$publishTime,$fieldid,$coverUrl) {
        // $author = "\U82a6\U7530\U7231\U83dc";
        // $bookname = "\U7231\U83dc\U5b66";
        // $fieldid = 5;
        // $publishTime = "2013-10-27 09:48:26";
        // $publisher = "\U9713\U8679";
        // $summary = "\U8fd9\U662f\U4e00\U672c\U82a6\U7530\U7231\U83dc\U751f\U6d3b\U8bb0\U5f55\U7684\U4e66\U7c4d\Uff0c\U559c\U6b22\U7684\U540c\U5b66\U8bf7\U5feb\U5feb\U8d2d\U4e70\U5566\Uff0c\U9650\U91cf\U4f9b\U5e94\Uff0c\U4e0b\U6b21\U5c31\U4e0d\U77e5\U9053\U4ec0\U4e48\U65f6\U5019\U56de\U6cb9\U4e86";
        // $userid = 11;

        $db = M();
        $sql = "call WenHuiApartment.proc_M_Book_Insert($userid,'$bookname','$author','$publisher','$summary','$publishTime',$fieldid,'$coverUrl')";
        $result = $db->query($sql); 
        return $result;
    }


    public function addEXP($userid,$exp){
        $db = M();
        // proc_M_UserByUserIDEXP_Update
        $sql = "call WenHuiApartment.proc_M_UserByUserIDEXP_Update($userid,$exp)";
        $result = $db->query($sql);
    }

    public function updateImageUrl($userId,$filepath) {
        $db = M();
        $sql = "call WenHuiApartment.proc_M_UserByUserIdImageUrl_Update($userId,'$filepath')";
        $result = $db->query($sql); 
        return $result;
    }

    public function getFieldsALL() {
        $db = M();
        $sql = "call WenHuiApartment.proc_M_FieldByAll_Select()";
        $result = $db->query($sql);
        if ($result) {
            $i = 0;
            foreach ($result as $row) {
                $fieldArr[$i]['fieldId'] = $row['pk_field_id'];
                $fieldArr[$i]['fieldName'] = $row['field_name'];
                // $fieldArr[$i][] = $row['field_time'];
                // $fieldArr[$i][] = $row['field_usable'];
                $i++;
            }
            echo(json_encode(@['state'=>1,'result'=>$fieldArr]));
        }else {
            echo(json_encode(@['state'=>0]));
        }
    }




    


//检查用户是否已经关注别人
    public function getUserFollowInfoByUserIDPersonId(){
        $userid = $_GET['userid'];
        $personid = $_GET['personid'];
        // proc_M_ConcerByUserIDPersonID_Select
        $db=M();
        $sql= "call WenHuiApartment.proc_M_ConcerByUserIDPersonID_Select($userid,$personid)";
        $result = $db->query($sql);
        if ($result) {
            echo(json_encode(@['state'=>1]));
        }else {
            echo(json_encode(@['state'=>0]));
        }
    }

    //////////////////////////////////////////////////////////////////////////////
    // 图书贴点赞
    public function updateSupToBookpost(){
        // proc_M_BookpostSupRecodeBySupidUseridStates_Update_Insert
        $userid = $_POST['userid'];
        $supid = $_POST['supid'];
        $state = $_POST['states'];
        // $userid = 2;
        // $supid = 4;
        // $state = 1;
        $db = M();
        $sql = "call WenHuiApartment.proc_M_BookpostSupRecodeBySupidUseridStates_Update_Insert($supid,$userid,$state)";
        $result = $db->query($sql);  
        if (!$result) {
            // $this->BookReplyByStateSuPID_Update($supid,$state);
            // $result = $this->getBookReplyByInfo_One($supid);
            echo(json_encode(@['result'=>1,'state'=>$state]));
        } else {
            $result = $this->getBookReplyByInfo_One($supid);
            echo(json_encode(@['result'=>0,'error'=>mysql_error()]));
        }
    }


    // 检查图书贴点赞,收藏
    public function getInfoByUserCollectBpAndSup(){
        $bookpostid = $_GET['bookpostid'];
        $userid = $_GET['userid'];
        // $bookpostid = 4;
        // $userid = 2;
        $db=M();
        $sql_1= "call WenHuiApartment.proc_M_UserCollectBookpostByUseridBookpostid_Select($userid,$bookpostid)";
        $result_1 = $db->query($sql_1);
        $sql_2= "call WenHuiApartment.proc_M_BookpostSupRecodeByUseridBookpostid_Select($userid,$bookpostid)";
        $result_2 = $db->query($sql_2);
        $collect = 0;
        $sup = 0;
        if ($result_1) {
            $collect = 1;
        }
        if ($result_2) {
            $sup = 1;
        }
        echo(json_encode(@['collect'=>$collect,'sup'=>$sup]));
    }


// proc_M_UserCollectBookpostByUseridBpidState_Update_Select
    //更新收藏信息
    public function supdateCollectToBookpost (){
        $userid = $_POST['userid'];
        $supid = $_POST['supid'];
        $state = $_POST['states'];
        // $userid = 2;
        // $supid = 4;
        // $state = 1;
        $db = M();
        $sql = "call WenHuiApartment.proc_M_UserCollectBookpostByUseridBpidState_Update_Select($userid,$supid,$state)";
        $result = $db->query($sql);  
        if (!$result) {
            // $this->BookReplyByStateSuPID_Update($supid,$state);
            // $result = $this->getBookReplyByInfo_One($supid);
            echo(json_encode(@['result'=>1,'state'=>$state]));
        } else {
            $result = $this->getBookReplyByInfo_One($supid);
            echo(json_encode(@['result'=>0,'error'=>mysql_error()]));
        }
    }
    // 用户修改信息
    public function exInfo(){
        $userid = $_POST['userid'];
        $filedsname = $_POST['fields'];
        $userName = $_POST['userName'];
        $userAge = $_POST['userAge'];
        $db=M();
        // $proc_M_UserByUserName_Select
        $result = $db->query("call WenHuiApartment.proc_M_UserByUserName_Select('$userName')");
        if ($result && $result[0]['pk_user_id'] != $userid) {
            echo(json_encode(@['state'=>500]));
        }else {
            $this->changeInfos($userid,$userName,$userAge);
            $this->changeFields($userid,$filedsname);
            echo(json_encode(@['state'=>200]));
        }
        
    }


    //修改信息
    public function changeInfos ($userid,$userName,$userAge){
        // $userid= 11;$userName = '花菜';$userAge = 13;
        $db=M();
        $result = $db->query("call WenHuiApartment.proc_M_UserByNameAge_Update('$userName',$userAge,$userid)");
    }


    //用户修改领域
    public function changeFields($userid,$filedsname) {
        // $userid = $_POST['userid'];
        // $filedsname = $_POST['fields'];
        // $userid = 11;
        // $filedsname =@['散文','动漫'];
        $db = M();
        $db->query("call WenHuiApartment.proc_M_UserFocuFieldByUserid_Delete($userid)");
        foreach ($filedsname as $row) {
            $field = $this->getFieldByFieldName($row);
            $fieldid = $field[0]['pk_field_id'];
            $this->updateField($userid,$fieldid);
        }
        // echo(json_encode(@['state'=>200]));
    }

    public function getFieldByFieldName($name) {
        // $name = '动漫';
        $db = M();
        $field = $db->query("call WenHuiApartment.proc_M_FieldByfieldName_Select('$name')");
        // echo(json_encode($field));
        return $field;
    }

    public function updateField($userid,$fieldid) {
        // $userid = 11;$fieldid = 1;
        $db = M();
        $db->query("call WenHuiApartment.proc_M_UserFocusFieldByUseridField_Update_Insert($userid,$fieldid)");
    }




    // 验证用户
    //proc_M_UseByAccountPassWord_Select
    public function checkAccountPassWord(){
        $account = $_POST['account'];
        $password = $_POST['password'];
        $db = M();
        $result = $db->query("call WenHuiApartment.proc_M_UseByAccountPassWord_Select('$account','$password')");
        if ($result) {
            echo(json_encode(@['state'=>200]));
        }else {
            echo(json_encode(@['state'=>500]));
        }
    }

    ///设置保密问题
    public function setBAOMI(){
        $ao = $_POST['ao'];
        $at = $_POST['at'];
        $aw = $_POST['aw'];
        $qo = $_POST['qo'];
        $qt = $_POST['qt'];
        $qw = $_POST['qw'];
        $userid = $_POST['userid'];

        $db=M();
        $db->query("call WenHuiApartment.proc_M_SecurityQuestionByUserID_Delete($userid)");
// proc_M_SecurityQuestionByAll_Insert
        $db->query("call WenHuiApartment.proc_M_SecurityQuestionByAll_Insert($userid,'$ao','$at','$aw','$qo','$qt','$qw')");
        echo(json_encode(@['state'=>200]));
    }
}