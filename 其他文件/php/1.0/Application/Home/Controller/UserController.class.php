<?php
namespace Home\Controller;
use Think\Controller;
class UserController extends Controller {

    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////// - - - - - - - - - - 用户设置 - - - - - - - - - - //////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	// 获取用户信息，使用账号密码验证
	public function getUserByAccountPassword() {
		$account = $_POST['userAccount'];
		$password = $_POST['userPassword'];

		$db = M();
		$sql = "call WenHuiApartment.proc_UserByAccount_Select($account)";
		$result = $db->query($sql);

		$user = array();
		foreach ($result as $row) {
			// 服务器判断，防止注入
			if ($password == $row['user_password']) {
				$user['userId'] = $row['pk_user_id'];
	            $user['userAccount'] = $row['user_account'];
	            $user['userName'] = $row['user_name'];
	            $user['userAge'] = $row['user_age'];
	            $user['userFaceURL'] = $row['user_face_url'];
	            $user['userScore'] = $row['user_score'];
	            $user['userEXP'] = $row['user_exp'];
	            $user['userRegisterTime'] = $row['user_register_time'];
	            $user['userLevel'] = $row['level_name'];
	            // 获取用户关注领域数组
				$sql = "call proc_UserFocusFieldByUserID_Select(".$row['pk_user_id'].")";
				$result_fieldArr = $db->query($sql);
				$focusFieldArr = array();
				$i = 0;
				foreach ($result_fieldArr as $row) {
					$focusFieldArr[$i]['fieldId'] = $row['pk_field_id'];
					$focusFieldArr[$i]['fieldName'] = $row['field_name'];
					$i++;
				}
				$user['focusFieldArr'] = $focusFieldArr;
			}
		}
		echo(json_encode(@["data"=>@["aUser"=>$user]]));
	}

    public function uploadUserHead() {

    	$tmpPath = $_FILES['head']['tmp_name'];
    	$fileName = $_FILES['head']['name'];
    	$filePath = 'Application/Home/Images/Head/'.$fileName;
    	$currUserID = $_POST['currUserID'];

		$user = array();
    	if (!$_FILES['head']['error'] && move_uploaded_file($tmpPath, $filePath)) {
    		$db = M('user');

    		// 删除旧头像
    		$oldFilePath = 'Application/Home/Images/Head/'.$db->where(@['pk_user_id'=>$currUserID])->getField('user_face_url');
    		unlink($oldFilePath);

    		// 新头像信息存入数据库
    		$result = $db->where(@['pk_user_id'=>$currUserID])->save(@['user_face_url'=>$fileName]);

			// 如果成功结果为1， 如果失败结果为false	
    		if ($result) {
    			// 更新成功重新获取用户信息
    			$user = $this->getUserByCurrUserID($currUserID);
    		}
    	}
    	echo json_encode(@["data"=>@["aUser"=>$user]]);
	}

	// 获取用户信息， 使用userID验证（后期要改为token）
	public function getUserByCurrUserID($currUserID) {
		$db = M();
		$sql_user = "call WenHuiApartment.proc_UserByUserID_Select($currUserID)";
		$result_user = $db->query($sql_user);

		// 获取用户信息
		$user = array();
		foreach ($result_user as $row) {
            $user['userId'] = $row['pk_user_id'];
            $user['userAccount'] = $row['user_account'];
            $user['userName'] = $row['user_name'];
            $user['userAge'] = $row['user_age'];
            $user['userFaceURL'] = $row['user_face_url'];
            $user['userScore'] = $row['user_score'];
            $user['userEXP'] = $row['user_exp'];
            $user['userRegisterTime'] = $row['user_register_time'];
            $user['userLevel'] = $row['level_name'];
        }

        // 获取用户关注领域数组
		$sql = "call proc_UserFocusFieldByUserID_Select($currUserID)";
		$result_fieldArr = $db->query($sql);
		$focusFieldArr = array();
		$i = 0;
		foreach ($result_fieldArr as $row) {
			$focusFieldArr[$i]['fieldId'] = $row['pk_field_id'];
			$focusFieldArr[$i]['fieldName'] = $row['field_name'];
			$i++;
		}
		$user['focusFieldArr'] = $focusFieldArr;

		return $user;
	}

	// 修改用户信息
	public function modifyUserInfo() {
		$newUserName = $_POST['newUserName'];
		$newUserAge = $_POST['newUserAge'];
		$oldFieldIDArr = $_POST['oldFieldIDArr'];
		$newFieldIDArr = $_POST['newFieldIDArr'];
		$currUserID = $_POST['currUserID'];

		$db = M();
		$sql = "call WenHuiApartment.proc_UserByUserID_Select($currUserID)";
		$result = $db->query($sql);

		$user = array();
		foreach ($result as $row) {
			// 修改用户名，用户年龄
			$db_user = M('user');
			$updateData = @['user_name'=>$newUserName, 'user_age'=>$newUserAge];
			$result = $db_user->where(@['pk_user_id'=>$currUserID])->save($updateData);

			$db_focus_field = M('user_focus_field');

			$userFocusFieldIdArr = array();
			// 获取pk_user_focus_field_id
			for ($i = 0; $i < count($oldFieldIDArr); $i++) {
				$condition = @['fk_user_focus_field_field_id'=>$oldFieldIDArr[$i], 'fk_user_focus_field_user_id'=>$currUserID];
				$userFocusFieldIdArr[$i] = $db_focus_field->where($condition)->getField('pk_user_focus_field_id');	
			}

			// 通过pk_user_focus_field_id设置新的fieldId
			for ($i = 0; $i < count($oldFieldIDArr); $i++) {
				$condition = @['pk_user_focus_field_id'=>$userFocusFieldIdArr[$i]];
				$updateData = @['fk_user_focus_field_field_id'=>$newFieldIDArr[$i]];
				$result_fieldArr = $db_focus_field->where($condition)->save($updateData);
				$result = $result || $result_fieldArr;
			}
			
    		if ($result) {
    			// 更新成功重新获取用户信息
    			$user = $this->getUserByCurrUserID($currUserID);
    			echo json_encode(@["code"=>"0", "msg"=>"更新成功", "data"=>@["aUser"=>$user]]);
    		}  else {
    			echo json_encode(@["code"=>"2", "msg"=>"更新失败，原信息与新信息相同。", "data"=>@[]]);
    		}
		}
	}

	// 修改用户密码
	public function modifyUserPassword() {
		$newPassword = $_POST['newPassword'];
		$oldPassword = $_POST['oldPassword'];
		$currUserID = $_POST['currUserID'];

		$db = M();
		$sql = "call WenHuiApartment.proc_UserByUserID_Select($currUserID)";
		$result = $db->query($sql);

		$user = array();
		foreach ($result as $row) {
			// 服务器判断，防止注入
			if ($oldPassword == $row['user_password']) {
				$db = M('user');
	    		$result = $db->where(@['pk_user_id'=>$currUserID])->save(@['user_password'=>$newPassword]);

				// 如果成功结果为1， 如果失败结果为false	
	    		if ($result) {
	    			// 更新成功重新获取用户信息
	    			$user = $this->getUserByCurrUserID($currUserID);
	    			echo json_encode(@["code"=>"0", "msg"=>"更新成功", "data"=>@["aUser"=>$user]]);
	    		}  else {
	    			echo json_encode(@["code"=>"2", "msg"=>"更新失败", "data"=>@[]]);
	    		}
			} else {
	    		echo json_encode(@["code"=>"1", "msg"=>"更新失败, 密码错误", "data"=>@[]]);
	    	}
		}
	}

    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////// - - - - - - - - - - 用户关注 - - - - - - - - - - //////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// 获取用户所关注用户的列表
    public function getCollectedUserList() {
        $currUserID = $_POST["currUserID"];
        $pagination = $_POST['pagination'];
        $pageCount = $_POST['pageCount'];
        $pageIndex = ($pagination - 1) * $pageCount;

        $db = M();
        $sql = "call proc_UserCollectUser_Select($currUserID, $pageIndex, $pageCount)";
        $result = $db->query($sql);

        $collectedUserArr = array();
        $i = 0;
        foreach ($result as $row) {
        	$collectedUserArr[$i]["userId"] = $row["pk_user_id"];
            $collectedUserArr[$i]["userAccount"] = $row["user_account"];
            $collectedUserArr[$i]["userName"] = $row["user_name"];
            $collectedUserArr[$i]["userAge"] = $row["user_age"];
            $collectedUserArr[$i]["userFaceURL"] = $row["user_face_url"];
            $collectedUserArr[$i]["userEXP"] = $row["user_exp"];
            $collectedUserArr[$i]['userLevel'] = $row['level_name'];

            // 获取用户关注领域数组
			$sql_fields = "call proc_UserFocusFieldByUserID_Select(".$row['pk_user_id'].")";
			$result_fieldArr = $db->query($sql_fields);
			$focusFieldArr = array();
			$j = 0;
			foreach ($result_fieldArr as $row) {
				$focusFieldArr[$j]['fieldId'] = $row['pk_field_id'];
				$focusFieldArr[$j]['fieldName'] = $row['field_name'];
				$j++;
			}
			$collectedUserArr[$i]['focusFieldArr'] = $focusFieldArr;

            $i ++;
        }
        echo json_encode(@["code"=>0, "msg"=>"ok", "data"=>@["aList"=>$collectedUserArr]]);
    }

	// 改变用户关注用户记录
    public function changeUserCollectionRecord() {
        $collectedUserID = $_POST["collectedUserID"];
        $currUserID = $_POST["currUserID"];
        $currCollected = $_POST["currCollected"];

        $db = M();
        $sql = "call proc_UserCollectUserByUserIDCollectedUserID_InsertOrDelete($collectedUserID, $currUserID, $currCollected)";
        $result = $db->query($sql);

        // 判断是否为数组,如果为数组则改变成功，如果返回false则添加失败
        if (is_array($result)) {
            echo json_encode(@["result"=>1]);
        }
        else {
            echo json_encode(@["result"=>0]);
        }
    }

    // 判断用户是否关注另一个用户
    public function judgeUserCollectOtherUser() {
		$otherUserID = $_POST["otherUserID"];
        $currUserID = $_POST["currUserID"];

        $db = M('user_collect_user');
        $result = $db->where('fk_ucu_user_id='.$currUserID.' AND fk_ucu_user_id_collected='.$otherUserID.' AND collect_usable=1')->find();

        // 判断是否为数组,如果为数组则改变成功，如果返回false则添加失败
        if (is_array($result)) {
            echo json_encode(@["result"=>1]);
        }
        else {
            echo json_encode(@["result"=>0]);
        }
    }
}