<?php

require_once APPPATH . '/libraries/REST_Controller.php';

class Auth extends REST_Controller {

    public function __construct() {
        parent::__construct();
        $this->load->model('Loginapi_model');
    }

    public function login_post() {
        
        $username = $this->post('username');
        $password = $this->post('password');
        
        $invalidLogin = array ('invalid' => $username,
                               'status' => false);
        
        if(!$username || !$password) $this->response($username, REST_Controller::HTTP_NOT_FOUND);
        
        $id = $this->Loginapi_model->login($username,$password);
        $nu_rol = $this->Loginapi_model->rol($id);
        
        if($id) {
            
            $valid = array ('id' => $id,
                            'username' => $username,
                            'rol' => $nu_rol);
            
            $this->set_response($valid, REST_Controller::HTTP_OK);
        }
        else {
            $this->set_response($invalidLogin, REST_Controller::HTTP_NOT_FOUND);
        }
    }

      public function registro_post()
    {
        header("Access-Control-Allow-Origin: *");
        $_POST = json_decode($this->security->xss_clean(file_get_contents("php://input")),true);
        
        $input = $this->input->post();
        $this->db->insert('usuarios',$input);
     
        $this->response(['Usuario creado'], REST_Controller::HTTP_OK);
    } 
}