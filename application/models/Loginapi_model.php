<?php

class Loginapi_model extends CI_Model {
    
    public function __construct() {
        Parent::__construct();
    }
    
    public function login($username, $password) {
                $this->db->where('usuario',$username);
                $this->db->where('contrasena',$password);
		$query = $this->db->get('usuarios');
        if ($query->num_rows() == 1) {
            $result = $query->result();
            return $result[0]->id;
            //return $query->row();
        }
        return false;
    }
    
    public function rol($id) {
                $this->db->select('tipo');
                $this->db->from('usuarios');
                $this->db->where('id',$id);
		$query = $this->db->get();
        if ($query->num_rows() == 1) {
            $result = $query->result();
            return $result[0]->tipo;
            //return $query->row();
        }
        return false;
    }
}