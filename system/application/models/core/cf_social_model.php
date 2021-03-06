<?php
if (!defined('BASEPATH')) exit('No direct script access allowed');

class Cf_social_model extends Model {

        

	/**
	 * Constructor - Initializes and references CI
	 */
	function Cf_social_model() {
		parent::Model();
	}
	
	/**
	 * shows the number of request hatr send from logged user
	 * @param <OBJECT> $user logged in user object
	 * @return <INT> the request number
	 */
	function get_user_request_limitation($user)
        {
            $sqlCounter = "SELECT count(id) AS counter FROM `relations` WHERE `inviter` = ".$user->id.";";
            $resultCounter = $this->db->query($sqlCounter);
            $counter = $resultCounter->row()->counter;

            return $counter;
        }

	/**
	 * create a relation between 2 users
	 * @param <OBJECT> logged in user object
	 * @param <INT> guest user for relation
	 * @return <BOOL> success/failed process
	 */
	function set_user_relation($user, $guest_id)
        {

            $sql = "SELECT * FROM `relations` WHERE
                        (`inviter` = " . $this->db->escape($user->id) . " AND `guest` = " . $this->db->escape($guest_id) . ")
                        OR (`inviter` = " . $this->db->escape($guest_id) . " AND `guest` = " . $this->db->escape($user->id) . ")";

            $result = $this->db->query($sql);
            $result = $result->result_array();

            if (count($result) > 0)
                return FALSE;
            else {
                $sql = "INSERT INTO `relations` (`inviter`, `guest`, `invitation_date`, `status`)
                        VALUES (" . $this->db->escape($user->id) . ", " . $this->db->escape($guest_id) . ", '" . date('Y-m-d H:i:s') . "', '0')";
                if ($this->db->query($sql))
                    return TRUE;
                return FALSE;
            }
        }

	/**
	 * complety remove a relation between 2 users
	 * @param <OBJECT> logged in user object
	 * @param <INT> guest user for relation
	 * @return <BOOL> success/failed process
	 */
	function remove_relation($user, $guest_id)
        {
            $sql = "DELETE FROM `relations` WHERE 
                          (`inviter` = " . $this->db->escape($user->id) . "
                                AND `guest` = " . $this->db->escape($guest_id) . ")
                                    OR (`inviter` = " . $this->db->escape($guest_id) . "
                                        AND `guest` = " . $this->db->escape($user->id) . ")";

            $this->db->query($sql);
            
            if ($this->db->affected_rows()) 
                return TRUE;
            else
                return FALSE;
        }

        /**
	 * ignore or accept the friend request from another user
	 * @param <ONJECT> logged in user object
	 * @param <INT> $demandant_id the user that send request
	 * @param <BOOL> $cond true for accept request and FALSE for reject that
	 * @return <BOOL> success/failed process
	 */
        function request_apply($user, $demandant_id, $cond)
        {
            if($cond)
                $setStatus = 1;
            else
                $setStatus = 2;

            $sql = "UPDATE `relations` SET status = '".$setStatus."',
                                           answer_date = '" . date("Y-m-d H:i:s") . "'
                    WHERE `inviter` = '" . $demandant_id . "' AND `guest` = " . $this->db->escape($user->id);

            $existSql = "SELECT `id`
                         FROM `relations`
                         WHERE `guest` = " . $this->db->escape($user->id) . "
                         AND `inviter` = '" . $demandant_id ."'
						 AND `status` = 0";

            if ($this->db->query($existSql)->num_rows() && $this->db->query($sql))
                return TRUE;
            else
                return FALSE;
        }

       /**
	 * get user friends and set limitation for get or select all
	 * @param <ONJECT> logged in user object
	 * @param <INT> $limit limitation
         * @param <INT> $offset offset for begin of limitation
	 * @return <ARRAY> returned friends objects
	 */
        function get_friends($user, $limit = "",$offset = "")
        {
            if($limit)
                $limitString = " LIMIT ".$limit;
            if($offset)
                $limitString .= " OFFSET ".$offset;

            $sql = "SELECT A.id AS fake_id, B.* FROM `relations` A, `users` B
                    WHERE A.`inviter` = " . $this->db->escape($user->id) . "
                    AND B.id = A.`guest`
                    AND A.`status` = 1
                    UNION
                    SELECT A.id AS fake_id, B.* FROM `relations` A, `users` B
                    WHERE A.`guest` = " . $this->db->escape($user->id) . "
                    AND B.id = A.`inviter`
                    AND A.`status` = 1
                    ".$limitString;

            $query = $this->db->query($sql);
            $result = $query->result();

            return $result;
        }

        /**
	 * send private message from one user to another
	 * @param <INT> $from_id the message sender's id
	 * @param <INT> $to_id the message recipient's id
	 * @param <STRING> $title title of the private message
	 * @param <STRING> $body main body of the private message
	 * @param <INT> $type type and kind of pm
	 * @param <BOOL> $secure for strip all html and php tags from message content
	 * @param <STATUS> $status status of message for example add star for mess or ...
	 * @return <BOOL> success/failed process
	 */
	function send_message($from_id, $to_id, $title, $body, $type, $secure = TRUE, $status = 0)
	{
		if ($secure)
			$sql = "INSERT INTO messages (`from`, `to`, `date`, `message`,`ip`,`title`, `status` , `type`)
					VALUES(" .  $this->db->escape($from_id) . ", " .
								$this->db->escape($to_id) . ", '" .
								date("Y-m-d H:i:s") . "', " .
								$this->db->escape(strip_tags($body)) . ",'" .
								$_SERVER['REMOTE_ADDR'] . "'," .
								$this->db->escape($title) . "," .
								(int)$status . "," .
								$type .
					")";
		else
			$sql = "INSERT INTO messages (`from`, `to`, `date`, `message`,`ip`,`title`, `status`, `type`)
					VALUES(" .  $this->db->escape($from_id) . ", " .
								$this->db->escape($to_id) . ", '" .
								date("Y-m-d H:i:s") . "', " .
								$this->db->escape($body) . ",'" .
								$_SERVER['REMOTE_ADDR'] . "'," .
								$this->db->escape($title) . "," .
								(int)$status . "," .
								$type.
					")";


		if ($this->db->query($sql))
			return TRUE;
		else
			return FALSE;
	}


   /**
	 * get all user's messages or specific message with desire message id and also
    *  desire field from sender and reciever user
	 * @param <OBJECT> $from_id the message sender's id
     * @param <STRING> $tableName the name of user's table
	 * @param <STRING> $extraTable the name of user's table extra fields
	 * @param <STRING/ARRAY> one field or more field to select form sender information
	 * @param <STRING/ARRAY> one or more field selected form extra field from sender information
	 * @param <STRING/INT> $id determine fetch all message or only fetch one message with specific id
	 * @return <ARRAY> result
	 */
	function get_message($user, 
						 $userTable,
						 $extraTable,
						 $userField = 'first_name',
						 $extraField = '',
						 $id = 'all')
	{
		$this->db->select('messages.*');

		if(!is_array($userField))
			$this->db->select($userField);
		else
			$this->db->select(implode($userField, ','));

		if($extraField != "")
			if(is_array($extraField))
				$this->db->select(implode($extraField, ','));
			else
				$this->db->select($extraField);

		$this->db->from($userTable);
		$this->db->join('messages', 'messages.from = ' . $userTable . '.id');

		if($extraField != "")
			$this->db->join($extraTable, $extraTable.'.user_id = ' . $userTable . '.id');

		if($id == 'all')
			$result = $this->db->where('messages.to',$user->id)->get()->result();
		else
			if(is_int($id))
				$result = $this->db->where(array('messages.to' => $user->id, 'messages.id' => $id))->get()->row();
		
		if (count($result) > 0)
			return $result;
		else
			return FALSE;
    }

	/**
	 * get count of unreaded messages
	 * @param <OBJECT> $user the object of logged user
	 * @return <INT> count of unread messages
	 */
    function get_unread_message($user)
	{
        if (is_object($user))
            $user = $user->id;
		
        $sql = "SELECT count(id) AS counter FROM `messages` WHERE checked = 0";

        return $this->db->query($sql)->row()->counter;
    }

	/**
	 * update message check flag to read message
	 * @param <INT> $id desire id for fetch message
	 * @return <BOOL> success/failed process
	 */
	function check_readed_message($id)
	{
		$sql = "UPDATE `messages` SET checked = 1 WHERE id = " . (int) $id;
		if($this->db->query($sql))
			return TRUE;
		else
			return FALSE;
	}


	/**
	 * delete desire message with id
	 * @param <OBJECT> $user logged in user
	 * @param <INT> $id desire id for fetch message
	 * @return <BOOL> success/failed process
	 */
    function delete_message($user, $id)
	{
        $sql = "DELETE FROM `messages` WHERE `to` = " . $this->db->escape($user->id) . " AND id = " . $this->db->escape($id);
        $result = $this->db->query($sql);

        if ($result) {
            return TRUE;
        } else {
            return FALSE;
        }
    }

	/**
	 * delete all message from a user
	 * @param <OBJECT> $user logged in user
	 * @return <BOOL> success/failed process
	 */
    function delete_all_message($user) {
        $sql = "DELETE FROM `messages` WHERE `to` = " . $this->db->escape($user->id);
        $result = $this->db->query($sql);

        if ($result) {
            return TRUE;
        } else {
            return FALSE;
        }
    }
}