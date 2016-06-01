<?php
namespace Home\Controller;
use Think\Controller;
class lcrController extends Controller {
    //关注领域表$userid
    public function getT_USER_FOCUS_FIELD($userid){
        $db=M("t_user_focus_field");
        $result = $db->where("fk_user_focus_field_user_id=$userid and user_focus_field_usable = 1")->select();
        return $result;
    }

    //领域
    public function getFieldByFieldId($fieldid){
        $db=M("t_field");
        $result = $db->where("pk_field_id=$fieldid")->select();
        return $result[0];
    }

    //称号表
    public function getT_LEVEL($exp) {
        $db = M("t_levels");
        $result = $db->where("level_min_exp <=$exp and $exp <= level_max_exp")->select();
        return $result[0];
    }
    public function getUserInfoByUserId($userid){
        $db = M("t_user");
        $result = $db->where("pk_user_id = $userid")->select();
        $result = $result[0];
        $field_users = $this->getT_USER_FOCUS_FIELD($userid);
        $i = 0;
        foreach ($field_users as $key => $value) {
            $fields[$i] = $this->getFieldByFieldId($value['fk_user_focus_field_field_id'])['field_name'];
            $i++;
        }
        if (!$fields) {
            $fields = array();
        }
        $re["foucusFieldsArr"] = $fields;
        $re["userLevel"] = $this->getT_LEVEL($result['user_exp'])['level_name'];
        $re['userId'] = $result['pk_user_id'];
        $re['userAccount'] = $result['user_account'];
        $re['userName'] = $result['user_name'];
        $re['userAge'] = $result['user_age'];
        $re['userFaceURL'] = $result['user_face_url'];
        $re['userScore'] = $result['user_score'];
        $re['userEXP'] = $result['user_exp'];
  
        return $re;
    }
    public function Login()
    {
        $account = $_POST["Account"];
        $password = $_POST["Password"];
   
        $db = M();
        $sql1  = "select * from  T_USER where user_account ='$account'";
        $result1 = $db->query($sql1);

        $sql2  = "select * from  T_USER where user_account ='$account' and user_password = '$password'";
        $result2 = $db->query($sql2);
        if(empty($result1))
        {
             echo (json_encode(@["result" =>0]));           
        }
        else {
            if (empty($result2)) {
                echo (json_encode(@["result"=> 2]));
            }
            else
            {
                $re = $this->getUserInfoByUserId($result2[0]['pk_user_id']);
        
                echo (json_encode(@["result"=>1,"sq"=>$re]));                
            }

            
            }
    }
    public function Register() {
        
        $account = $_POST["account"];
        $password = $_POST["password"];
        $username = $_POST["Username"];
        $userage = $_POST["UserAge"];
        $questionone = $_POST["Questionone"];
        $questiontwo = $_POST["Questiontwo"];
        $questionthree = $_POST["Questionthree"];
        $answerone = $_POST["Answerone"];
        $answertwo = $_POST["Answertwo"];
        $answerthree = $_POST["Answerthree"];
        $field1 = $_POST["1"];
        $field2 = $_POST["2"];
        $field3 = $_POST["3"]; 
        $db = M();
        $sql3 = "select * from T_USER where user_account = '$account'" ;
        $result3 = $db->query($sql3);
        $sql7 = "select * from T_USER where user_name = '$username'";
        $result7 = $db->query($sql7);

        if(empty($result3) && empty($result7)) 
    
        {
            $sql2 = "insert into T_USER(user_account, user_password,user_name,user_age) values('$account','$password','$username',$userage)";
            $result2 = $db->query($sql2);

            $sql5 = "select * from T_USER where user_account = '$account'";
            $result5 = $db->query($sql5);
            $id;
            foreach ($result5 as $row) {
                $id = $row["pk_user_id"];
            }
            $sql4 = "insert into T_SECURITY_QUESTION(fk_security_question_user_id,security_question_one,security_question_two,security_question_three,security_question_answer_one,security_question_answer_two,security_question_answer_three) values($id,'$questionone','$questiontwo','$questionthree','$answerone','$answertwo','$answerthree')";
            $result4 = $db->query($sql4);
            $sql6 = "select * from T_USER where pk_user_id = $id";
            $userResult = $db->query($sql6);
            $user = array();
            foreach ($userResult as $row) {
                $user["userId"] = $row["pk_user_id"];
                $user["userAccount"] = $row["user_account"];
                $user["userPassword"] = $row["user_password"];
            }
            $sql7 = "call proc_L_UserFocusFieldByUserIdFieldId_Insert($userId, $field1, $field2, $field3)";
            $result7 = $db->query($sql7);


            echo (json_encode(@["result"=>1,"sq" =>$user]));
        }
        else {
            echo (json_encode(@["result"=>0]));
        }

    }




    public function Findquestion() 
    {
        $account = $_POST["account"];       
        $db = M();
        $sql1 ="select * from T_USER where user_account = '$account'";
        $result1 = $db->query($sql1);
        if(empty($result1))
            { 
               echo(json_encode(@["result"=>0]));
            }
        else{  
            $id;
            foreach ($result1 as $row) 
            {
                $id = $row["pk_user_id"];
            }           
               $sql2 = "select * from  T_SECURITY_QUESTION where fk_security_question_user_id = $id";
               $result2 = $db->query($sql2);
              
                 $securityQuestion;
                 foreach ($result2 as $row)
               {
                   $securityQuestion["securityQuestionOne"] = $row["security_question_one"];
                    $securityQuestion["securityQuestionTwo"] = $row["security_question_two"];
                   $securityQuestion["securityQuestionThree"] = $row["security_question_three"];

               }
                   echo (json_encode(@["result"=>1,"sq"=>$securityQuestion]));
            }
            
            
    }

    public function forgetpassword()
   {

                $answerone = $_POST["AnswerOne"];
                $answertwo = $_POST["AnswerTwo"];
                $answerthree = $_POST["AnswerThree"];
                $account = $_POST["Account"];

                $db = M();
                $sql1 = "
                select *
                from (
                    select *
                    from T_SECURITY_QUESTION sq1
                    where sq1.security_question_answer_one = '$answerone' and sq1.security_question_answer_two = '$answertwo' and sq1.security_question_answer_three = '$answerthree'
                )sq
                left join (
                    select *
                    from T_USER
                    where T_USER.user_account = $account
                ) u
                on sq.fk_security_question_user_id = u.pk_user_id";
                $result1 = $db->query($sql1);
            
                if(empty($result1))
                {
                    echo (json_encode(["result"=>0]));

                }
                else
                {
                    echo (json_encode(["result"=>1]));

                }
    }

    public function changepassword()
    {   
        $account = $_POST["account"]; 
        $password = $_POST["password"]; 
        $db = M();
        $sql2 = "update T_USER set user_password = $password where user_account = $account";
        $result2 = $db->query($sql2);
        echo (json_encode(@["result"=>1]));

    }
    public function phoneRegister()
    {
        $account = $_POST["account"];
        $password = $_POST["password"];
        $db = M();
        $sql =  "select * from T_USER where T_USER.user_account = $account";
        $result = $db->query($sql);
        if(empty($result))
        {
            $sql1 = "insert into T_USER(user_account, user_password,user_name) values('$account','$password','$account')" ;
            $result1 = $db->query($sql1);

            echo (json_encode(["result"=>1]));
        }
        else
        {
            echo (json_encode(["result"=>0]));
        }

    }
    public function phoneValidated()
    {
        $account = $_POST["account"];
        $db = M();
        $sql =  "select * from T_USER where T_USER.user_account = '$account'";
        $result = $db->query($sql);
        if(empty($result)) {
           echo (json_encode(["result"=>0]));
        }
        else {
           echo (json_encode(["result"=>1]));
        }
    }
    public function phonePassword()
    {
        $account = $_POST["account"];
        $password = $_POST["password"];
        $db = M();
        $sql1 = "update T_USER set user_password = $password where user_account = $account";
        $result1 = $db->query($sql1);
        echo (json_encode(["result"=>1]));

    }
}