select version();

show variables like '%sche%';
SET GLOBAL event_scheduler=1;

-- ok
CREATE  EVENT  STAT
ON  SCHEDULE  EVERY  1  MONTH  STARTS DATE_ADD(DATE_ADD(DATE_SUB(CURDATE(),INTERVAL DAY(CURDATE())-1 DAY), INTERVAL 1 MONTH),INTERVAL 1 HOUR)
ON  COMPLETION  PRESERVE  ENABLE
DO CALL testEvent()

-- ok
CREATE EVENT test1
ON SCHEDULE EVERY 1 DAY
STARTS '2015-10-10 00:00:00'
ON COMPLETION PRESERVE ENABLE
DO CALL proc_Z_ThesisReplaceNew_Update();


CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_Z_ThesisReplaceNew_Update`()
    NO SQL
BEGIN
DECLARE currThesisId int;
DECLARE nextThesisId int;
DECLARE readyStateId int;
DECLARE workingStateId int;
DECLARE endStateId int;
SET readyStateId = (
	SELECT T_STATE.pk_state_id
	FROM T_STATE
	WHERE T_STATE.state_usable=1 AND T_STATE.state_type='Thesis' AND T_STATE.state_value=1
);
SET workingStateId = (
	SELECT T_STATE.pk_state_id
	FROM T_STATE
	WHERE T_STATE.state_usable=1 AND T_STATE.state_type='Thesis' AND T_STATE.state_value=2
);
SET endStateId = (
	SELECT T_STATE.pk_state_id
	FROM T_STATE
	WHERE T_STATE.state_usable=1 AND T_STATE.state_type='Thesis' AND T_STATE.state_value=3
);

SET currThesisId = (
    SELECT T_THESIS.pk_thesis_id
    FROM T_THESIS
	WHERE T_THESIS.thesis_usable=1 AND T_THESIS.fk_thesis_state_id = workingStateId
    LIMIT 0,1
);
SET nextThesisId =(
    SELECT T_THESIS.pk_thesis_id
    FROM T_THESIS
	WHERE T_THESIS.pk_thesis_id > currThesisId AND T_THESIS.fk_thesis_state_id = readyStateId
    ORDER BY T_THESIS.thesis_time ASC
    LIMIT 0,1
);
UPDATE T_THESIS SET fk_thesis_state_id=endStateId, thesis_end_time=CURRENT_TIMESTAMP WHERE pk_thesis_id=currThesisId;
UPDATE T_THESIS SET fk_thesis_state_id=workingStateId, thesis_start_time=CURRENT_TIMESTAMP WHERE pk_thesis_id=nextThesisId;
END



-- ok
CREATE EVENT test2
ON SCHEDULE EVERY 30 MINUTE
STARTS '2015-10-10 00:00:00'
ON COMPLETION PRESERVE ENABLE
DO CALL proc_Z_QuestionReplaceNew_Update(5);


CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_Z_QuestionReplaceNew_Update`(IN `pageCount` INT)
    NO SQL
BEGIN
DECLARE readyStateId INT;
DECLARE workingStateId INT;
DECLARE endStateId INT;
DECLARE readyCount INT DEFAULT 0;
SET readyStateId = (
    SELECT T_STATE.pk_state_id
    FROM T_STATE
    WHERE state_type='Question' AND state_value=1
    LIMIT 0,1
);
SET workingStateId = (
    SELECT T_STATE.pk_state_id
    FROM T_STATE
    WHERE state_type='Question' AND state_value=2
    LIMIT 0,1
);
SET endStateId = (
    SELECT T_STATE.pk_state_id
    FROM T_STATE
    WHERE state_type='Question' AND state_value=3
    LIMIT 0,1
);
SET readyCount = (
    SELECT COUNT(*)
    FROM T_QUESTION
    WHERE question_usable=1 AND fk_question_state_id=readyStateId
);

IF readyCount >= pageCount THEN
UPDATE T_QUESTION SET fk_question_state_id=endStateId WHERE fk_question_state_id=workingStateId;

UPDATE T_QUESTION q, (
    SELECT *
    FROM T_QUESTION
    WHERE question_usable=1 AND fk_question_state_id=readyStateId
   	ORDER BY question_time DESC
    LIMIT 0,pageCount
)temp SET q.fk_question_state_id=workingStateId WHERE q.pk_question_id=temp.pk_question_id;
END IF;
END